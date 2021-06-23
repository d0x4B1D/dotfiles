#!/bin/bash

pushd $(dirname $0) > /dev/null

cp ./config/zshrc ~/.zshrc

popd > /dev/null

