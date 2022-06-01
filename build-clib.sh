#!/usr/bin/env bash

###
### DEPENDENCY LIBRARY BUILDER SCRIPT
### redthing1
###

set -e

HOST="faiss-d"
LIB_NAME="faiss"
SOURCETREE_URL="https://github.com/facebookresearch/faiss"
SOURCETREE_DIR="faiss_source"
LIB_FILE="libfaiss_c.a"

PACKAGE_DIR=$(dirname "$0")
cd "$PACKAGE_DIR"
pushd .
if [ ! -f $LIB_FILE ] || [ "$1" == "-f" ]; then
    echo "[$HOST] building $LIB_NAME library..."

    # delete $SOURCETREE_DIR to force re-fetch source
    if [ -d $SOURCETREE_DIR ] 
    then
        echo "[$HOST] source folder already exists, using it." 
    else
        echo "[$HOST] getting source to build $LIB_NAME" 
        git clone $SOURCETREE_URL $SOURCETREE_DIR
    fi

    cd $SOURCETREE_DIR
    git checkout v1.7.2
    git submodule update --init --recursive

    echo "[$HOST] starting build of $LIB_NAME" 
    #
    # START BUILD
    #
    # build the library
    cd c_api/
    cmake -B build . -DCMAKE_BUILD_TYPE=Release
    cd build
    make -j$(nproc)
    #
    # END BUILD
    #

    echo "[$HOST] finished build of $LIB_NAME" 

    echo "[$HOST] copying $LIB_NAME binary ($LIB_FILE)" 
    cp -v $(pwd)/$LIB_FILE $PACKAGE_DIR/$LIB_FILE
    popd
else
    # delete $LIB_FILE to force rebuild
    echo "[$HOST] library $LIB_NAME already built."
fi
