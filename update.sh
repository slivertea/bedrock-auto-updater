#!/usr/bin/bash


BASEURI='https://minecraft.azureedge.net/bin-linux/'
CANDIDATE='bedrock-server-1.21.0.03.zip'
CANDIDATEVER='1.21.0.03'
DOWNLOADURL=$BASEURI$CANDIDATE
echo "[MSG] Checking for sudo..."
if [ "$EUID" -ne 0 ];then
  echo "[ERR] update.sh is not run as root. Exiting..."
  exit
else
  echo "[INFO]  sudo check passed"
fi

echo "[MSG] Purging stale candidates..."
rm -rf candidate.zip
rm -rf candidate/

echo "[MSG] Checing for Update..."
# skip


echo "[MSG] Attempting Download of version ${CANDIDATEVER}..."
response=$(curl -o candidate.zip ${DOWNLOADURL})


echo "[MSG] Unzipping the candidate..."
unzip candidate.zip -d candidate/


# Bounce and Move candidate to running
# minecraftStop
SERSTAT=$(sudo systemctl status minecraft.service | grep Active)
echo "[INFO]  Service Starting State:"
echo "[INFO]  ${SERSTAT}"
echo "[MSG] Stopping the minecraft service:"
SERSTOP=$(systemctl stop minecraft.service)
SERSTAT=$(sudo systemctl status minecraft.service | grep Active)
echo "[INFO]  ${SERSTAT}"


# minecraftMove
echo "[MSG] Reticulating Splines...."
BEDROCKSERVER=$BEDROCK_LOCATION$BEDROCK_WORLD
echo "[DEBUG] folder: ${BEDROCKSERVER}"

declare -a arr=("bedrock_server"
                "bedrock_server_symbols.debug"
                "behavior_packs"
                "definitions"
                "release-notes.txt"
                "resource_packs"
                )
for i in "${arr[@]}"
do
  UPDATELOCATION=$BEDROCKSERVER$i
  UPDATECOMMAND=$(cp -rf candidate/$i $UPDATELOCATION)
  echo "[DEBUG] :copiedTo: ${UPDATELOCATION}"
done



# minecraftStart
echo "[MSG] Starting the minecraft service:"
SERSTART=$(systemctl start minecraft.service)
SERSTAT=$(sudo systemctl status minecraft.service | grep Active)
echo "[INFO]  ${SERSTAT}"
#


# purge candidate
echo "[MSG] Purging candidate temp files..."
rm -rf candidate/

echo "[MSG] Update Complete"
