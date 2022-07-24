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

