#!/bin/bash

# Function to undefine a virtual machine.  Takes just the VM name.
# This makes it more robust and aligned with how virsh expects the name.
undefine_vm() {
  local vm_name="$1"

  # Use virsh undefine to undefine a virtual machine
  sudo virsh undefine "$vm_name"

  # Check if the command was successful
  if [ $? -eq 0 ]; then
    echo "Successfully undefined virtual machine $vm_name"
  else
    echo "Failed to undefine virtual machine $vm_name"
  fi
}

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
    # Extract the VM name from the full path
    vm_name=$(basename "$root_vm" .xml)  # Removes the .xml extension

    # Call the undefine function
    undefine_vm "$vm_name"
  fi
done

echo "Finished undefining all root virtual machines."


# Directory containing XML definitions of virtual machines requiring user permissions
SESSION="./session/"

# Ensure the directory exists
if [ ! -d "$SESSION" ]; then
  echo "The specified directory does not exist."
  exit 1
fi

# Loop over each XML file in the directory
for rootless_vm in "$SESSION"/*.xml; do # Corrected the pattern
  if [ -f "$rootless_vm" ]; then
    # Extract the VM name from the full path
    vm_name=$(basename "$rootless_vm" .xml) #remove .xml extension

    # Call the undefine function
    virsh undefine "$vm_name"
  fi
done

echo "Finished undefining all rootless virtual machines."
