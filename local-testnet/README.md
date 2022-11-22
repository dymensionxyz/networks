# dYmension Local Testnet

## Install

Requires [Go version v1.18+](https://golang.org/doc/install).

```sh
git clone https://github.com/dymensionxyz/dymension.git && cd dymension
make install
```

## Set the following properties

```sh
# this can be any name of your choosing as you don't join to an existing testnet.
CHAIN_ID=local-testnet

# this can be any name of your choosing and will identify your validator in the explorer.
MONIKER_NAME=<miniker-name>
```

## Start your node

Init chain and reset all the data:

```sh
dymd tendermint unsafe-reset-all
dymd init "$MONIKER_NAME" --chain-id=$CHAIN_ID
```

Update genesis file and app configurations:

```sh
sed -i'' -e "s/^chain-id *= .*/chain-id = \"$CHAIN_ID\"/" ~/.dymension/config/client.toml
sed -i'' -e 's/bond_denom": ".*"/bond_denom": "dym"/' ~/.dymension/config/genesis.json
sed -i'' -e 's/mint_denom": ".*"/mint_denom": "dym"/' ~/.dymension/config/genesis.json
```

Adding genesis account:

```sh
dymd keys add <key-name>
dymd add-genesis-account $(dymd keys show <key-name> -a) 100000000000dym
```

Registers the account you created as a validator operator account:

```sh
dymd gentx <key-name> 100000000dym --chain-id $CHAIN_ID
dymd collect-gentxs
```

Start your node:

```sh
dymd start
```

```bash
export CHAIN_ID="Dym-Testnet-1"

# Please change the "moniker-name" to identify your validator.
export MONIKER_NAME=<"moniker-name">
```

## Start your node

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
