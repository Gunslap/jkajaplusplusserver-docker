#!/bin/bash

echo "Checking to make sure all files from /ja/assets and ja/base_original are present in /ja/base/ ...";

#/ja/base_original/ contains the original files from the base directory of the OpenJK server
#copy them to the new /ja/base/ directory if they aren't already there
diff -q base base_original | grep -oP '(?<=Only in /ja/base_original: ).*' | xargs -I '{}' cp base_original/'{}' base/'{}';

#/ja/assets/ should contain the assets*.pk3 files (and any mod files you've included) from the bind mount
#copy them to the new /ja/base/ directory if they aren't already there
diff -q assets base | grep -oP '(?<=Only in assets: ).*' | xargs -I '{}' cp assets/'{}' base/'{}';

#Remove any additional files that may have been copied from the /ja/assets directory to the /ja/base directory previously
#that have since been removed from /ja/assets (ignoring the files from /ja/base_original)
diff -q base assets | grep -oP '(?<=Only in base: ).*' | grep -vP 'cgamei386.so|jampgamei386.so|uii386.so' | xargs -I '{}' rm base/'{}';

#check that the 4 assets{0-3}.pk3 files are present in /ja/base/ directory
if test -f "/ja/base/assets0.pk3"; then
    if test -f "/ja/base/assets1.pk3"; then
        if test -f "/ja/base/assets2.pk3"; then
            if test -f "/ja/base/assets3.pk3"; then
                echo "All assets*.pk3 files are present";
            else
                echo "assets3.pk3 is missing, please mount it to the /ja/assets/ directory";
                exit 1;
            fi
        else
            echo "assets2.pk3 is missing, please mount it to the /ja/assets/ directory";
            exit 1;
        fi
    else
        echo "assets1.pk3 is missing, please mount it to the /ja/assets/ directory";
        exit 1;
    fi
else
    echo "assets0.pk3 is missing, please mount it to the /ja/assets/ directory";
    exit 1;
fi

#check if there is a server config file to copy over from the japluscfg directory
if test -f "japluscfg/server.cfg"; then
    rm japlus/server.cfg;
    cp japluscfg/server.cfg japlus/server.cfg;
fi
/bin/bash ./start_japlus_linux_autoRestart.sh;