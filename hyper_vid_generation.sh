#!/bin/bash

echo "Starting the script file that runs and creates $1 second videos"

echo "-----------------Generating EPOCH 10-----------------"
python3 generate_video.py --name hyper_base --dataroot ./datasets/hyper_dataset/ --fps 24 --ngf 32 --which_epoch 1 --how_many $1 --dont_crop_720 

echo "-----------------Generating EPOCH 20-----------------"
python3 generate_video.py --name hyper_base --dataroot ./datasets/hyper_dataset/ --fps 24 --ngf 32 --which_epoch 5 --how_many $1 --dont_crop_720 

echo "-----------------Generating EPOCH 40-----------------"
python3 generate_video.py --name hyper_base --dataroot ./datasets/hyper_dataset/ --fps 24 --ngf 32 --which_epoch 10 --how_many $1 --dont_crop_720

echo "-----------------Generating EPOCH 80-----------------"
python3 generate_video.py --name v --dataroot ./datasets/hyper_dataset/ --fps 24 --ngf 32 --which_epoch 20 --how_many $1 --dont_crop_720 

echo "-----------------Generating EPOCH 80-----------------"
python3 generate_video.py --name v --dataroot ./datasets/hyper_dataset/ --fps 24 --ngf 32 --which_epoch 20 --how_many $1 --dont_crop_720 --start_from ~/test_rainbow.jpg
