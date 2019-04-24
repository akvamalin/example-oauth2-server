#!/bin/bash
git clone https://github.com/akvamalin/example-oauth2-server.git
cd example-oauth2-server
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py --force-reinstall
pip3 install -r requirements.txt --user
export AUTHLIB_INSECURE_TRANSPORT=1
export LC_ALL=C.UTF-8
export LANG=C.UTF-8
flask initdb
flask run --host=0.0.0.0 --port=8080