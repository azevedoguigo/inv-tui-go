#!/bin/bash

PROGRAM_NAME="inv-tui-go"
INSTALL_DIR="/usr/local/bin"
BIN_PATH="$INSTALL_DIR/$PROGRAM_NAME"
DB_DIR="/etc/$PROGRAM_NAME"
DB_FILE="$DB_DIR/inventory.json"
SRC_DIR="./"

echo "Starting the installation of $PROGRAM_NAME..."

if ! command -v go &> /dev/null; then
  echo "Go is not installed. Install Go first so that the installation script can compile the application."
  exit 1
fi

echo "Compiling..."
if ! go build -o "$PROGRAM_NAME" "$SRC_DIR/main.go"; then
  echo "Go code compilation failed. Check for errors."
  exit 1
fi

echo "Copying files..."
sudo cp "$PROGRAM_NAME" "$BIN_PATH"
sudo chmod +x "$BIN_PATH"

if [ ! -f "$DB_FILE" ]; then
  echo "Creating cache file..."
  
  if ! sudo mkdir -p "$DB_DIR"; then
    echo "Failed to create directory $DB_DIR. Check permissions."
    exit 1
  fi
  
  if ! echo '{}' | sudo tee "$DB_FILE" > /dev/null; then
    echo "Failed to create JSON file $DB_FILE. Check permissions."
    exit 1
  fi

  sudo chmod 644 "$DB_FILE"
  sudo chown $USER:$USER "$DB_FILE"

  echo "Cache file created successfully!"
else
  echo "The cache file already exists. No action was taken."
fi

if [ -f "$BIN_PATH" ] && [ -f "$DB_FILE" ]; then
  echo "$PROGRAM_NAME successfully installed!"
else
  echo "Installation error!"
  exit 1
fi
