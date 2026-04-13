from flask import Flask, jsonify, request
from datetime import datetime, timezone

app = Flask(__name__)


@app.route("/", methods=["GET"])
def get_time_and_ip():
    forwarded_for = request.headers.get("X-Forwarded-For", "")
    if forwarded_for:
        visitor_ip = forwarded_for.split(",")[0].strip()
    else:
        visitor_ip = request.remote_addr or "unknown"

    return jsonify({
        "timestamp": datetime.now(timezone.utc).isoformat(),
        "ip": visitor_ip
    })


if __name__ == "__main__":
    app.run(host="127.0.0.1", port=8080)