#!/bin/bash

PROGRAM_NAME="inv-tui-go"
INSTALL_DIR="/usr/local/bin"
BIN_PATH="$INSTALL_DIR/$PROGRAM_NAME"
DB_DIR="/etc/$PROGRAM_NAME"

echo "Starting the uninstallation of $PROGRAM_NAME..."

if [ -f "$BIN_PATH" ]; then
  echo "Removing binary at $BIN_PATH..."
  sudo rm -f "$BIN_PATH"
  echo "Binary removed."
else
  echo "Binary not found at $BIN_PATH."
fi

if [ -d "$DB_DIR" ]; then
  echo "Removing configuration directory at $DB_DIR..."
  sudo rm -rf "$DB_DIR"
  echo "Configuration directory removed."
else
  echo "Configuration directory not found at $DB_DIR."
fi

echo "$PROGRAM_NAME successfully uninstalled!"
