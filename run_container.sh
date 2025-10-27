#!/usr/bin/env bash
SCRIPT_DIR="$(dirname "$(realpath "$0")")"

eval "$(python3 $SCRIPT_DIR/parse_config.py)"
echo "Using image ID: $IMAGE_ID"
echo "Got mounted paths: $MOUNT_DIRS"
echo "Using container name: $CONTAINER_NAME"

# Split MOUNT_DIRS into an array
IFS=' ' read -r -a mount_dirs <<< "$MOUNT_DIRS"
# Iterate over the array
for dir in "${mount_dirs[@]}"; do
    echo "Mounting directory: $dir"
    MOUNT_ARGS+=("-v" "$dir")
done

echo "Configuration complete. Attempting to container..."
# Check if a container with the same name is already running
if [ "$(docker ps -aq -f name="$CONTAINER_NAME")" ]; then
    echo "Container with name $CONTAINER_NAME already exists. "
    # Check if the container is running
    if [ "$(docker ps -q -f name="$CONTAINER_NAME")" ]; then
        echo "Container is already running. Attaching to it..."
        docker exec -it "$CONTAINER_NAME" bash
    else
        echo "Starting existing container..."
        docker start -ai "$CONTAINER_NAME"
    fi
else
    # No existing container found, create a new one
    echo "No existing container found. Creating a new one..."
    docker run -it \
    "${MOUNT_ARGS[@]}" \
    --network host \
    --name "$CONTAINER_NAME" \
    "$IMAGE_ID" \
    bash
fi
