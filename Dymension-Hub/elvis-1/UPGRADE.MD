# Elvis-1 Love

This is the first upgrade proposal and you can query it via CLI.

```bash
dymd q gov proposal 1 # prop info
dymd q gov tally 1 # vote info
```

The Upgrade is scheduled for block `19000`, which should be about _DATE_.

You can either YOLO and assume cosmovisor will have your back (it probably will), or check in on Discord around the upgrade time.

```bash
# get the new version
git checkout main && git pull
git checkout VERSION
make build && make install

# check the version - should be VERSION
# dymd version --long will be commit HASH
dymd version

# if you are using cosmovisor you then need to copy this new binary
cp /home/<your-user>/go/bin/dymd $DAEMON_HOME/cosmovisor/upgrades/love/bin

# find out what version you are about to run - should be v2.0.3
$DAEMON_HOME/cosmovisor/upgrades/moneta/bin/dymd version
```

Let's rock n roll! 🤟
