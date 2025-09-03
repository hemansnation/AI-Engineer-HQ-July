from flask import Flask, jsonify, request

app = Flask(__name__)

@app.route('/')
def home():
    return "Welcome to the Flask API!"

def analyze_sentiment(text):
    if "happy" in text.lower() or "good" in text.lower():
        return {"label": "positive", "score": 0.9}
    elif "sad" in text.lower() or "bad" in text.lower():
        return {"label": "negative", "score": 0.9}
    else:
        return {"label": "neutral", "score": 0.5}

@app.route('/predict', methods=['POST'])
def predict():
    data = request.get_json()
    if not data or 'text' not in data:
        return jsonify({"error": "Missing text"}), 400
    
    text_to_analyze = data['text']

    prediction = analyze_sentiment(text_to_analyze)

    return jsonify(prediction)



if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0' ,port=5000)