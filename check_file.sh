#!/bin/sh

CHECK(){
if [ -f /home/docker/OCM_Build_APP/apk/app-release.apk  ]; then
    # 檔案 /path/to/dir/filename 存在
    #echo "File /path/to/dir/filename exists."
    echo "APK Build Finish"
else
    # 檔案 /path/to/dir/filename 不存在
    #echo "File /path/to/dir/filename does not exists."
    echo "sleep 5"
    sleep 5
    echo "Check Again"
    CHECK
fi
}

CHECK
