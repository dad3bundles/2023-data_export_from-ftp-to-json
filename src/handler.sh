#! /bin/bash

mkdir -p ./data/archive

curl --user usr300:Ftp20Nov\!\@30hi ftp://77.91.121.70/Remains.xml -o ./data/remains.xml

TITLE="remains $(grep -Po '<!\-\-Дата выгрузки остатков: \K[^\->]+' ./data/remains.xml)"

./node_modules/.bin/xml-js ./data/remains.xml > "./data/remains.json"

cp ./data/remains.xml "./data/archive/$TITLE.xml"
cp ./data/remains.json "./data/archive/$TITLE.json"

s3cmd sync ./data s3://ftp-to-json

poweroff
