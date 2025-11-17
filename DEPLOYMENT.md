# Lighthouse 部署指南

## 项目概述

这是一个微信公众号每日推送服务，主要功能包括：
- 获取指定城市的天气信息
- 计算生日倒计时
- 发送每日英语金句
- 向指定的微信用户推送模板消息

## 配置信息

已配置的微信信息：
- APP_ID: `wx2463d50c47a17f08`
- APP_SECRET: `7f440161d9a6f01b13794ff6066079e9`
- TEMPLATE_ID: `6qLvtRVnm7zivN9_3tZDVHqqwsWDStm-jjEbAJYXXpU`

## 在腾讯云Lighthouse上部署

### 1. 准备服务器

1. 购买腾讯云Lighthouse实例（推荐使用Ubuntu 20.04或更高版本）
2. 通过SSH连接到服务器

### 2. 上传文件

将项目文件上传到服务器：
```bash
scp -r d:/test/GoodMorning/* root@你的服务器IP:/root/GoodMorning/
```

### 3. 安装依赖

```bash
# 更新系统
apt update && apt upgrade -y

# 安装Python3和pip
apt install python3 python3-pip -y

# 进入项目目录
cd /root/GoodMorning

# 安装Python依赖
pip3 install -r requirements.txt
```

### 4. 配置定时任务

设置每日定时执行（建议在早上8点执行）：

```bash
# 编辑定时任务
crontab -e

# 添加以下内容（每天早上8点执行）
0 8 * * * cd /root/GoodMorning && python3 main.py

# 或者如果你想测试，可以设置每分钟执行一次
* * * * * cd /root/GoodMorning && python3 main.py
```

### 5. 测试运行

```bash
cd /root/GoodMorning
python3 main.py
```

如果一切正常，你应该看到"推送消息成功"的输出。

## 配置说明

### 修改配置文件

编辑 `config.json` 文件来定制你的推送内容：

```json
{
    "app_id": "wx2463d50c47a17f08",
    "app_secret": "7f440161d9a6f01b13794ff6066079e9",
    "template_id": "6qLvtRVnm7zivN9_3tZDVHqqwsWDStm-jjEbAJYXXpU",
    "user": [
        "你的微信OpenID1",
        "你的微信OpenID2"
    ],
    "province": "省份",
    "city": "城市",
    "birthday1": {
        "name": "姓名1",
        "birthday": "生日日期"
    },
    "birthday2": {
        "name": "姓名2", 
        "birthday": "生日日期"
    },
    "love_date": "纪念日"
}
```

### 获取微信OpenID

1. 在微信公众平台配置服务器
2. 让用户关注你的公众号
3. 通过开发工具获取用户的OpenID

## 故障排除

### 常见问题

1. **依赖安装失败**：检查Python版本，确保是Python 3.6+
2. **推送失败**：检查微信配置信息是否正确，模板ID是否有效
3. **天气获取失败**：检查城市名称是否正确，网络连接是否正常

### 日志查看

程序运行日志会输出到控制台，可以通过以下方式查看：
```bash
# 查看最近的定时任务执行日志
tail -f /var/log/syslog | grep CRON

# 手动运行并查看输出
cd /root/GoodMorning && python3 main.py
```

## 安全建议

1. 定期更新服务器系统和Python包
2. 使用强密码保护服务器访问
3. 定期备份配置文件
4. 监控服务器资源使用情况