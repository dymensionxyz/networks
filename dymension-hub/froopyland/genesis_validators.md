![Dymension Hub Genesis Validators](/static/img/froopyland-img.jpg)

# Welcome Genesis Validators!

The primary point of communication for the genesis process will be the #genesis-froopyland channel on the [Dymension Discord](https://discord.gg/dymension). Selected validators may participate in the genesis event of the Froopyland network. It is absolutely critical that you and your team join the Discord during launch, as it will be the coordination point in case of any hiccups or issues during the launch process. The channel is private by default in order to keep it free of spam and unnecessary noise.

#### The deadline for submitting a Gentx PR is August 18 at 12:00 UTC

#### The genesis event is broken into two parts:

-   [Part 1](/dymension-hub/froopyland/genesis_validators.md#part-1): Preparing gentx
-   [Part 2](/dymension-hub/froopyland/genesis_validators.md#part-2): Starting the testnet

After Gentxs are collected we will provide a pre-genesis.json file for review. As long as there are no recommended changes we will provide the Genesis file with the genesis time in Part 2 after the collection of Gentxs.

**Recommended minimum hardware requirements:**

-   4 or more physical CPU cores
-   At least 200GB of SSD disk storage
-   At least 8GB of memory
-   At least 100mbps network bandwidth

# Part 1

These instructions are for creating a basic setup of a single node. Validators should modify these instructions for their own custom setups as needed (i.e. sentry nodes, tmkms, etc).

**Prerequisites:** Make sure to have [Golang >=1.18](https://golang.org/). You need to ensure your GOPATH configuration is correct.

### Install Dymension Hub:

```sh
git clone https://github.com/dymensionxyz/dymension.git --branch v1.0.0-beta
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
version: v1.0.0-beta
commit: a68c3347e2251ecc234d75913b4fa8c16bac19b6
```

We recommend saving the testnet chain-id into your Dymension client.toml. This will make it so you do not have to manually pass in the chain-id flag for every CLI command.

### Save the testnet chain-id:

```
dymd config chain-id froopyland_100-1
```

### Generate genesis transaction (gentx):

1. Initialize the Dymension directories and create a local genesis file with the correct chain-id. You will be asked to replace the temporary Genesis file with the finalized Genesis file once all participating validators submit their Gentx.

```bash
dymd init <NODE_NAME> --chain-id=froopyland_100-1
```

2. Create a key pair:

```bash
dymd keys add <KEY_NAME>
```

3. Add your account to the genesis file with the given amount and the key you just created. Use only `6000000000000000000udym`, other amounts will be ignored.

```bash
dymd add-genesis-account <ADDRESS> 6000000000000000000udym
```

4. Create the Gentx. The `dymd gentx -h` command will provide helpful flags to configure your validator node. The only required flags are chain-id and amount of self-delegated udym. Use only `5000000000000000000udym`:

```bash
dymd gentx <KEY_NAME> --chain-id froopyland_100-1 5000000000000000000udym
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

4. Copy the generated gentx json file to `/froopyland/gentx/`:

```bash
cd testnets/dymension-hub/froopyland
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
