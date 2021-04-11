<img src='imgs/teaser_720.gif' align="right" width=360>

<br><br><br><br>

# pix2pixHD for video generation of Jellyfish
### Kyle Barone | Diana Kim | Cathryn Gold | Ethan Yu
This is our project for VIP team Art & AI focused on using artifical intelligence to explore the creative works. We use the pix2pix framework to train a conditional GAN network to generate video. The pix2pix framework is generative network that can be trained to learn an image to image translation. This has been used to create cool applications such as [edges to cat](https://affinelayer.com/pix2pix/) and others. We are applying this archetecture by seperating training videos into image frames, then training the network to predict the *t+1* frame given the *t*th frame. This way we are attempting to create a mapping from for the next frame of a video. As a result we have found that videos that are reptitive or repeat simple pattern or action multiple times over perform better. The generation capabilities of this network is very shallow in the sense that it is trained on a single video and tries to generate a plausible replica of the video. 


## Prerequisites
To run natively:
- Linux or macOS
- Python 2 or 3
- NVIDIA GPU (12G or 24G memory) + CUDA cuDNN
<br> 
#### Or If your like me and dont have a GPU: <br>
- Google Cloud Account

## Getting Started (since no one in our group has a GPU setup, this guide is through using a GCP instance.
### Setting up GCP Instance (First time)
- Create a google cloud  platform account and download [Google Cloud SDK](https://cloud.google.com/sdk/docs/install). You get 300$ of free compute credits. 
- Search for the deep learning vm and click launch. The settings I have been using is 2-vCPUs and 1 GPU NVIDIA Tesla T4 on the us-east1-d zone but I think this can vary, I chose T4 based on the low price per hour. Change the framework to PyTorch 1.8 + fast.ai 2.1 (CUDA 11.0). Check the box "Install NVIDIA GPU driver automatically on first startup?" and deploy.
- The first time GCP has a quota on GPU usage so you must upgrade your account, this is still free and uses free credits just means you'll have to pay if you run over. Next click the quotas page on the quota warning on the top of the page. Click the compute engine api -> Edit quotas -> Global. Now you can request the use for GPUs (I chose 2). Mine was approved imediately. 
- Now you can deploy an instance and click on SSH to open the command for the instance. 

- Install python libraries [dominate](https://github.com/Knio/dominate).
```bash
pip install dominate
```
- Clone this repo:
```bash
git clone https://github.com/NVIDIA/pix2pixHD
cd pix2pixHD
```


### Testing
- A few example Cityscapes test images are included in the `datasets` folder.
- Please download the pre-trained Cityscapes model from [here](https://drive.google.com/file/d/1h9SykUnuZul7J3Nbms2QGH1wa85nbN2-/view?usp=sharing) (google drive link), and put it under `./checkpoints/label2city_1024p/`
- Test the model (`bash ./scripts/test_1024p.sh`):
```bash
#!./scripts/test_1024p.sh
python test.py --name label2city_1024p --netG local --ngf 32 --resize_or_crop none
```
The test results will be saved to a html file here: `./results/label2city_1024p/test_latest/index.html`.

More example scripts can be found in the `scripts` directory.


### Dataset
- We use the Cityscapes dataset. To train a model on the full dataset, please download it from the [official website](https://www.cityscapes-dataset.com/) (registration required).
After downloading, please put it under the `datasets` folder in the same way the example images are provided.


### Training
- Train a model at 1024 x 512 resolution (`bash ./scripts/train_512p.sh`):
```bash
#!./scripts/train_512p.sh
python train.py --name label2city_512p
```
- To view training results, please checkout intermediate results in `./checkpoints/label2city_512p/web/index.html`.
If you have tensorflow installed, you can see tensorboard logs in `./checkpoints/label2city_512p/logs` by adding `--tf_log` to the training scripts.

### Multi-GPU training
- Train a model using multiple GPUs (`bash ./scripts/train_512p_multigpu.sh`):
```bash
#!./scripts/train_512p_multigpu.sh
python train.py --name label2city_512p --batchSize 8 --gpu_ids 0,1,2,3,4,5,6,7
```
Note: this is not tested and we trained our model using single GPU only. Please use at your own discretion.

### Training at full resolution
- To train the images at full resolution (2048 x 1024) requires a GPU with 24G memory (`bash ./scripts/train_1024p_24G.sh`).
If only GPUs with 12G memory are available, please use the 12G script (`bash ./scripts/train_1024p_12G.sh`), which will crop the images during training. Performance is not guaranteed using this script.

### Training with your own dataset
- If you want to train with your own dataset, please generate label maps which are one-channel whose pixel values correspond to the object labels (i.e. 0,1,...,N-1, where N is the number of labels). This is because we need to generate one-hot vectors from the label maps. Please also specity `--label_nc N` during both training and testing.
- If your input is not a label map, please just specify `--label_nc 0` which will directly use the RGB colors as input. The folders should then be named `train_A`, `train_B` instead of `train_label`, `train_img`, where the goal is to translate images from A to B.
- If you don't have instance maps or don't want to use them, please specify `--no_instance`.
- The default setting for preprocessing is `scale_width`, which will scale the width of all training images to `opt.loadSize` (1024) while keeping the aspect ratio. If you want a different setting, please change it by using the `--resize_or_crop` option. For example, `scale_width_and_crop` first resizes the image to have width `opt.loadSize` and then does random cropping of size `(opt.fineSize, opt.fineSize)`. `crop` skips the resizing step and only performs random cropping. If you don't want any preprocessing, please specify `none`, which will do nothing other than making sure the image is divisible by 32.

## More Training/Test Details
- Flags: see `options/train_options.py` and `options/base_options.py` for all the training flags; see `options/test_options.py` and `options/base_options.py` for all the test flags.
- Instance map: we take in both label maps and instance maps as input. If you don't want to use instance maps, please specify the flag `--no_instance`.


## Citation

If you find this useful for your research, please use the following.

```
@inproceedings{wang2018pix2pixHD,
  title={High-Resolution Image Synthesis and Semantic Manipulation with Conditional GANs},
  author={Ting-Chun Wang and Ming-Yu Liu and Jun-Yan Zhu and Andrew Tao and Jan Kautz and Bryan Catanzaro},  
  booktitle={Proceedings of the IEEE Conference on Computer Vision and Pattern Recognition},
  year={2018}
}
```

## Acknowledgments
This code borrows heavily from [pytorch-CycleGAN-and-pix2pix](https://github.com/junyanz/pytorch-CycleGAN-and-pix2pix).
<br>
This is not all our work, this work is forked from JC Testud [Repository](https://github.com/jctestud/pix2pixHD.git) and this project is heavily based of his medium article [Video Generation With pix2pix](https://medium.com/@jctestud/video-generation-with-pix2pix-aed5b1b69f57) , check it and give it like. 
<br>
The core archetecture and code comes from NVIDIA's paper that introduced the pix2pix framework. See [NVIDIA repo](https://tcwang0509.github.io/pix2pixHD/) | [Youtube](https://youtu.be/3AIpPlzM_qs) | [Paper](https://arxiv.org/pdf/1711.11585.pdf) <br>
