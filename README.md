<img src='imgs/teaser_jelly.gif' align="right" width=360>

<br><br><br><br>

# pix2pixHD for video generation of Jellyfish
### Kyle Barone | Diana Kim | Cathryn Gold | Ethan Yu
This is our project for VIP team Art & AI focused on using artifical intelligence to explore the creative works. We use the pix2pix framework to train a conditional GAN network to generate video. The pix2pix framework is generative network that can be trained to learn an image to image translation. This has been used to create cool applications such as [edges to cat](https://affinelayer.com/pix2pix/) and others. We are applying this archetecture by seperating training videos into image frames, then training the network to predict the *t+1* frame given the *t*th frame. This way we are attempting to create a mapping from for the next frame of a video. As a result we have found that videos that are reptitive or repeat simple pattern or action multiple times over perform better. The generation capabilities of this network is very shallow in the sense that it is trained on a single video and tries to generate a plausible replica of the video. 

## Prerequisites
To run natively:
- Linux or macOS
- Python 2 or 3
- NVIDIA GPU (12G or 24G memory) + CUDA cuDNN
- **Or** Google Cloud Account

## Getting Started (since no one in our group has a GPU setup, this guide is through using a GCP instance.
### Setting up & Launching GCP Instance (First time)
- Create a google cloud  platform account and download [Google Cloud SDK](https://cloud.google.com/sdk/docs/install). You get 300$ of free compute credits. 
- Search for the "Deep Learning VM" and click launch. The settings I have been using is 2-vCPUs and 1 GPU NVIDIA Tesla T4 on the us-east1-d zone but I think this can vary, I chose T4 based on the low price per hour. Change the framework to PyTorch 1.8 + fast.ai 2.1 (CUDA 11.0). Check the box "Install NVIDIA GPU driver automatically on first startup?" and deploy.
- The first time GCP has a quota on GPU usage so you must upgrade your account, this is still free and uses free credits just means you'll have to pay if you run over. Next click the quotas page on the quota warning on the top of the page. Click the compute engine api -> Edit quotas -> Global. Now you can request the use for GPUs (I chose 2). Mine was approved imediately. 
- Now you can deploy an instance and click on SSH to open the command for the instance. 
      -(If you get a ResourceType Error try a different region)
      
### Installation
- Install python libraries [dominate](https://github.com/Knio/dominate).
```bash
pip install dominate
```
- Clone this repo and the source video repo:
```bash
git clone -b video https://github.com/kylebarone/pix2pixHD
git clone https://github.com/kylebarone/source-videos-nextFramePred.git
cd pix2pixHD
```


### Dataset
- Train the algorithim on a specific video so acquire an mp4 video your hoping to train, longer videos take much longer to train so I've been so far expierementing with 20-60second videos. 
- So all our work stays together, create a directory in [source-videos-nextFramePred](https://github.com/kylebarone/source-videos-nextFramePred) and add the following to the directory: source video, textfile with video details (length & resolution), any generated videos, and checkpoints/<project>/loss_log.txt
- Create dataset from videos with the following command. For resolution use the closest number divisible by 32. 
```bash
python3 extract_frames.py -video ~/source-videos-nextFramePred/<video_dir>/<vid_name>.mp4 -name jellyfish_dataset -p2pdir . -width 1280 -height 736
```


### Training
- Train model 
```bash
python3 train_video.py --name <project_name> --dataroot ./datasets/jellyfish_dataset/ --save_epoch_freq 1 --ngf 32
```
- To view training loss data, please checkout intermediate results in `./checkpoints/<project_name>/loss_log.txt`.
If you have tensorflow installed, you can see tensorboard logs in `./checkpoints/<project_name>/logs` by adding `--tf_log` to the training scripts.


### Video Generation
- To generate a video use the following commands
```bash
python3 generate_video.py --name fire_project --dataroot ./datasets/jellyfish_dataset/ --fps 24 --ngf 32 --which_epoch 1 --how_many 200
```
- And to generate a progress video that starts the video using the 1st epoch generation of the model and transitions to the final
```bash
python3 generate_progress_video.py --name <project_name> --dataroot ./datasets/jellyfish_dataset/ --fps 24 --ngf 32 --pstart 1 --pstop 47
```

### Group Colloborative Structure
- Code changes (if any) go to pix2pixHD git.
- Do not upload checkpoints/ to git cause it tends to be super big, if you wanna save model data (checkpoints/) then I suggest saving it to a gcp sotrage bucket.
- Upload source video, textfile with video details (length & resolution), any generated videos, and loss data (checkpoints/<project>/loss_log.txt) to [source-videos-nextFramePred](https://github.com/kylebarone/source-videos-nextFramePred).
      - Persoanlly I have been just uploading all of checkpoints/<project> to gcp storage then download those specific files to local then git from there.

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
