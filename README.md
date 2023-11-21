# Important
1. This project uses `git lfs`.
You will need to:
- clone this repository
- change dir to repo dir
- `git lfs pull`
2. install mmdetection and mmcv

# How to start train/val process:
#### 1. Specify my_config.py for your device.

#### 2. Run:
```
python /home/$USERNAME/mmdetection/tools/train.py my_config.py
```
or specify your mmdetecion path.

# Dockerfile

Required:
- Nvidia GPU
- Nvidia Driver.
- Cuda 12.0.0
- nvidia-container-runtime

Check file content ```/etc/docker/daemon.json```
It should look like:
```
{
  "runtimes": {
    "nvidia": {
      "path": "/usr/bin/nvidia-container-runtime",
      "runtimeArgs": []
    }
  },
  "default-runtime": "nvidia"
}
```
Build image:
```
sudo docker build -t support_detection .
```
Run container:
```
sudo docker run --memory=16g --gpus all -it support_detection
```
Run training in docker bash:
```
python /mmdetection/tools/train.py my_config_docker.py
```
Tested on Nvidia RTX 3090Ti with Cuda driver 12.0.0
