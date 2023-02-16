#!/bin/bash

# https://open.canada.ca/data/en/dataset/a4b190fe-e090-4e6d-881e-b87956c07977

TARGETS=( \
    # Pre-packaged FGDB files (download directory) (English)
    "https://ftp.maps.canada.ca/pub/nrcan_rncan/vector/geobase_nhn_rhn/gdb_en/"
    )

### ~~~~~~~~~~ ###
dataRepository=~/minio/standard/shared/randd-eesd/001-data-repository/001-acquired/NHN-GeoBase
if [ `uname` != "Darwin" ]
then
    if [ ! -d "$dataRepository" ]; then
        mkdir -p ${dataRepository}
    fi
    cp $0 ${dataRepository}
fi

### ~~~~~~~~~~ ###
for tempzip in "${TARGETS[@]}"
do

    echo;echo downloading: ${tempzip}
    wget -r ${tempzip}
    sleep 5

    # if [ `uname` != "Darwin" ]
    # then
    #     tempstem=`basename ${tempzip} .zip`
    #     tempzip=${tempstem}.zip

    #     echo unzipping: ${tempzip}
    #     unzip ${tempzip} -d ${tempstem}
    #     sleep 5

    #     # Copy multiple local folders recursively to MinIO cloud storage.
    #     echo copying ${tempstem} to ${dataRepository}
    #     mc-original cp --recursive ${tempstem} ${dataRepository}
    #     sleep 5

    #     echo deleting ${tempstem}
    #     rm -rf ${tempstem}
    #     sleep 5
    # fi

done
echo

### ~~~~~~~~~~ ###
echo; echo done; echo

### ~~~~~~~~~~ ###
if [ `uname` != "Darwin" ]
then
    if compgen -G "std*" > /dev/null; then
        cp std* ${dataRepository}
    fi
fi
