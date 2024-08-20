#!/bin/bash

# Function to display menu and get user choice
display_menu() {
    echo "Please select the Windows Server version:"
    echo "1. Windows 10 Enterprise"
    echo "2. Windows 10 Pro"
    echo "3. Windows Server 2022"
    read -p "Enter your choice: " choice
}

# Update package repositories and upgrade existing packages
apt-get update && apt-get upgrade -y

# Install QEMU and its utilities
apt-get install qemu -y
apt install qemu-utils -y
apt install qemu-system-x86-xen -y
apt install qemu-system-x86 -y
apt install qemu-kvm -y

echo "QEMU installation completed successfully."

# Get user choice
display_menu

case $choice in
    1)
        # Windows Server 2016
        img_file="windows10.img"
        iso_link="https://software-static.download.prss.microsoft.com/dbazure/988969d5-f34g-4e03-ac9d-1f9786c66750/19045.2006.220908-0225.22h2_release_svc_refresh_CLIENTENTERPRISEEVAL_OEMRET_x64FRE_en-us.iso"
        iso_file="windows10.iso"
        ;;
    2)
        # Windows Server 2019
        img_file="windows10pro.img"
        iso_link="https://download1321.mediafire.com/ey92kdii9hogQWSXWBc8qj7ek9KEn9XypP6y7TYC-PgWlRGMX4_GCMgWnJduyg4XpoDoq4_em9T98o7Wdma4IJslx2_jl60hNF7EtjjnM8TGcoKJXReoK-NFg6B_M5lCu9pDWljcMHDdS0MNk4rRftdHURg9LaOhfEPxUxzcyaOWGjs/fgcl3fy6rck26ol/Win10_22H2_English_x64v1.iso"
        iso_file="windows10pro.iso"
        ;;
    3)
        # Windows Server 2022
        img_file="windows2022.img"
        iso_link="https://go.microsoft.com/fwlink/p/?LinkID=2195280&clcid=0x409&culture=en-us&country=US"
        iso_file="windows2022.iso"
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

echo "Selected Windows Server version: $img_file"

# Create a raw image file with the chosen name
qemu-img create -f raw "$img_file" 30G

echo "Image file $img_file created successfully."

# Download Virtio driver ISO
wget -O virtio-win.iso 'https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.215-1/virtio-win-0.1.215.iso'

echo "Virtio driver ISO downloaded successfully."

# Download Windows ISO with the chosen name
wget -O "$iso_file" "$iso_link"

echo "Windows ISO downloaded successfully."
