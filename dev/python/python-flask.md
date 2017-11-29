## dev.python.flask.environment ##
> �����

`pip install Flask`

���û��pip�����Դӹ�������get-pip.py��Ȼ��`python get-pip.py`��

## python.flask.framework ##

    from flask import Flask
    app = Flask(__name__)

    @app.route('/', methods=['GET'])
    def hello_world():
        return 'Hello World!'

    if __name__ == '__main__':
        app.run()

## python.flask.route ##

1. `@app.route('/gate')` Ĭ��ΪGET����
2. `@app.route('/gate', methods=['POST'])` POST����
3. `@app.route('/gate', methods=['GET', 'POST'])` ��ͬʱ����GET��POST����
   ��`if request.method == 'GET': xxx; else: yyy` ���ֱ���

## python.flask.html ##

`return render_template("index.html")` `index.html`����website��templatesĿ¼�¡�
