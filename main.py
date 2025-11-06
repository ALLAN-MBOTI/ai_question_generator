import os
import json
import time
from datetime import datetime, timezone

from flask import Flask, request, jsonify
# Note: For deployment in a real Google Cloud Function,
# you would import firebase_admin and google.cloud.firestore.
# For this example, we'll use placeholder imports and function calls.

# ----------------------------------------------------------------------
# SERVER CONFIGURATION AND MOCK SETUP
# ----------------------------------------------------------------------

# NOTE: In a real Cloud Function environment, environment variables
# would securely handle API keys and project IDs.
GEMINI_API_KEY = os.environ.get("GEMINI_API_KEY", "")

app = Flask(__name__)

# Mock Firestore/Firebase setup for a self-contained environment
def initialize_firestore_and_auth():
    """Mocks Firebase/Firestore initialization."""
    # In a real Python environment, this is where you'd initialize the SDKs.
    # from firebase_admin import initialize_app, firestore
    # initialize_app()
    # db = firestore.client()
    # return db
    return "MOCK_DB_CLIENT"

DB = initialize_firestore_and_auth()
PERFORMANCE_COLLECTION = "performance_reports"

# ----------------------------------------------------------------------
# HELPERS & UTILITIES
# ----------------------------------------------------------------------

def authenticate_user(req):
    """
    Mocks Firebase Auth token verification.
    In a real app, this would decode the 'Authorization: Bearer <token>' header.
    """
    auth_header = req.headers.get('Authorization')
    if not auth_header or not auth_header.startswith('Bearer '):
        # Fallback for testing/unauthenticated access
        return {"uid": "mock-unauthenticated-user-123"} 
    
    # For a real implementation, you would use:
    # from firebase_admin import auth
    # token = auth_header.split(' ')[1]
    # decoded_token = auth.verify_id_token(token)
    # return {"uid": decoded_token['uid']}
    
    # MOCK implementation: just return a predictable ID if a token is present
    return {"uid": "mock-authenticated-user-456"}

def call_gemini_api_with_structured_output(user_query, schema):
    """
    Handles the API call to Gemini with structured JSON output.
    Uses the gemini-2.5-flash-preview-09-2025 model.
    """
    if not GEMINI_API_KEY:
        # Provide a mock response if no API key is set (for local testing)
        print("WARNING: Using mock AI response. Set GEMINI_API_KEY for real API calls.")
        return [
            {
                "id": f"q{i}",
                "questionText": f"What is the core concept of {user_query}?",
                "options": ["A", "B", "C", "The correct answer"],
                "correctAnswer": "The correct answer",
                "explanation": "This is a mock explanation for the core concept."
            } for i in range(1, 6)
        ]

    # API configuration details
    api_url = f"https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash-preview-09-2025:generateContent?key={GEMINI_API_KEY}"
    
    system_instruction = (
        "You are an expert educational content generator. "
        "Your task is to generate a list of questions that strictly adheres to the provided JSON schema. "
        "Do not include any text outside the JSON object."
    )

    payload = {
        "contents": [{"parts": [{"text": user_query}]}],
        "systemInstruction": {"parts": [{"text": system_instruction}]},
        "generationConfig": {
            "responseMimeType": "application/json",
            "responseSchema": schema
        },
    }

    headers = {'Content-Type': 'application/json'}

    # Use a simple fetch/requests library here. 
    # Since we cannot use external libraries in this environment, 
    # this part is conceptual, but this is the correct structure.
    import requests
    response = requests.post(api_url, headers=headers, data=json.dumps(payload))
    response.raise_for_status()

    result = response.json()
    
    # Safely parse the structured JSON response
    text_part = result.get('candidates', [{}])[0].get('content', {}).get('parts', [{}])[0].get('text', '{}')
    
    try:
        # The AI returns a JSON string, which must be parsed
        return json.loads(text_part)
    except json.JSONDecodeError as e:
        print(f"Error decoding AI response: {e}")
        print(f"Raw AI response text: {text_part}")
        return []

def get_quiz_json_schema(num_questions):
    """Defines the JSON Schema for the structured quiz output."""
    question_object = {
        "type": "OBJECT",
        "properties": {
            "id": {"type": "STRING", "description": "A unique short identifier for the question (e.g., q1)."},
            "questionText": {"type": "STRING", "description": "The full text of the question."},
            "options": {"type": "ARRAY", "items": {"type": "STRING"}, "description": "Four possible answers, exactly one of which is correct."},
            "correctAnswer": {"type": "STRING", "description": "The text of the correct answer, which must match one of the options."},
            "explanation": {"type": "STRING", "description": "A brief explanation of why the correct answer is right."}
        },
        "required": ["id", "questionText", "options", "correctAnswer", "explanation"]
    }

    return {
        "type": "ARRAY",
        "items": question_object,
        "description": f"A list of exactly {num_questions} Multiple Choice questions."
    }

