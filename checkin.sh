#pushplus的token
token="xxxxxx"
# 南航token
cookie="sign_user_token=xxxxxx;TOKEN=xxxxxx;cs1246643sso=xxxxxxx"
# 南航签到URL
csairUrl="https://wxapi.csair.com/marketing-tools/activity/join?type=APPTYPE&chanel=ss&lang=zh"
curl -H "Content-Type: application/json" -X POST -d'{"activityType": "sign","channel": "app"}' --cookie "$cookie" -s -o csair.json "$csairUrl"
# 获取南航签到响应信息中的respMsg字段
respMsg=$(jq -r '.respMsg' csair.json)
rm csair.json
echo $respMsg
pushPlusUrl="https://www.pushplus.plus/send"
# 发送请求
curl $pushPlusUrl -H "Content-Type: application/json" -X POST -s -d'{"token":"'$token'","title":"南航签到","template":"json","content":"'$respMsg'"}' 