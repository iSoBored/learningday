from flask import Flask, request, jsonify, Response
import random, string

app = Flask(__name__)
token = ''.join(random.choice(string.ascii_lowercase) for i in range(8))

@app.route("/hello", methods=["GET"])
def hello():
    return "<p>Hello, World!</p>"

@app.route("/post", methods=["POST"])
def post():
    print(request.json)
    return "success"

@app.route("/data", methods=["GET"])
def data():
     if request.headers.get("Authorization") != f"Bearer {token}":
        return Response(status=403)
     
     return "supersecretdata"

@app.route("/auth", methods=["POST"])
def auth():
    creds = request.json
    if creds["username"] == "admin" and creds["password"] == "password":
        response = {"token": f"{token}"}
        return jsonify(response)
    
    return Response(status=403)

@app.route("/logout", methods=["GET"])
def logout():
    global token
    if request.headers.get("Authorization") != f"Bearer {token}":
        return Response(status=403)
    
    token = ''.join(random.choice(string.ascii_lowercase) for i in range(8))
    return "logged out"

if __name__ == '__main__':
      app.run(host="0.0.0.0", port=80, debug=True)
