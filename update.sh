#!/bin/bash

clone_repository {
    case $1 in
        bot|all)
            git clone git@bot:Rabochiy-class/backend.git
            ;;
        meta|all)
            git clone git@meta:Rabochiy-class/meta.git
            cp -r ./meta/* ./
            ;;
        backend|all)
            git clone git@backend:Rabochiy-class/node-backend.git
            ;;
        frontend|all)
            git clone git@frontend:Rabochiy-class/frontend.git
            ;;
        *)
            echo "Invalid argument: $1"
            ;;
    esac
}

for arg in "$@"; do
    clone_repository "$arg"
done