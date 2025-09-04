from flask import Flask, jsonify, request, render_template
from werkzeug.utils import secure_filename
from resume_parser import ResumeParser
from utils import extract_text_from_pdf
import os

app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = 'uploads'
app.config["MAX_CONTENT_LENGTH"] = 16 * 1024 * 1024  # 16 MB limit

os.makedirs(app.config['UPLOAD_FOLDER'], exist_ok=True)

parser = ResumeParser()

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/upload', methods=['POST'])
def upload_resume():
    if "resume" not in request.files:
        return render_template('error.html', message="No file part in the request")
    
    file = request.files['resume']
    if file.filename == '':
        return render_template('error.html', message="No selected file")
    
    if file and file.filename.endswith('.pdf'):
        filename = secure_filename(file.filename)
        filepath = os.path.join(app.config['UPLOAD_FOLDER'], filename)
        file.save(filepath)
        
        text = extract_text_from_pdf(filepath)
        if text.startswith("Error"):
            return render_template('error.html', message=text)
        
        entities = parser.extract_entities(text)
        score_data = parser.score_resume(entities)

        os.remove(filepath)

        return render_template('results.html', entities=entities, score_data=score_data[0], matched_skills=score_data[1])
    
    return render_template('error.html', message="Invalid file type. Please upload a PDF file.")

if __name__ == '__main__':
    app.run(debug=True)