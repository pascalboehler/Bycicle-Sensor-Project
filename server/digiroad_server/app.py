from flask import Flask
from flask import jsonify

app = Flask(__name__)


@app.route('/')
def hello_world():
    json_data = {
        "status": "running",
        "uptime": "20 sec"
    }
    return json_data, 200


# log in to service to receive session token
@app.route('/auth/login')
def login():
    json_response = {
        "token": "YOURUNIQUESESSIONTOKEN"
    }
    return json_response, 200


# sign up for service
@app.route('/auth/signup', methods=['POST'])
def signup():
    json_response = {
        "token": "YOURUNIQUESESSIONTOKEN"
    }
    return json_response, 200


# USER DATA SPECIFIC STUFF:

# get all user data from server (session token needs to be provided as an argument)
@app.route('/data/userData')
def user_data():
    json_response = [
        {
            "dataId": 4,
            "sensor": 1,
            "distance": 255,
            "position": {
                "lon": -73.989308,
                "lat": 40.741895
            },
            "timestamp": 120520201455,
            "tripNumber": 4
        },
        {
            "dataId": 5,
            "sensor": 1,
            "distance": 255,
            "position": {
                "lon": -73.989308,
                "lat": 40.741895
            },
            "timestamp": 120520201455,
            "tripNumber": 4
        },
    ]

    return jsonify(json_response), 200


# get data from specific trip (session token and trip id need to provided as arguments)
@app.route('/data/userData/tripData')
def trip_data():
    json_response = [
        {
            "dataId": 4,
            "sensor": 1,
            "distance": 255,
            "position": {
                "lon": -73.989308,
                "lat": 40.741895
            },
            "timestamp": 120520201455,
            "tripNumber": 4
        }
    ]
    return jsonify(json_response), 200


# get list of all trips with trip name and trip id (session token needs to be provided)
@app.route('/data/userData/trips')
def trips():
    json_response = [
        {
            "tripId": 4,
            "tripName": "Biketour"
        }
    ]
    return jsonify(json_response), 200


# create a new trip on server (session token needs to be provided)
@app.route('/data/userData/trip', methods=['POST'])
def create_trip():
    json_response = {
        "success": True
    }
    return jsonify(json_response), 200


if __name__ == '__main__':
    app.run(host="0.0.0.0")
