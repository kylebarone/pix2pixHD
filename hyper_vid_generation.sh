#!/bin/bash


echo "-----------------Generating Zoom 1,-----------------"
python3 generate_video.py --name light --dataroot ./datasets/light_dataset/ --fps 24 --ngf 32 --which_epoch 176 --how_many 600 --dont_crop_720 --zoom_lvl 1 --extra_output_dir zoom_expierement

echo "-----------------Generating Zoom 1-----------------"
python3 generate_video.py --name light --dataroot ./datasets/light_dataset/ --fps 24 --ngf 32 --which_epoch 176 --how_many 600 --dont_crop_720 --zoom_lvl 2 --extra_output_dir zoom_expierement

echo "-----------------Generating Zoom 1,-----------------"
python3 generate_video.py --name light --dataroot ./datasets/light_dataset/ --fps 24 --ngf 32 --which_epoch 176 --how_many 600 --dont_crop_720 --zoom_lvl 1 --extra_output_dir zoom_expierement --start_from ~/test_rainbow.jpg