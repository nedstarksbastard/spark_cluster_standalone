import os
import subprocess
from flask import Flask, render_template, request, Response
app = Flask(__name__)

@app.route("/submission" , methods=['POST'])
def run_spark():
    select = request.form.get('jobs')

    def inner():
        proc = subprocess.Popen(
            ['python', os.path.join(os.getcwd(), "pysprk_jobs", f"{select}")],
            shell=False,
            stdout=subprocess.PIPE,
            universal_newlines=True
        )

        for line in iter(proc.stdout.readline, ''):
            yield line.rstrip() + '<br/>\n'

    return Response(inner(), mimetype='text/html')


@app.route("/")
def hello():
    files = os.listdir(os.path.join(os.getcwd(), "pysprk_jobs"))
    return render_template('spark_jobs.html', jobs=files)


if __name__ == "__main__":
    app.run()