# Upgrade History

The following table presents a list of the Dymension versions.

Each version is identified by a specific id, tag, block height and software upgrade proposal.

| ID    |  Tag       | Starting Block | Release                                                                  | Proposal                                             |
|-------|-----------|----------------|--------------------------------------------------------------------------|------------------------------------------------------|
| `v3`  | `v3.0.0`  | 0              | [Release](https://github.com/dymensionxyz/dymension/releases/tag/v3.0.0/)  | N.A. (Genesis)                                       |
| `v3`  | `v3.1.0`  | xxxxxxx        | [Release](https://github.com/dymensionxyz/dymension/releases/tag/v3.1.0)  | [](https://www.mintscan.io/dymension/proposals/)   |

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
    "linux/amd64": "https://github.com/dymensionxyz/dymension/releases/download/v3.1.0/dymd-3.1.0-linux-amd64?",
    "linux/arm64": "https://github.com/dymensionxyz/dymension/releases/download/v3.1.0/dymd-3.1.0-linux-arm64?"
  }
}
```

## Replay from Genesis using Cosmovisor

Assuming that your dymension home it's already initialized with the desired genesis and configuration,
to replay the chain from genesis using Cosmovisor:

1. Install version `v1.2.0` from the official [repository](https://github.com/cosmos/cosmos-sdk/tree/main/tools/cosmovisor).

Alternatively, you can download the appropriate binary for your platform from our mirrors:

| Platform | Architecture | Cosmovisor Binary URL                                                                                      |
|----------|--------------|------------------------------------------------------------------------------------------------------------|
| linux    | amd64        | [Download](https://osmosis.fra1.digitaloceanspaces.com/binaries/cosmovisor/cosmovisor-v1.2.0-linux-amd64)  |
| linux    | arm64        | [Download](https://osmosis.fra1.digitaloceanspaces.com/binaries/cosmovisor/cosmovisor-v1.2.0-linux-arm64)  |

1. Initialize the Cosmovisor directory following the specific structure outlined below:
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

2. 
3. 
