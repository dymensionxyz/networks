#!/bin/bash

# Set the directory containing JSON files
directory="./gentx"

# Loop through all JSON files in the directory
for file in "$directory"/*.json; do
    # Check if the file exists
    if [ -f "$file" ]; then
        #check len of messages

        # Get the value of the key "key"
        value_denom=$(jq -r '.body.messages[0].value.denom' "$file")
        value_amount=$(jq -r '.body.messages[0].value.amount' "$file")
        # delegator_addr=$(jq -r '.body.messages[0].delegator_address' "$GENTX_FILE")


        # Validate the value of the key
        if [ "$value_denom" != "udym1" ]; then
        echo "$file: denom is NOT valid" | tee -a bad_gentxs.out
        fi

        if [ "$value_amount" != "500000000000" ]; then
        echo "$file: amount is NOT valid" | tee -a bad_gentxs.out
        fi
    fi
done



#TODO: extarct delegator address to include in genesis