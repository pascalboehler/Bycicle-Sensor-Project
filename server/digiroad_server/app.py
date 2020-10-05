# external dependencies
from flask import Flask
from flask import jsonify
from flask import request
import json

# custom classes:
from userHandling import *
from dataHandling import *

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
    # get request data from client and convert it to json:
    req_raw_data = request.data
    req_data = json.loads(req_raw_data)
    # write new user to database
    token = create_user(req_data)
    json_response = {
        "token": token
    }
    return json_response, 200


# USER DATA SPECIFIC STUFF:

# get all user data from server (session token needs to be provided as an argument)
@app.route('/data/userData')
def user_data():
    req_data = json.loads(request.data)
    json_response = get_user_data(req_data['token'])

    return jsonify(json_response), 200


# get data from specific trip (session token and trip id need to provided as arguments)
@app.route('/data/userData/tripData')
def trip_data():
    req_data = json.loads(request.data)
    json_response = get_trip_data(req_data['token'])
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
def create_trip_data():
    req_data = json.loads(request.data)
    create_trip(req_data)
    json_response = {
        "success": True
    }
    return jsonify(json_response), 200


if __name__ == '__main__':
    app.run(host="0.0.0.0")
