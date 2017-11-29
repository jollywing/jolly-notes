## dev.python.flask.environment ##
> 环境搭建

`pip install Flask`

如果没有pip，可以从官网下载get-pip.py，然后`python get-pip.py`。

## python.flask.framework ##

    from flask import Flask
    app = Flask(__name__)

    @app.route('/', methods=['GET'])
    def hello_world():
        return 'Hello World!'

    if __name__ == '__main__':
        app.run()

## python.flask.route ##

1. `@app.route('/gate')` 默认为GET方法
2. `@app.route('/gate', methods=['POST'])` POST请求
3. `@app.route('/gate', methods=['GET', 'POST'])` 能同时处理GET和POST请求
   用`if request.method == 'GET': xxx; else: yyy` 来分别处理

## python.flask.html ##

`return render_template("index.html")` `index.html`放在website的templates目录下。
