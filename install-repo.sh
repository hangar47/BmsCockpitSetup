#!/bin/bash

curl -fsSL https://gtirepo.s3.eu-central-1.amazonaws.com/gtirepo.gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/gtirepo.gpg
echo "deb [arch=arm64 signed-by=/etc/apt/trusted.gpg.d/gtirepo.gpg] https://gtirepo.s3.eu-central-1.amazonaws.com bookworm main" | sudo tee /etc/apt/sources.list.d/gtirepo.list
sudo apt update
