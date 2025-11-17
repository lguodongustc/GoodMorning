#!/bin/bash

# 设置环境变量
export PYTHONPATH=/usr/local/lib/python3.9/site-packages

# 安装依赖
pip3 install -r requirements.txt

# 运行程序
python3 main.py