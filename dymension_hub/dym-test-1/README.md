# Welcome to the Dymension Hub's testnet!

## TLDR

Seed

Persistent Peers

RPC

LCD

## Sync From Genesis Guide (dym-test-1)

This guide will show you how to sync from genesis to the new testnet. PLEASE NOTE, the first block may take a while to get passed. If you need all transaction data, it is recommended to download an archive snapshot from ChainLayer instead. This guide will not go extremely in depth as a majority of this is covered in https://docs.dymension.xyz

Clone the Dymension repo and install v6.4.0

```
git clone https://github.com/dymensionXYZ/dymension.git
git checkout TBD
make install
```

Set up testnet genesis

```
dymd init NODENAME --chain-id dym-test-1
cd ~/.dymension/config/
TODO -- wget https://github.com/osmosis-labs/networks/raw/main/osmo-test-4/genesis.tar.bz2
TODO -- tar -xjf genesis.tar.bz2 && rm genesis.tar.bz2
```

Edit the config.toml:

Add the seed node

```
TODO
```

Add the persistent peers

```
TODO
```

Start dymd with --x-crisis-skip-assert-invariants flag.

```
dymd start --x-crisis-skip-assert-invariants
```

You only need to use this flag once. Your daemon will run the first block and then get stuck searching for peers. This can take an hour or more. After an hour or so, you will then sync blocks. If you cancel this process before finding two or more blocks, you will have to use `dymd unsafe-reset-all` and then start with the skip assert invariants flag again. After finding two or more blocks you are in the clear. You can cancel the daemon at any point you want and simply use `dymd start` to get it running again.
