#!/bin/bash

# https://open.canada.ca/data/en/dataset/a4b190fe-e090-4e6d-881e-b87956c07977
urlNHN=https://ftp.maps.canada.ca/pub/nrcan_rncan/vector/geobase_nhn_rhn/gdb_en

FOLDERS=( \
    # "01" \
    # "02" \
    # "03" \
    # "04" \
    # "05" \
    # "06" \
    # "07" \
    # "08" \
    "09" \
    # "10" \
    "11"
    )

### ~~~~~~~~~~ ###
# dataRepository=~/minio/standard/shared/randd-eesd/001-data-repository/001-acquired/NHN-GeoBase
dataRepository=~/minio/standard/shared/kenneth-chu/001-data-repository/001-acquired/NHN-GeoBase
if [ `uname` != "Darwin" ]
then
    if [ ! -d "$dataRepository" ]; then
        mkdir -p ${dataRepository}
    fi
    cp $0 ${dataRepository}
fi

### ~~~~~~~~~~ ###
for tempFolder in "${FOLDERS[@]}"
do

    tempTarget=${urlNHN}/${tempFolder}/
    echo;echo downloading: ${tempTarget}
    # for explanation of the following command, see: https://www.scivision.dev/wget-recursive-download
    # wget --recursive -np -nc -nH --cut-dirs=5 --random-wait --wait 1 -e robots=off ${tempTarget}
    # sleep 2

    if [ `uname` != "Darwin" ]
    then
        ZIPFILES=`ls ${tempFolder}/*.zip`
        echo ZIPFILES: ${ZIPFILES}

        for tempzip in "${ZIPFILES[@]}"
        do
            tempstem=`basename ${tempzip} .zip`
            # tempzip=${tempstem}.zip

            echo tempzip:  ${tempzip}
            echo tempstem: ${tempstem}

            echo executing: unzip ${tempzip} -d ${tempFolder}/${tempstem}
            # unzip ${tempFolder}/${tempzip} -d ${tempFolder}/${tempstem}
            # sleep 5

        done
        # Copy multiple local folders recursively to MinIO cloud storage.
        echo executing: mc-original cp --recursive ${tempFolder} ${dataRepository}
        # mc-original cp --recursive ${tempFolder} ${dataRepository}
        # sleep 5

        echo executing: rm -rf ${tempFolder}
        # rm -rf ${tempFolder}
        # sleep 5
    fi

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
