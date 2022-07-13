# dYmension

## Installation

Requires [Go version v1.18+](https://golang.org/doc/install).

```sh
> git clone https://github.com/dymensionxyz/dymension.git && cd dymension
> sudo curl https://get.ignite.com/cli! | sudo bash
> ignite chain build
```

## Start your node

Init chain and reset all the data:
```sh
> dymd init <moniker-name> --chain-id=dymension
> dymd tendermint unsafe-reset-all
```
___
Download genesis file into `dymd`'s `config` directory:

***As long as the `dymension`'s repository is private, manually download the file.***	
```sh
> curl -s https://raw.githubusercontent.com/dymensionxyz/networks/main/devnet/genesis.json > genesis.json
> mv genesis.json ~/.dYmension/config/
```
___
Modify your `dymd`'s `config/config.toml` to include the other participants as persistent peers:
```text
# Comma separated list of nodes to keep persistent connections to
persistent_peers = "[validator_address]@[ip_address]:[port],[validator_address]@[ip_address]:[port]"
```
You can find `validator_address` by running `./dymd tendermint show-node-id`. 
The default `port` is 26656.
___
Start your node and sync to the latest block:
```sh
> dymd start
```


## Create testnet validator

Add your private key:
```sh
> dymd keys add <key-name>
```
Request tokens from any participant.
___
Create validator:
```sh
> dymd tx staking create-validator \
   --amount 50000000dym \
   --commission-max-change-rate "0.1"  \
   --commission-max-rate "0.20"  \
   --commission-rate "0.1"  \
   --min-self-delegation "1" \
   --details "validators write bios too" \
   --pubkey=$(dymd tendermint show-validator) \
   --moniker <moniker-name> \
   --chain-id dymension \
   --gas-prices 0.025 \
   --from $(dymd keys show <key-name> -a)
```
___
Check to see if your validator candidate is in the validator set:
```sh
> dymd query staking validators
```
