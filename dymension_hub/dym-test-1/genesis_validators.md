![Dymension Hub Genesis Validators](/static/img/genesis-validators.png)

# Welcome Genesis Validators!

The primary point of communication for the genesis process will be the #genesis-validators channel on the [Dymension Discord](discord.gg/dymension). It is absolutely critical that you and your team join the Discord during launch, as it will be the coordination point in case of any hiccups or issues during the launch process. The channel is private by default in order to keep it free of spam and unnecessary noise.

The genesis event is broken into two parts:

-   [Part 1](/dymension_hub/dym-test-1/genesis_validators.md#part-1): Preparing gentx
-   [Part 2](/dymension_hub/dym-test-1/genesis_validators.md#part-2): Starting the testnet

# TLDR

Genesis time is: TBA

Source code: TBA

Genesis file: TBA

**Minimum hardware requirements:**

-   4 or more physical CPU cores
-   At least 500GB of SSD disk storage
-   At least 16GB of memory
-   At least 100mbps network bandwidth

# Part 1

These instructions are for creating a basic setup of a single node. Validators should modify these instructions for their own custom setups as needed (i.e. sentry nodes, tmkms, etc).

**Prerequisites:** Make sure to have [Golang >=1.18](https://golang.org/).

You need to ensure your GOPATH configuration is correct. If the following **'make'** step does not work then you might have to add these lines to your .profile or .zshrc in the users home folder:

#### Update environment variables to include Go:

```
cat <<'EOF' >>$HOME/.profile
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
EOF
source $HOME/.profile
```

#### Install Dymension Hub:

```sh
git clone https://github.com/dymensionxyz/dymension.git --branch v0.1.0-alpha
cd dymension
make build && make install
```

This will build and install `dymd` binary into `$GOBIN`. Check that you have the right Dymension version installed:

```
dymd version --long
```

Returns:

```
name: dymension
server_name: dymd
version: v0.1.0-alpha
commit: f68b1000f040ace7c266b6c4b5e7c4a8b9a31378
...
cosmos_sdk_version: TODO
```

We recommend saving the mainnet chain-id into your Dymension client.toml. This will make it so you do not have to manually pass in the chain-id flag for every CLI command.

#### Save the testnet chain-id:

```
dymd config chain-id dym-test-1
```

#### Generate genesis transaction (gentx)

1. Initialize the Dymension directories and create the local genesis file with the correct chain-id. You will be asked to replace the temporary genesis file with the genesis.json file later.

```bash
dymd init <NODE_NAME> --chain-id=dym-test-1
```

2. Create a key pair:

```bash
dymd keys add <KEY_NAME>
```

3. Add your account to the local genesis file with the given amount and the key you just created. Use only `10000000000udym`, other amounts will be ignored.

```bash
dymd add-genesis-account <ADDRESS> 10000000000udym
```

4. Create the gentx. If you would like to override the memo field use the --ip and --node-id flags for the dymd gentx command above. Use only `9000000000udym`:

```bash
dymd gentx <KEY_NAME> 9000000000udym --chain-id dym-test-1
```

If all goes well, you will see a message similar to the following:

```bash
Genesis transaction written to "/home/user/.dymension/config/gentx/gentx-******.json"
```

#### Submit genesis transaction:

1. Rename the gentx file just generated to gentx-{your-moniker}.json (please do not have any spaces or special characters in the file name)

2. Fork [the testnets repo](https://github.com/dymensionXYZ/testnets/) into your GitHub account

3. Clone your repo using:

```bash
git clone https://github.com/<your-github-username>/testnets
```

4. Copy the generated gentx json file to `/dym-test-1/gentx/`:

```bash
cd testnets/Dymension-Hub/dym-test-1
cp ~/.dymension/config/gentx/gentx*.json ./gentx/
```

5. Commit and push to your repo:

```bash
git add .
git commit -m "<your validator moniker> gentx"
git push origin main
```

6. Create a PR onto https://github.com/dymensionXYZ/testnets

For a demonstration of a step-by-step guide to creating a PR please follow the [GitHub documentation](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request-from-a-fork) or watch this helpful [youtube video](https://www.youtube.com/watch?v=a_FLqX3vGR4).

Only PRs from selected validators will be accepted. Validators must submit their PRs prior to the deadline submission date. The Dymension core team will provide Part 2 instructions of replacing the genesis.json and starting the network. Please follow on-going communication on Discord and reach out to the Dymension core team whenever you have any questions.
