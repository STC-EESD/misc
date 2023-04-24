
parse.census.profiles <- function(
    data.directory     = NULL,
    data.snapshot      = NULL,
    geo.levels         = c('Country','Province','Territory','Census subdivision'),
    characteristic.IDs = c(
           1,   2,   3,  34,  35,  36,  37,  38,  40, 244,
         303, 388, 389, 390, 391, 392,1402,1403,1410,1527,
        1528,1529,1537,1683,1684,1697,1998,1999,2000,2001,
        2002,2008,2223,2224,2225,2226,2227,2228,2229,2230
        ),
    CSV.output = "DF-census-profiles.csv"
    ) {

    thisFunctionName <- "parse.census.profiles";
    cat("\n### ~~~~~~~~~~~~~~~~~~~~ ###");
    cat(paste0("\n",thisFunctionName,"() starts.\n\n"));

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    CSV.input <- file.path(
        data.directory,
        data.snapshot,
        "98-401-X2021005_eng_CSV",
        "98-401-X2021005_English_CSV_data.csv"
        );

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    DF.input <- read.csv(
        file = CSV.input
        );

    cat("\nstr(DF.input)\n");
    print( str(DF.input)   );

    cat("\nsort(unique(DF.input[,'GEO_LEVEL']))\n");
    print( sort(unique(DF.input[,'GEO_LEVEL']))   );

    cat("\nsort(unique(DF.input[,c('CHARACTERISTIC_ID')]))\n");
    print( sort(unique(DF.input[,c('CHARACTERISTIC_ID')]))   );

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    DF.output <- DF.input[ DF.input[, 'CHARACTERISTIC_ID'] %in% characteristic.IDs,];
    DF.output <- DF.output[DF.output[,'GEO_LEVEL']         %in% geo.levels,        ];

    cat("\nstr(DF.output)\n");
    print( str(DF.output)   );

    cat("\nsort(unique(DF.output[,'GEO_LEVEL']))\n");
    print( sort(unique(DF.output[,'GEO_LEVEL']))   );

    cat("\nsort(unique(DF.output[,c('CHARACTERISTIC_ID')]))\n");
    print( sort(unique(DF.output[,c('CHARACTERISTIC_ID')]))   );

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    write.csv(
        file      = CSV.output,
        x         = DF.output,
        row.names = FALSE
        );

    ### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
    cat(paste0("\n",thisFunctionName,"() quits."));
    cat("\n### ~~~~~~~~~~~~~~~~~~~~ ###\n");
    return( NULL );

    }

##################################################
