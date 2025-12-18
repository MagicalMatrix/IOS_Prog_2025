from flask import Flask, jsonify, request

app = Flask(__name__)

#data creation

categories = [
    {
        'id': 1,
        'name': 'nabial'
    },
    {
        'id': 2,
        'name': 'owoce'
    }
]

products = [
    {
        'id': 1,
        'name': 'maslo klarowane',
        'price': 28.99,
        'desc': 'najlepsze do smarowania',
        'category_id': 1
    },
    {
        'id': 1,
        'name': 'mleko UHT',
        'price': 4.59,
        'desc': 'kazdy pije mleko z kawa',
        'category_id': 1
    },
    {
        'id': 1,
        'name': 'banany kisc',
        'price': 6.99,
        'desc': 'dla wszystkich, szczegolnie dla siebie',
        'category_id': 2
    }
]

#data handling

@app.route('/categories', methods=['GET'])
def get_categories():
    return jsonify(categories)
    
@app.route('/products', methods=['GET'])
def get_products():
    return jsonify(products)

if __name__ == '__main__':
    app.run(debug=True)
