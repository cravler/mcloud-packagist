#!/bin/bash

MY_PATH="`dirname \"$0\"`"

ssh-keygen -t rsa -C "packagist" -f "$MY_PATH/ssh/id_rsa"

echo ''
echo 'id_rsa.pub:'
echo ''
tail "$MY_PATH/ssh/id_rsa.pub"
echo ''
echo '>>> DONE <<<'
echo ''