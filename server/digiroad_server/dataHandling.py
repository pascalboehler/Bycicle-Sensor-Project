def get_user_data(token):
    data = [
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
    return data


def get_trip_data(token):
    data = [
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
    return data


def get_trips(token):
    data = [
        {
            "tripId": 4,
            "tripName": "Biketour"
        }
    ]

    return data

def create_trip(data):
    print("Created!")