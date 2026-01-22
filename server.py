from flask import Flask, jsonify, request
from datetime import datetime

app = Flask(__name__)

def LuthsAlgorithm(digits):
    result = 0
    for i in range(0, len(digits)):
        if i % 2 == 0:
            added = digits[i] * 2
            if added >= 10:
                added = 1 + (added - 10)
            result += added
        else:
            result += digits[i]
    return result


@app.route('/login', methods=['POST'])
def Pay():
    paymentData = request.get_json()
    cardNumber = list(map(int, paymentData['cardNumber']))
    cvv = list(map(int, paymentData['cvv']))
    expirationDate = paymentData['expirationDate']
    
    #card number of impossible length
    if len(cardNumber) < 8 or len(cardNumber) > 19:
        print("invalid number length")
        return jsonify({"message": "incorrect card number"}), 401
    
    #card number not checks luth algorithm so it is invalid
    if LuthsAlgorithm(cardNumber) % 10 != 0:
        print("luths algorithm wrong result")
        return jsonify({"message": "incorrect card number"}), 401
        
    #cvv of impossible length
    if len(cvv) < 3 or len(cvv) > 4:
        print("cvv wrong length")
        return jsonify({"message": "incorrect card number"}), 401
        
    #add check for expiration date later
    if len(expirationDate) != 4:
        print("expiration wrong length")
        return jsonify({"message": "incorrect card number"}), 401
    else:
        month = int(expirationDate[0:2])
        year = int(expirationDate[2:4])
        if month > 12:
            print("wrong month")
            return jsonify({"message": "incorrect expiration date"}), 401
        if year + 2000 < datetime.now().year:
            print("card expired (year)")
            return jsonify({"message": "card expired"}), 401
        elif year + 2000 == datetime.now().year and month < datetime.now().month:
            print("card expired (month)")
            return jsonify({"message": "card expired"}), 401
    
    #if no errors catched simulate succeded payment
    return jsonify({"message": "payment succeded"})

if __name__ == '__main__':
    app.run(debug=True)
