from flask import Flask

app = Flask(__name__)

@app.route("/tospring")
def spring():
    return "tripset project"

if __name__ == '__main__':
    app.run(debug=False, host="127.0.0.1", port=5001)
