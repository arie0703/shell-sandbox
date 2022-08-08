#!/bin/bash

source ./.env
# 引数に参照したいページIDに対応する環境変数名を記述
arg=$@
response=`curl "https://api.notion.com/v1/blocks/${!arg}/children" \
-H "Authorization: Bearer $NOTION_SECRET_TOKEN" \
-H 'Notion-Version: 2022-06-28'`
result=`echo $response | jq ".results"`
length=`echo $result | jq "length"`

for i in $(seq 0 $(($length - 1)) ); do
    echo $result | jq ".[$i].paragraph.rich_text[].text.content";
done