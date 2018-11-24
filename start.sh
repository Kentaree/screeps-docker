#!/bin/sh
# config check
cd /screeps

if [ ! -e /screeps/.screepsrc ]; then
    if [ -z "$STEAMKEY" ]; then
        echo "Did you forget to set the STEAMKEY environment variable?"
        exit 1
    else
        # pass our steam key into the init process
        echo "initializing screeps..."
        echo "${STEAMKEY}" | screeps init

        echo "initializing mods..."
        yarn add screepsmod-mongo screepsmod-auth screepsmod-tickrate screepsmod-admin-utils screepsmod-features @screeps/simplebot

        echo "initializing .screepsrc..."
        echo -e "\n[mongo]" >> .screepsrc
        echo "host=${MONGO_LINK}" >> .screepsrc
        echo "[redis]" >> .screepsrc
        echo "host=${REDIS_LINK}" >> .screepsrc
        mv custom_mods.json mods.json
	#sed -i 's/modfile.*/modfile = custom_mods.json/' .screepsrc
    fi
fi

screeps start
