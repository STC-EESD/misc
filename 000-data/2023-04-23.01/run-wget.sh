#!/bin/bash

# https://www12.statcan.gc.ca/census-recensement/2021/dp-pd/prof/details/download-telecharger.cfm?Lang=E

tempzip="https://www12.statcan.gc.ca/census-recensement/2021/dp-pd/prof/details/download-telecharger/comp/GetFile.cfm?Lang=E&FILETYPE=CSV&GEONO=005"
echo;echo downloading: ${tempzip}
wget ${tempzip}

downloadedFileStem=98-401-X2021005_eng_CSV
mv GetFile* ${downloadedFileStem}.zip
unzip ${downloadedFileStem}.zip -d ${downloadedFileStem}
sleep 2
rm -f ${downloadedFileStem}.zip
