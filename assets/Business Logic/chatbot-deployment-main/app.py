from flask import Flask, render_template , request , jsonify
from chat import get_response
#import time

app = Flask(__name__)

@app.get("/")
def index_get():
    return render_template("base.html")

@app.post("/predict")
def predict():
    text = request.get_json().get("message")
    response = get_response(text)
    message = {"answer": response}
    #time.sleep(2)
    return jsonify(message)

if __name__ == "__main__":
    app.run(debug=True)
