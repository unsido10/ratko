from flask import Flask
import os

app = Flask(__name__)

@app.route('/')
def health():
    return "OK", 200

if __name__ == '__main__':
    # Обязательно слушаем 0.0.0.0 и порт, который дает Render
    port = int(os.environ.get("PORT", 10000))
    app.run(host='0.0.0.0', port=port)
