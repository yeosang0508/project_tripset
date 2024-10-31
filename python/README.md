# tripset 환경 설정 및 실행 가이드 (VSCode)

## 1. 경로 설정

터미널에서 프로젝트 디렉터리로 이동

```bash
cd C:\work_ssa\sts-4.24.0.RELEASE-workspace-1\project_tripset\python
```

## 2. 가상 환경 생성 및 활성화

Python 가상 환경을 생성한 후 활성화합니다.

```bash
python -m venv venv # 가상 환경 생성

.\venv\Scripts\activate # 가상 환경 활성화
```

## 3. 필수 패키지 설치

가상 환경 안에서 필요한 라이브러리들을 설치합니다.

```bash
# Flask 설치 (웹 프레임워크)
pip install flask

# Flask-CORS 설치 (CORS 문제 해결을 위한 라이브러리)
pip install flask-cors

# OpenAI 설치 (OpenAI API 사용을 위한 라이브러리)
pip install openai

# python-dotenv 설치 (.env 파일의 환경 변수 로딩을 위한 라이브러리)
pip install python-dotenv

```

## 4. pip 업그레이드 (경고 발생 시)

패키지 설치 중 WARNING 메시지가 발생하면 pip를 업그레이드 한다.

```bash
C:\work_ssa\sts-4.24.0.RELEASE-workspace-1\project_tripset\python\venv\Scripts\python.exe -m pip install --upgrade pip
```

## 5. 프로그램 실행

필수 패키지 설치가 완료되면 다음 명령어로 main.py 파일을 실행합니다.

```bash
python main.py
```

## 6. 문제 해결

ModuleNotFoundError 오류가 발생할 경우:

- 가상 환경이 활성화되었는지 확인하고, 가상 환경이 비활성화되었다면 다시 활성화하세요.

```bash
.\venv\Scripts\activate  # Windows
```

API 키 설정 :

- OpenAI API를 사용하려면 `.env` 파일에 다음과 같이 API 키를 설정한다.

```python
OpenAI_KEY = your-openai-api-key
```
