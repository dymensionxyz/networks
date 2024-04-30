# Upgrade History

The following table presents a list of the Dymension versions.

Each version is identified by a specific id, tag, block height and software upgrade proposal.

| ID    |  Tag       | Starting Block | Release                                                                  | Proposal                                             |
|-------|-----------|----------------|--------------------------------------------------------------------------|------------------------------------------------------|
| `v3`  | `v3.0.0`  | 0              | [Release](https://github.com/dymensionxyz/dymension/releases/tag/v3.0.0/)  | N.A. (Genesis)                                       |
| `v3`  | `v3.1.0`  | 1159000        | [Release](https://github.com/dymensionxyz/dymension/releases/tag/v3.1.0)  | [12](https://www.mintscan.io/dymension/proposals/12)   |

## Upgrade binaries

### v3.0.0 (TBA)

```json
{
  "binaries": {
    "linux/amd64": "https://github.com/dymensionxyz/dymension/releases/download/v3.0.0/dymd-3.0.0-linux-amd64?",
    "linux/arm64": "https://github.com/dymensionxyz/dymension/releases/download/v3.1.0/dymd-3.0.0-linux-arm64?"
  }
}
```

### v3.1.0 (TBA)

```json
{
  "binaries": {
    "linux/amd64": "https://github.com/dymensionxyz/dymension/releases/download/v3.1.0/dymd",
    "linux/arm64": "https://github.com/dymensionxyz/dymension/releases/download/v3.1.0/dymd-3.1.0-linux-arm64?"
  }
}
```

## Replay from Genesis using Cosmovisor

Assuming that your dymension home it's already initialized with the desired genesis and configuration,
to replay the chain from genesis using Cosmovisor:

1. Install version `v1.2.0` or later from the official [repository](https://github.com/cosmos/cosmos-sdk/tree/main/tools/cosmovisor).

Alternatively, you can download the appropriate binary for your platform from mirrors:

| Platform | Architecture | Cosmovisor Binary URL                                                                                      |
|----------|--------------|------------------------------------------------------------------------------------------------------------|
| linux    | amd64        | [Download](https://osmosis.fra1.digitaloceanspaces.com/binaries/cosmovisor/cosmovisor-v1.2.0-linux-amd64)  |
| linux    | arm64        | [Download](https://osmosis.fra1.digitaloceanspaces.com/binaries/cosmovisor/cosmovisor-v1.2.0-linux-arm64)  |

2. Initialize the Cosmovisor directory following the specific structure outlined below:
```bash
<COSMOVISOR_HOME>
   ├── genesis
   │   └── bin
   │       └── dymd
   └── upgrades
       ├── v3.1.0
       │   └── bin
       │       └── dymd
       └── v4.0.0
           └── bin
               └── dymd
```
3. Replaying the chain from historical data requires the presence of at least one archive nodes in the persistent peers. Ensure that you include the following configuration in your config.toml file:
```toml
[p2p]
persistent_peers = "9859ade424269d42876852ec8dc1a47a1fc1268e@65.109.110.31:31890,f6e7324a4e0fc62870f8a48f07b16471b188c807@95.217.192.250:26156,c600039ef70040740ae130d455768c509d173b12@85.10.200.232:23836" 
```
4. Run cosmovisor with `DAEMON_ALLOW_DOWNLOAD_BINARIES=false` 


