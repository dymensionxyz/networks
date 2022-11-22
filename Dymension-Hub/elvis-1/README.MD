# Welcome to Dymension's first public testnet, Elvis-1!

## Let's take care of business!

_This testnet is non-incentivized. Validators for this testnet have been pre-selected._

**Genesis File**

```bash

```

**Genesis sha256**

```bash
sha256sum ~/.dymension/config/genesis.json
#
```

**dymd version**

```bash
$ dymd version --long
name: dymension
server_name: dymd
version: HEAD-
commit:
```

**Seed nodes**

```

```

**Persistent Peers**

```

```

## Setup

**Install**

[Go version v1.18+](https://golang.org/doc/install) and [jq](https://cloudaffaire.com/faq/how-to-install-jq/).

```bash
git clone https://github.com/dymensionxyz/dymension.git && cd dymension
make install
```

```bash
export CHAIN_ID="Dym-Testnet-1"


```

```sh
# this can be any name of your choosing and will identify your validator in the explorer.
export MONIKER_NAME=<moniker-name>
```

```sh
# enable state-sync for rapidly bootstraps a node.
# export STATE_SYNC=1
```

## Start your node by script

Init, setup and run:

```sh
./scripts/setup_and_run.sh
```

## Start your node manually

Init chain and reset all the data:

```sh
dymd init "$MONIKER_NAME" --chain-id=$CHAIN_ID
dymd tendermint unsafe-reset-all
```

Download genesis file into `dymd`'s `config` directory:

```sh
CHAIN_REPO="https://$TOKEN@raw.githubusercontent.com/dymensionxyz/networks/main"
curl -s "$CHAIN_REPO/$CHAIN_ID/genesis.json" > genesis.json
mv genesis.json ~/.dymension/config/
```

Update peers configurations:

```sh
PEERS="$(curl -s "$CHAIN_REPO/$CHAIN_ID/persistent_peers.txt")"
sed -i'' -e "s/^persistent_peers = \"\"/persistent_peers = \"$PEERS\"/" ~/.dymension/config/config.toml
sed -i'' -e 's/^allow_duplicate_ip = false/allow_duplicate_ip = true/' ~/.dymension/config/config.toml
```

Set chain-id (in the client configuration):

```sh
sed -i'' -e "s/^chain-id *= .*/chain-id = \"$CHAIN_ID\"/" ~/.dymension/config/client.toml
```

_State Sync_

Allow validators to rapidly join the network by syncing your node with a snapshot from a trusted block height.

```sh
# RPC_SERVER='rpc.dymension.xyz:26657'
# TRUSTED_BLOCK=$(curl "$RPC_SERVER/commit" | jq -r "{height: .result.signed_header.header.height, hash: .result.signed_header.commit.block_id.hash}")
# BLOCK_HEIGHT=$(echo "$TRUSTED_BLOCK" | jq -r ".height")
# BLOCK_HASH=$(echo "$TRUSTED_BLOCK" | jq -r ".hash")
# sed -i'' -e 's/^enable *= false/enable = true/' ~/.dymension/config/config.toml
# sed -i'' -e "s/^trust_height *= .*/trust_height = $BLOCK_HEIGHT/" ~/.dymension/config/config.toml
# sed -i'' -e "s/^trust_hash *= .*/trust_hash = \"$BLOCK_HASH\"/" ~/.dymension/config/config.toml
# sed -i'' -e "s/^rpc_servers *= .*/rpc_servers = \"http:\/\/$RPC_SERVER,http:\/\/$RPC_SERVER\"/" ~/.dymension/config/config.toml
```

Start your node and sync to the latest block:

```sh
dymd start
```

## Create testnet validator

Add your private key:

```sh
dymd keys add <key-name>
```

Create validator:

**_Request tokens from any participant._**

```sh
dymd tx staking create-validator \
   --amount 50000000dym \
   --commission-max-change-rate "0.1"  \
   --commission-max-rate "0.20"  \
   --commission-rate "0.1"  \
   --min-self-delegation "1" \
   --details "validators write bios too" \
   --pubkey=$(dymd tendermint show-validator) \
   --moniker "$MONIKER_NAME" \
   --chain-id $CHAIN_ID \
   --gas-prices 0.025dym \
   --from $(dymd keys show <key-name> -a)
```

Check to see if your validator candidate is in the validator set:

```sh
dymd query staking validators
```
