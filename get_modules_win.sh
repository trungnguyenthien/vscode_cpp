# Định nghĩa thư mục đích
$DEST_DIR = "modules"

# Tạo thư mục modules nếu nó không tồn tại
if (-not (Test-Path -Path $DEST_DIR)) { New-Item -ItemType Directory -Path $DEST_DIR }

# Đọc từng dòng từ file
Get-Content modules.txt | ForEach-Object {
  $parts = $_ -split ' '
  $module, $version, $link = $parts[0], $parts[1], $parts[2]
  
  # Tạo URL cho tệp tin được nén
  $url = "${link}/archive/refs/tags/v${version}.tar.gz"
  
  # Tải và giải nén tệp tin
  Invoke-WebRequest -Uri $url -OutFile "$DEST_DIR\$module.tar.gz"
  tar -xf "$DEST_DIR\$module.tar.gz" -C $DEST_DIR
  Remove-Item "$DEST_DIR\$module.tar.gz" # Xóa file nén sau khi giải nén
}

Write-Host "Download và giải nén hoàn tất!"
