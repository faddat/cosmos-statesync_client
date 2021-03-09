# Please note that this doesn't work with the current BCNA chain

# BitCanna State Sync client config.

## ToDo: download, configuring and syncing a complete peer from the scratch
#wget http://to.do/bcnad
chmod +x bcnad
bcnad init New_peer chain-id bitcanna
wget http://testnet.-.es/genesis.json 
mv genesis.json $HOME/.bcna/config/
# At this moment: config state sync & launch the syncing (all previous config need to be performed) 


#!/bin/bash
set -e

RPC1=seed1.bitcanna.io
P2P_PORT1=26656
RPC2=seed2.bitcanna.io
P2P_PORT2=16656

INTERVAL=1000

LATEST_HEIGHT=$(curl -s $RPC1/block | jq -r .result.block.header.height);
BLOCK_HEIGHT=$(($(($LATEST_HEIGHT / $INTERVAL)) * $INTERVAL));
if [ $BLOCK_HEIGHT -eq 0 ]; then
  echo "Error: Cannot state sync to block 0; Latest block is $LATEST_HEIGHT and must be at least $INTERVAL; wait a few blocks!"
  exit 1
fi

TRUST_HASH=$(curl -s "$RPC1/block?height=$BLOCK_HEIGHT" | jq -r .result.block_id.hash)
if [ "$TRUST_HASH" == "null" ]; then
  echo "Error: Cannot find block hash. This shouldn't happen :/"
  exit 1
fi

NODE1_ID=$(curl -s "$RPC1/status" | jq -r .result.node_info.id)
NODE2_ID=$(curl -s "$RPC1/status" | jq -r .result.node_info.id)

sed -i.bak -E "s|^(enable[[:space:]]+=[[:space:]]+).*$|\1true| ; \
s|^(rpc_servers[[:space:]]+=[[:space:]]+).*$|\1\"$RPC1,$RPC2\"| ; \
s|^(trust_height[[:space:]]+=[[:space:]]+).*$|\1$BLOCK_HEIGHT| ; \
s|^(trust_hash[[:space:]]+=[[:space:]]+).*$|\1\"$TRUST_HASH\"| ; \
s|^(seeds[[:space:]]+=[[:space:]]+).*$|\1\"${NODE1_ID}@${NODE1_IP}:$P2P_PORT1,${NODE2_ID}@${NODE2_IP}:$P2P_PORT2\"|" $HOME/./bcnad/config/config.toml


bcnad unsafe-reset-all
rm -f $HOME/./bcnad/config/addrbook.json
bcnad start