# ----------------------------------------------------------------------
# API ENDPOINTS (FLASK ROUTES)
# ----------------------------------------------------------------------

@app.route("/api/v1/generate-quiz", methods=["POST"])
def generate_quiz():
    """Endpoint to generate a structured quiz using the Gemini API."""
    try:
        data = request.get_json()
        topic = data.get("topic")
        grade_level = data.get("gradeLevel")
        num_questions = int(data.get("numQuestions", 5))
        question_type = data.get("questionType", "Multiple Choice")

        if not topic:
            return jsonify({"error": "Missing 'topic' field."}), 400
        
        # 1. Prepare the user prompt for the LLM
        prompt = (
            f"Generate exactly {num_questions} {question_type} questions "
            f"about the topic: '{topic}'. The target audience is at a '{grade_level}' level."
            f"The response must STRICTLY be a JSON array of question objects."
        )

        # 2. Define the JSON schema for structured output
        schema = get_quiz_json_schema(num_questions)

        # 3. Call the AI service
        questions_list = call_gemini_api_with_structured_output(prompt, schema)

        if not questions_list:
            return jsonify({"error": "Failed to generate structured quiz content from AI."}), 500

        # 4. Return the structured quiz data
        return jsonify(questions_list), 200

    except Exception as e:
        print(f"Error in generate_quiz: {e}")
        return jsonify({"error": "Internal Server Error during quiz generation."}), 500


@app.route("/api/v1/save-performance", methods=["POST"])
def save_performance():
    """Endpoint to save a student's performance report to Firestore."""
    try:
        user_info = authenticate_user(request)
        user_id = user_info.get("uid")

        if not user_id:
            return jsonify({"error": "Authentication failed."}), 401

        report_data = request.get_json()
        
        # Validation (Basic)
        if not report_data or not report_data.get('score'):
            return jsonify({"error": "Invalid performance data."}), 400

        # Add server-side fields
        report_data['studentId'] = user_id # Override/ensure correct ID
        report_data['date'] = datetime.now(timezone.utc).isoformat()
        
        # MOCK Firestore Operation:
        # In a real app, this would be:
        # doc_ref = DB.collection(PERFORMANCE_COLLECTION).add(report_data)
        # record_id = doc_ref.id
        record_id = f"perf-server-{int(time.time())}" 
        
        print(f"MOCK: Saved performance for {user_id} with ID: {record_id}")
        
        return jsonify({
            "status": "success",
            "message": "Performance record saved.",
            "recordId": record_id
        }), 201

    except Exception as e:
        print(f"Error in save_performance: {e}")
        return jsonify({"error": "Internal Server Error while saving performance."}), 500


@app.route("/api/v1/performance-history", methods=["GET"])
def get_performance_history():
    """Endpoint to retrieve a user's performance history from Firestore."""
    try:
        user_info = authenticate_user(request)
        user_id = user_info.get("uid")

        if not user_id:
            return jsonify({"error": "Authentication required."}), 401

        # MOCK Firestore Operation:
        # In a real app, this would be:
        # query = DB.collection(PERFORMANCE_COLLECTION).where('studentId', '==', user_id).order_by('date', direction='DESCENDING')
        # docs = [doc.to_dict() for doc in query.stream()]
        
        # MOCK Data Response:
        mock_history = [
            {
                "id": "perf-a1",
                "studentId": user_id,
                "studentName": "Mock User",
                "date": datetime.now(timezone.utc).isoformat(),
                "topic": "Photosynthesis Fundamentals",
                "totalQuestions": 5,
                "score": 4,
                "details": []
            },
            {
                "id": "perf-b2",
                "studentId": user_id,
                "studentName": "Mock User",
                "date": (datetime.now(timezone.utc) - timedelta(days=1)).isoformat(),
                "topic": "Newton's Laws of Motion",
                "totalQuestions": 10,
                "score": 9,
                "details": []
            }
        ]
        
        return jsonify(mock_history), 200

    except Exception as e:
        print(f"Error in get_performance_history: {e}")
        return jsonify({"error": "Internal Server Error while retrieving history."}), 500


# The Cloud Function entry point
def ai_quiz_backend(request):
    """
    Entry point for the Google Cloud Function.
    This routes the incoming request to the Flask app.
    """
    with app.app_context():
        # This allows Flask to handle the request from the Cloud Function environment
        return app.full_dispatch_request()

# NOTE: The last function `ai_quiz_backend` is the function you would set as the
# entry point when deploying this to Google Cloud Functions.