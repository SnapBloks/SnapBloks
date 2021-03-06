#!/bin/sh

if sudo [ -w /etc/udev/rules.d ]; then
  echo "Copying STM32-DFU udev rules..."
  sudo cp -v 90-stm32-dfu.rules /etc/udev/rules.d/90-stm32-dfu.rules
  sudo chown root:root /etc/udev/rules.d/90-stm32-dfu.rules
  sudo chmod 644 /etc/udev/rules.d/90-stm32-dfu.rules
  echo "Reloading udev rules"
  sudo udevadm control --reload-rules
  echo "Adding current user to dialout group"
  sudo adduser "$USER" dialout
else
  echo "Couldn't copy to /etc/udev/rules.d/; you probably have to run this script as root? Or your distribution of Linux doesn't include udev; try running the IDE itself as root."
fi
