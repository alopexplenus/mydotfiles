#!/bin/bash

# Setup script for time_limit systemd service
# This script must be run as root

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SERVICE_NAME="time_limit"

# Color output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
    exit 1
}

info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    error "This script must be run as root. Please use: sudo $0"
fi

info "Setting up $SERVICE_NAME systemd service..."

# Stop service if already running
if systemctl is-active --quiet "$SERVICE_NAME"; then
    info "Stopping existing service..."
    systemctl stop "$SERVICE_NAME"
fi

# Create necessary directories
info "Creating directories..."
mkdir -p /var/lib/time_limit
mkdir -p /var/log
touch /var/log/time_limit.log
chmod 755 /var/lib/time_limit
chmod 644 /var/log/time_limit.log

# Copy main script
info "Installing script to /usr/local/bin/..."
cp "$SCRIPT_DIR/time_limit.sh" /usr/local/bin/time_limit.sh
chmod 755 /usr/local/bin/time_limit.sh

# Copy service file
info "Installing service file to /etc/systemd/system/..."
cp "$SCRIPT_DIR/time_limit.service" /etc/systemd/system/time_limit.service
chmod 644 /etc/systemd/system/time_limit.service

# Reload systemd
info "Reloading systemd daemon..."
systemctl daemon-reload

# Enable service
info "Enabling service to start on boot..."
systemctl enable "$SERVICE_NAME"

# Start service
info "Starting service..."
systemctl start "$SERVICE_NAME"

# Check status
sleep 1
if systemctl is-active --quiet "$SERVICE_NAME"; then
    info "Service installed and started successfully!"
    echo ""
    info "Useful commands:"
    echo "  - View status:        sudo systemctl status $SERVICE_NAME"
    echo "  - View logs:          sudo journalctl -u $SERVICE_NAME -f"
    echo "  - View log file:      sudo tail -f /var/log/time_limit.log"
    echo "  - Stop service:       sudo systemctl stop $SERVICE_NAME"
    echo "  - Restart service:    sudo systemctl restart $SERVICE_NAME"
    echo "  - Disable service:    sudo systemctl disable $SERVICE_NAME"
    echo ""
    info "Configuration:"
    echo "  - State files:        /var/lib/time_limit/"
    echo "  - Log file:           /var/log/time_limit.log"
    echo "  - Script location:    /usr/local/bin/time_limit.sh"
    echo "  - Service file:       /etc/systemd/system/time_limit.service"
else
    error "Service failed to start. Check logs with: sudo journalctl -u $SERVICE_NAME -n 50"
fi
