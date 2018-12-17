from flask import Flask, Response
app = Flask(__name__)


from keras.models import load_model
# clf = load_model('model.h5')


@app.route('/ping', methods=['GET'])
def ping():
    """
    Determine if the container is healthy.
    """
    status = 200
    return Response(response='\n', status=status, mimetype='application/json')


@app.route('/invocations', methods=['POST'])
def predict():
    """
    Do an inference on a single batch of data.
    """
    return Response(response='a,b,c', status=200, mimetype='text/csv')
