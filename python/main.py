from flask import Flask, request, jsonify
from flask_cors import CORS
from openai import OpenAI
import os
from dotenv import load_dotenv

app = Flask(__name__)
CORS(app)

# .env 파일에서 환경 변수 로드
load_dotenv()

# OpenAI API 키 설정

client = OpenAI(
    api_key = os.getenv("FLASK_API_KEY")
)

@app.route("/api/text", methods=["POST"])
def TextMassageMaker():    
    input_data = request.get_json()
    
    # 요청에서 입력된 값을 추출
    question = input_data.get("question", "No question provided")

    # 최신 ChatCompletion API 호출
    response = client.chat.completions.create(
         model="gpt-3.5-turbo",
        messages=[
            {"role": "system", "content": "너는 문자를 작성하는 문자 마법사이다. 조건에 맞게 문자를 최대한 길게 작성하라."},
            {"role": "user", "content": f"사용자가 묻는 질문: {question}"}
        ],
        temperature=0.7,
        max_tokens=100
    )

    message_result = response.choices[0].message.content

    return jsonify({"result": message_result})

if __name__ == '__main__':
    app.run(host='127.0.0.1', debug=True, port=5001)
