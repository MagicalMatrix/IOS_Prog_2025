from flask import Flask, jsonify, request
import bcrypt

app = Flask(__name__)

seed = b'$2b$12$zzS46iSXYpX9lPRPO3PQf.'

#data creation

#for the sake of assigment: text version of password is: "admin"
users = [
    {
        'username': 'admin',
        'password': '$2b$12$zzS46iSXYpX9lPRPO3PQf.vm2Xu6j/IIh0cUkD7oTOMKtp.NTUqs.'
    }
]


@app.route('/login', methods=['POST'])
def login():
    loginData = request.get_json()
    loginUsername = loginData.get('username')
    loginPassword = loginData.get('password')
    
    for user in users:
        if loginUsername == user['username']:
            if bcrypt.checkpw(bytes(loginPassword, 'utf-8'), bytes(user['password'], 'utf-8')):
                return jsonify({"username": user['username']})
            else:
                return jsonify({"message": "incorrect password"}), 401
                
    return jsonify({"message": "username does not exist"}), 400


if __name__ == '__main__':
    app.run(debug=True)
