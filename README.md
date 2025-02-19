# State Sync - Client Script
Script to bootstrap the syncing when a new peer/validator join to BitCanna-Cosmos.

## The Problem
When a new peer tries to join a running chain it can take days to fully synchronise and this can take up a huge amount of disk space.

## The Solution
StateSync is a feature which would allow a new node to receive a snapshot of the application state without downloading blocks or going through consensus. Deploying the new State Sync function on StateSync servers could help to boost the synchronizing of new peers/validators. It also reduces the disk space usage. 

Bitcanna StateSync servers will include this function in mainnet. 

## Usage
Only for new deployings. **Backup your `~/.bcna/config` folder if you store your private keys there!!**

This script will download the binary and the genesis by you and will setup the peers and seeds.  

Don't start the BitCanna daemon manually, the script will do it for you and will synchronize the whole chain. Press CTRL + C to stop it when you see the peer synced with last block.


* Download the script:

```
wget https://raw.githubusercontent.com/BitCannaCommunity/statesync_client/main/statesync_client.sh
chmod +x statesync_client.sh
```

### As a previous step before launch the script, edit it with `nano` tool and change the rpc StateSync peers if it is needed. 
* Then launch the script (CTLR + C to stop it):
```
./statesync_client.sh
```
### When your peer is upgraded, set up a service file as described in this guide (Step 1 - substep 9)
https://github.com/BitCannaGlobal/testnet-bcna-cosmos/blob/main/instructions/public-testnet/validator-guides/task1.md#step-1---setting-up-the-connection
