import sys
import argparse
from typing import List

import yaml

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Parse docker container config")
    parser.add_argument("--config", default="configs.yaml", help="Path to the config file")
    args = parser.parse_args()

    path = sys.path[0]
    
    with open(f"{path}/{args.config}", "r") as file:
        config: dict = yaml.safe_load(file)

    base_dir_host: str = config.get("base_dir_host", "")
    mount_dirs: List[str] = config.get("mount_dirs", [])
    container_name: str = config.get("container_name", "")
    base_dir_container: str = config.get("base_dir_container", "")

    mounts: List[str] = []
    for dir_name in mount_dirs:
        host_dir: str = f"{base_dir_host}/{dir_name}"
        docker_dir: str = f"{base_dir_container}/{dir_name}"
        mounts.append(f"{host_dir}:{docker_dir}")

    image_id: str = config.get("image_id", "")
    print(f'MOUNT_DIRS="{ " ".join(mounts) }"')
    print(f'IMAGE_ID="{image_id}"')
    print(f'CONTAINER_NAME="{container_name}"')
    