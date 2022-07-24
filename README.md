# dYmension Testnets

## Install

Requires [Go version v1.18+](https://golang.org/doc/install).

```sh
git clone https://github.com/dymensionxyz/dymension.git && cd dymension
make install
```

## Set the following properties
```sh
# should be one of the existing testnets you want to join.
CHAIN_ID=devnet

# this can be any name of your choosing and will identify your validator in the explorer.
MONIKER_NAME=<miniker-name>

# as long as the `dymension`'s networks repository is private, we should add github personal access token.
TOKEN=<github-access-token>
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
curl -s https://$TOKEN@raw.githubusercontent.com/dymensionxyz/networks/main/$CHAIN_ID/genesis.json > genesis.json
mv genesis.json ~/.dymension/config/
```

Set persistent peers (in the tendermint configuration):
```sh
PEERS='06bf14a552b22518ed6fff254d74331f60e965cd@44.209.89.17:26656'
sed -i'' -e "s/persistent_peers = \"\"/persistent_peers = \"$PEERS\"/" ~/.dymension/config/config.toml
```

Set chain-id (in the client configuration):
```sh
sed -i'' -e "s/^chain-id *= .*/chain-id = \"$CHAIN_ID\"/" ~/.dymension/config/client.toml
```

*State Sync*

To enable state sync, visit {dymension-explorer-link} to get a recent block height and corresponding hash.

Set these parameters in the code snippet below `<block-height>` and `<block-hash>`
```sh
sed -i'' -e 's/^enable *= false/enable = true/' ~/.dymension/config/config.toml
sed -i'' -e 's/^trust_height *= .*/trust_height = <block-height>/' ~/.dymension/config/config.toml
sed -i'' -e 's/^trust_hash *= .*/trust_hash = "<block-hash>"/' ~/.dymension/config/config.toml
sed -i'' -e 's/^rpc_servers *= .*/rpc_servers = "https:\/\/rpc.cosmos.network:443"/' ~/.dymension/config/config.toml
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

***Request tokens from any participant.***

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
