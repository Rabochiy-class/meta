#!/bin/bash

updatef() {
    case $1 in
        bot|all)
            cd ./backend
            git pull
            cd ..
            ;;
        meta|all)
            cd ./meta
            git pull
            cd ..
            ;;
        backend|all)
            cd ./node-backend
            git pull
            cd ..
            ;;
        frontend|all)
            cd ./frontend
            git pull
            cd ..
            ;;
        *)
            echo "Invalid argument: $1"
            ;;
    esac
}

for arg in "$@"; do
    updatef "$arg"
done