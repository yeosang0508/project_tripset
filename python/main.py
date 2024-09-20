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
    who = input_data.get("who", "No who provided")
    how = input_data.get("how", "No how provided")
    time = input_data.get("time", "No time provided")
    style = input_data.get("style", "No style provided")
    region = input_data.get("region", "No region provided")


    # 최신 ChatCompletion API 호출
    response = client.chat.completions.create(
         model="gpt-3.5-turbo",
        messages=[
            {"role": "system", "content": "너는 한국 여행 전문 플래너야, 여행객들에게 맞춤형 여행 일정을 추천해야해"},
            {"role": "user", "content": "여행 일정을 계획하고 싶어, "},
            {"role": "user", "content": f"여행은 {who} 가고"},
            {"role": "user", "content": f"여행 기간은 {how}"},
            {"role": "user", "content": f"선호하는 일정은 {time}"},
            {"role": "user", "content": f"여행 스타일은 {style}"},
            {"role": "user", "content": f"선호하는 지역은 {region}"},
            {"role": "user", "content": "위의 정보를 참고하고, 네이버에 검색했을 때 가장 조회수가 많은 장소로 추천해주고, 장소의 자세한 주소만 10개 제안하고, '장소 이름:' 으로 장소 이름만 보내"}
        ],
        temperature=0.7,
        max_tokens=1000
    )

    print("API 응답 수신")
    print("OpenAI Response:", response)

    message_result = response.choices[0].message.content

    locations = parse_text_to_json(message_result)

    return jsonify({"result": locations})

def parse_text_to_json(text):
    locations = [] # 각 장소 정보를 저장할 리스트
    location = None  # location 변수를 초기화
    lines = text.split("\n")

    for line in lines:
        line = line.strip()  # 각 줄의 앞뒤 공백을 제거
        if "장소 이름:" in line:  
            if location:  # 이전 location이 존재하면 리스트에 추가
                locations.append(location)
            location_name = line.replace("장소 이름:", "").strip()
            location = {"name": location_name}  # 새로운 location 객체 생성
        else:
            continue

    if location:  # 마지막 location이 존재하면 리스트에 추가
        locations.append(location)
        
    return locations


if __name__ == '__main__':
    app.run(host='127.0.0.1', debug=True, port=5001)
