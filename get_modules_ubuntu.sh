#!/bin/bash

# Định nghĩa thư mục đích
DEST_DIR="modules"

# Tạo thư mục modules nếu nó không tồn tại
mkdir -p $DEST_DIR

# Đọc từng dòng từ file
while IFS=' ' read -r module version link; do
  # Tạo URL cho tệp tin được nén
  url="${link}/archive/refs/tags/v${version}.tar.gz"
  
  # Tải và giải nén tệp tin
  wget -qO- $url | tar -xz -C $DEST_DIR
done < modules.txt

echo "Download và giải nén hoàn tất!"
