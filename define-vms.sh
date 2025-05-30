#!/bin/bash

# Directory containing XML definitions of virtual machines requiring root permissions
SYSTEM="./system/"

# Ensure the directory exists
if [ ! -d "$SYSTEM" ]; then
  echo "The specified directory does not exist."
  exit 1
fi

# Loop over each XML file in the directory
for root_vm in "$SYSTEM"/*.xml; do
  if [ -f "$root_vm" ]; then
    # Use virsh define to create a virtual machine from each XML file
    sudo virsh define "$root_vm"
    
    # Check if the command was successful
    if [ $? -eq 0 ]; then
      echo "Successfully defined virtual machine from $root_vm"
    else
      echo "Failed to define virtual machine from $root_vm"
    fi
  else
    echo "No XML files found in directory: $SYSTEM"
  fi
done

echo "Finished defining all root virtual machines."

# Directory containing XML definitions of virtual machines requiring user permissions
SESSION="./session/"

# Ensure the directory exists
if [ ! -d "$SESSION" ]; then
  echo "The specified directory does not exist."
  exit 1
fi

# Loop over each XML file in the directory
for rootless_vm in "$SESSION"/*.xml; do
  if [ -f "$rootless_vm" ]; then
    # Use virsh define to create a virtual machine from each XML file
    virsh define "$rootless_vm"
    
    # Check if the command was successful
    if [ $? -eq 0 ]; then
      echo "Successfully defined virtual machine from $rootless_vm"
    else
      echo "Failed to define virtual machine from $rootless_vm"
    fi
  else
    echo "No XML files found in directory: $SESSION"
  fi
done

echo "Finished defining all rootless virtual machines."