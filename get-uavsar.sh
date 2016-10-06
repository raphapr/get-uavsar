#!/bin/bash

# EarthData credentials (https://urs.earthdata.nasa.gov)
USER="username"
PASSWORD="password"

# Get the authentication cookie: credentials are used to set authentication cookies
echo "Authenticating..."
wget --keep-session-cookies --save-cookies cookies.txt --post-data="userid=$USER&password=$PASSWORD" --no-check-certificate https://vertex.daac.asf.alaska.edu/services/authentication -o cookieslog.txt
echo "Authenticated"

# Get the metalink file: platform UAVSAR; processingLevel COMPLEX, METADATA; output METALINK
echo "Fetching file list..."
wget -O myfilename.metalink --no-check-certificate "https://api.daac.asf.alaska.edu/services/search/param?platform=UAVSAR&processingLevel=METADATA,COMPLEX&output=METALINK"

# Run the aria2 after inserting myfilename.metalink from your API search results at the command line.
# Data will be downloaded to the DATA directory.
echo "Starting data download..."
aria2c --load-cookies=cookies.txt --summary-interval=10 --max-concurrent-downloads=5 --dir data --auto-file-renaming=false --allow-overwrite=false --log=arialog.txt -M myfilename.metalink
echo "Download Completed!"
