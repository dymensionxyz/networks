![Dymension Hub Genesis Validators](/static/img/genesis-validators.png)

# Welcome Genesis Validators!

The primary point of communication for the genesis process will be the #genesis-validators-35-c channel on the [Dymension Discord](https://discord.gg/dymension). It is absolutely critical that you and your team join the Discord during launch, as it will be the coordination point in case of any hiccups or issues during the launch process. The channel is private by default in order to keep it free of spam and unnecessary noise.

#### The deadline for submitting a Gentx PR is February 8 at 12:00 UTC

#### The genesis event is broken into two parts:

-   [Part 1](/dymension-hub/35-C/genesis_validators.md#part-1): Preparing gentx
-   [Part 2](/dymension-hub/35-C/genesis_validators.md#part-2): Starting the testnet

After Gentxs are collected we will provide a pre-genesis.json file for review. As long as there are no recommended changes we will provide the Genesis file with the genesis time in Part 2 after the collection of Gentxs.

**Recommended minimum hardware requirements:**

-   4 or more physical CPU cores
-   At least 500GB of SSD disk storage
-   At least 16GB of memory
-   At least 100mbps network bandwidth

# Part 1

These instructions are for creating a basic setup of a single node. Validators should modify these instructions for their own custom setups as needed (i.e. sentry nodes, tmkms, etc).

**Prerequisites:** Make sure to have [Golang >=1.18](https://golang.org/). You need to ensure your GOPATH configuration is correct.

### Install Dymension Hub:

```sh
git clone https://github.com/dymensionxyz/dymension.git --branch v0.2.0-beta
cd dymension
make install
```

This will install `dymd` binary into `$GOBIN`. Check that you have the right Dymension version installed:

```
dymd version --long
```

Returns:

```
name: dymension
server_name: dymd
version: v0.2.0-beta
commit: 987e33407911c0578251f3ace95d2382be7e661d
```

We recommend saving the testnet chain-id into your Dymension client.toml. This will make it so you do not have to manually pass in the chain-id flag for every CLI command.

### Save the testnet chain-id:

```
dymd config chain-id 35-C
```

### Generate genesis transaction (gentx):

1. Initialize the Dymension directories and create a local genesis file with the correct chain-id. You will be asked to replace the temporary Genesis file with the finalized Genesis file once all participating validators submit their Gentx.

```bash
dymd init <NODE_NAME> --chain-id=35-C
```

2. Create a key pair:

```bash
dymd keys add <KEY_NAME>
```

3. Add your account to the genesis file with the given amount and the key you just created. Use only `600000000000udym`, other amounts will be ignored.

```bash
dymd add-genesis-account <ADDRESS> 600000000000udym
```

4. Create the Gentx. The `dymd gentx -h` command will provide helpful flags to configure your validator node. The only required flags are chain-id and amount of self-delegated udym, everything else is recommended but optional. Use only `500000000000udym`:

```bash
dymd gentx <KEY_NAME> --chain-id 35-C 500000000000udym
```

If all goes well, you will see a message similar to the following:

```bash
Genesis transaction written to "/home/user/.dymension/config/gentx/gentx-******.json"
```

### Submitting the Genesis transaction:

1. Rename the Gentx file to gentx-{your-moniker}.json (please do not have any spaces or special characters in the file name).

2. Fork [the testnets repo](https://github.com/dymensionXYZ/testnets/) into your GitHub account

3. Clone your repo using:

```bash
git clone https://github.com/<your-github-username>/testnets
```

4. Copy the generated gentx json file to `/35-C/gentx/`:

```bash
cd testnets/dymension-hub/35-C
cp ~/.dymension/config/gentx/gentx*.json ./gentx/
```

5. Commit and push to your repo:

```bash
git add .
git commit -m "<your validator moniker> gentx"
git push origin main
```

6. Create a PR to https://github.com/dymensionXYZ/testnets

For a demonstration of a step-by-step guide to creating a PR please follow the [GitHub documentation](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request-from-a-fork) or watch this helpful [youtube video](https://www.youtube.com/watch?v=a_FLqX3vGR4).

Please DM Ganeshti#1471 on Dymension's discord with a link of the GitHub PR. Only PRs from selected validators will be accepted. Validators must submit their PRs prior to the deadline submission date.

The Dymension core team will provide Part 2 instructions for replacing the genesis.json after collecting Gentxs. Please follow on-going communication on Discord and reach out to the Dymension core team whenever you have any questions.

### Welcome aboard!

# Part 2

Welcome to Part 2 of the Genesis Event of the Dymension Hub's testnet. We recommend reviewing `What is a Genesis File?` [here](https://github.com/cosmos/gaia/blob/main/docs/resources/genesis.md). Below you will find the source of the genesis file which includes validator gentx provided in Part 1. Follow these instructions to download the genesis file, validate, and prepare for launching the testnet!

NOTE: The provided file is a `pre-genesis` file. As long as there are no changes until Monday, February 13th. Dymension's core team will submit a PR for the official Genesis file. Please review the Pre-genesis file provided and reach out to the team via Discord to voice any concerns. Once the genesis file PR is submitted by the Dymension core team you may follow the instructions to prepare for launch:

**Genesis File**

```sh
cp genesis.json ~/.dymension/config/genesis.json
```

**Genesis sha256**

```bash
sha256sum ~/.dymension/config/genesis.json
99d9e633fa6d1609bbbeaed2b4f80a8fad69842d845fa10884e6a7806db95b11 ~/.dymension/config/genesis.json
```

**Validate the Genesis file**

```bash
dymd validate-genesis
```

Add seed nodes in config.toml. We will be adding peer and seed nodes prior to the launch of the Genesis event. These nodes can be found in the seeds.txt file.

```sh
vi $HOME/.dymension/config/config.toml
```

#### Set validator gas fees

You can set the minimum gas prices for transactions to be accepted into your node's mempool. This sets a lower bound on gas prices, preventing spam. Dymension can accept gas in _any_ currency. To accept both DYM and ATOM for example, set `minimum-gas-prices` in `app.toml`.

```sh
vi $HOME/.dymension/config/app.toml
```

```sh
minimum-gas-prices = "0.025udym,0.025uatom"
```

#### Genesis time is: 2023-02-15 14:00 UTC

```bash
dymd start
```

Once 2/3rd of staked tokens are online after genesis time the blockchain has begun!
