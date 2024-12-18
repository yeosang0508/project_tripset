from dotenv import load_dotenv
import os

# .env 파일 로드
load_dotenv()

# 환경 변수 불러오기
api_key = os.getenv("OpenAI_KEY")
print(api_key)  # API 키 출력 확인
