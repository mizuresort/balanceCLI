#!/bin/sh

#収支管理CLI
#1. 入力を受け取る
#2. 保存先のファイルを決める
#3. 処理の分岐

    #add 引数をcsv（日付、レース、収支）で1行追加する
    #list ファイルをそのまま読み取って表示する
    #summary 1行ずつ読み込んで収支の合計と件数を計算する
    #拡張したい
    #search レース場などで絞り込み。おそらくgrepとか

#ファイルの保存先
FILE="$HOME/keiba.txt"




#処理の関数定義

add() {
    echo "日付を入力してください。（例：2000-12-24）"
    read date #標準入力を変数dateに入れている。

    echo 'レース名を入力してください。（例："中山 9R"）かならず""をつけてください。'
    read race
     
    echo "収支を入力してください。(例：+1200)"
    read money

    echo "$date $race $money" >> "$FILE"
    echo "追加しました。:$date $race $money"

}

list() {
    if [ -f "$FILE" ]
    then
        cat "$FILE"
    else
        echo "まだ記録されてません。"
    fi

}

summary() {
    sum=0
    count=0

    while read date race money; do
        sum=$((sum+money))
        count=$((count+1))
    done < "$FILE"

    echo "合計収支: $sum 円"
    echo "件数: $count 回"

}

#コマンド分岐

case "$1" in
    add) add ;;
    list) list ;;
    summary) summary;;
    *) echo "使い方: $0 {add|list|summary}";;
esac