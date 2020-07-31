# rabbitmq k8s cluster dns bug replication


The scripts assume you have kind install https://kind.sigs.k8s.io/ and in your path.

You can run locally like:

```sh
./00_init.sh # Create a local test cluster & install rabbitmq


# In another shell start a rabbitmq publisher
./03_publish.sh

# In other shells (3+) start rabbitmq consumers, each with its own queue
./04_consumer.sh

# In the main shell
./05_apply_broken.sh
./06_roll.sh # Potentially multiple times

# Once done to delete the test cluster
./09_cleanup.sh
```
