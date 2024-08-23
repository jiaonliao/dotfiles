#!/bin/bash

# ANSI color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Configure versions and download links
versions=(
    "8=https://download.java.net/openjdk/jdk8u44/ri/openjdk-8u44-linux-x64.tar.gz"
    "17=https://download.java.net/java/GA/jdk17/0d483333a00540d886896bac774ff48b/35/GPL/openjdk-17_linux-x64_bin.tar.gz"
)

# Iterate through versions array and download & extract
for version_info in "${versions[@]}"
do
    version=$(echo $version_info | cut -d'=' -f1)
    url=$(echo $version_info | cut -d'=' -f2)

    echo -e "${GREEN}Downloading JDK $version...${NC}"
    mkdir -p ~/openjdk_temp
    wget $url -P ~/openjdk_temp

    echo -e "${GREEN}Extracting JDK $version...${NC}"
    target_dir="/home/tools/jdks/jdk$version"
    mkdir -p $target_dir
    tar -xf ~/openjdk_temp/$(basename $url) -C $target_dir --strip-components=1

    # Add alias for java version
    echo "alias j$version='/home/tools/jdks/jdk$version/bin/java'" >> ~/.bashrc
done

# Source the .bashrc file to apply the changes
source ~/.bashrc

# Clean up temporary files
echo -e "${GREEN}Cleaning up temporary files...${NC}"
rm -rf ~/openjdk_temp

echo -e "${GREEN}All JDK versions downloaded, extracted, and temporary files cleaned up successfully${NC}"

