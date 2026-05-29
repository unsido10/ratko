from flask import Flask
import os

app = Flask(__name__)

@app.route('/')
def health():
    return "OK"

if __name__ == '__main__':
    # Используем порт из переменной окружения PORT, если он есть
    port = int(os.environ.get("PORT", 10000))
    app.run(host='0.0.0.0', port=por
            t)
