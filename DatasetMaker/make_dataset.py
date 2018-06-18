#!/usr/bin/env python
# -*- coding: utf-8 -*-

from bottle import route, run, get, post, request, static_file
from bottle import TEMPLATE_PATH, jinja2_template as template
import os, bottle, pickle, json

@get('/')
def index():
    return template('index')

def check_name(username):
    # Load Users List
    with open("user_list.txt","r", encoding="utf-8")as f:
        users = f.read().split()
        
    # 入力された名前がusersに存在するかチェック
    if username in users:
        return True
    else:
        return False
    
@post('/top') # loop
def make_dataset():
    # get username
    req_params = json.load(request.body)
    username = req_params.get('username', None)
    filename = f'dataset/{username}.txt'
    
    # get value
    # 0: 真っ当なリプ, 1:状況による, 2:紛う事なきクソリプ
    values = req_params.get('value', -1)

    if values in [0, 1, 2]:
        if check_name(username):
            with open(filename, "a", encoding="utf-8")as f:
                f.write(f'{values}\n')
    
    # init, if username -> load
    if check_name(username):
        if os.path.isfile(filename):
            with open(filename, "r", encoding="utf-8")as f:
                cnt = len(f.read().split())
        else:
            cnt = 0
    else:
        with open("user_list.txt", "a", encoding="utf-8")as f:
            f.write(f'{username}\n')
        cnt = 0
    
    return json.dumps({'tweet':tweets[cnt], 'reply':replys[cnt]})


if __name__ == '__main__':
    filename_tweet = "../corpus/dataset_U.pkl"
    filename_reply = "../corpus/dataset_R.pkl"
    
    with open(filename_tweet, "rb")as f:
        tweets = pickle.load(f)
    with open(filename_reply, "rb")as f:
        replys = pickle.load(f)   
    
    run(host='0.0.0.0', port=8801, debug=False, reloader=False)
