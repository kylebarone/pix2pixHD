#!/bin/bash

echo "Starting the script file that runs and creates 10 second videos"

echo "-----------------Generating EPOCH 10-----------------"
python3 generate_video.py --name light --dataroot ./datasets/light_dataset/ --fps 24 --ngf 32 --which_epoch 10 --how_many $1 --dont_crop_720 --start_from ~/test_rainbow.jpg 

echo "-----------------Generating EPOCH 20-----------------"
python3 generate_video.py --name light --dataroot ./datasets/light_dataset/ --fps 24 --ngf 32 --which_epoch 20 --how_many $1 --dont_crop_720 --start_from ~/test_rainbow.jpg

echo "-----------------Generating EPOCH 40-----------------"
python3 generate_video.py --name light --dataroot ./datasets/light_dataset/ --fps 24 --ngf 32 --which_epoch 40 --how_many $1 --dont_crop_720 --start_from ~/test_rainbow.jpg 

echo "-----------------Generating EPOCH 80-----------------"
python3 generate_video.py --name light --dataroot ./datasets/light_dataset/ --fps 24 --ngf 32 --which_epoch 80 --how_many $1 --dont_crop_720 --start_from ~/test_rainbow.jpg 

echo "-----------------Generating EPOCH 120-----------------"
python3 generate_video.py --name light --dataroot ./datasets/light_dataset/ --fps 24 --ngf 32 --which_epoch 120 --how_many $1 --dont_crop_720 --start_from ~/test_rainbow.jpg

echo "-----------------Generating EPOCH 140-----------------"
python3 generate_video.py --name light --dataroot ./datasets/light_dataset/ --fps 24 --ngf 32 --which_epoch 140 --how_many $1 --dont_crop_720 --start_from ~/test_rainbow.jpg 

echo "-----------------Generating EPOCH 178-----------------"
python3 generate_video.py --name light --dataroot ./datasets/light_dataset/ --fps 24 --ngf 32 --which_epoch 178 --how_many $1 --dont_crop_720 --start_from ~/test_rainbow.jpg

echo "-----------------Generating EPOCH 179-----------------"
python3 generate_video.py --name light --dataroot ./datasets/light_dataset/ --fps 24 --ngf 32 --which_epoch 179 --how_many $1 --dont_crop_720 --start_from ~/test_rainbow.jpg

echo "-----------------Generating EPOCH 180-----------------"
python3 generate_video.py --name light --dataroot ./datasets/light_dataset/ --fps 24 --ngf 32 --which_epoch 180 --how_many $1 --dont_crop_720 --start_from ~/test_rainbow.jpg

echo "-----------------Generating EPOCH 13-----------------"
python3 generate_video.py --name light --dataroot ./datasets/light_dataset/ --fps 24 --ngf 32 --which_epoch 183 --how_many $1 --dont_crop_720 --start_from ~/test_rainbow.jpg

echo "-----------------Generating EPOCH 190-----------------"
python3 generate_video.py --name light --dataroot ./datasets/light_dataset/ --fps 24 --ngf 32 --which_epoch 190 --how_many $1 --dont_crop_720 --start_from ~/test_rainbow.jpg

echo "-----------------Generating EPOCH 192-----------------"
python3 generate_video.py --name light --dataroot ./datasets/light_dataset/ --fps 24 --ngf 32 --which_epoch 192 --how_many $1 --dont_crop_720 --start_from ~/test_rainbow.jpg

echo "-----------------Generating EPOCH 195-----------------"
python3 generate_video.py --name light --dataroot ./datasets/light_dataset/ --fps 24 --ngf 32 --which_epoch 195 --how_many $1 --dont_crop_720 --start_from ~/test_rainbow.jpg
