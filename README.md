# ContainerStarter
## Introduction
ContainerStarter is a simple script to start a Docker container and automatically mount host directories into it. This project is designed to make it easy to work with your host files inside a Docker container.

## Configuration
Before running the container, open configs.yaml and configure your settings:
- `base_dir_host`: The root folder (your workspace) on your host machine where your projects are located.
- `base_dir_container`: The workspace path inside the container where your host projects will be mounted.
- `mount_dirs`: A list of directories (relative to base_dir_host) that you want to mount into the container.
- `image_id`: The ID of your Docker image.
- `container_name`: The name you want to assign to the container.

## Usage
1. Navigate to the project directory.
2. Configure your Docker container in `configs.yaml`.
3. Run the script: `bash run_container.sh`
4. Your Docker container is now running and your host files are mounted.
<b>Tip</b>: You can open another terminal and run bash run_container.sh again. It will connect to the same running container.

## Notes
- Make sure Docker is installed and running on your system.
- Make sure python3 is installed on your system, the project requires python to read the yaml file.
- The script assumes the container is not already running under a different name.
- Mount paths are relative to `base_dir_host`.
