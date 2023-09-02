#! /bin/bash

mkdir -p ./data/archive

TITLE_XML="./data/remains.xml"
TITLE_JSON="./data/remains.json"

curl --user usr300:Ftp20Nov\!\@30hi ftp://77.91.121.70/Remains.xml -o $TITLE_XML

TITLE_ARCHIVE="remains $(grep -Po '<!\-\-Дата выгрузки остатков: \K[^\->]+' $TITLE_XML)"

TITLE_ARCHIVE_XML="./data/archive/${TITLE_ARCHIVE}.xml"
TITLE_ARCHIVE_JSON="./data/archive/${TITLE_ARCHIVE}.json"

./node_modules/.bin/xml-js "$TITLE_XML" >"$TITLE_JSON"

cp "$TITLE_XML" "$TITLE_ARCHIVE_XML"
cp "$TITLE_JSON" "$TITLE_ARCHIVE_JSON"

# s3cmude sync ./data s3://ftp-to-json
if [ -s "${TITLE_JSON}" ]; then
  s3cmd put --force "$TITLE_JSON" s3://ftp-to-json
  s3cmd put --force "$TITLE_XML" s3://ftp-to-json
  s3cmd put --force "$TITLE_ARCHIVE_JSON" s3://ftp-to-json/
  s3cmd put --force "$TITLE_ARCHIVE_XML" s3://ftp-to-json/
fi

AUTOSTOP=$(cat /tmp/autostop)

if [ "${AUTOSTOP}" = "1" ]; then
  sudo poweroff
fi
