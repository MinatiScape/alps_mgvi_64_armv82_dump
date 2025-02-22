#!/bin/bash

cat product/app/webview/webview.apk.* 2>/dev/null >> product/app/webview/webview.apk
rm -f product/app/webview/webview.apk.* 2>/dev/null
cat system_ext/app/MiraVision/MiraVision.apk.* 2>/dev/null >> system_ext/app/MiraVision/MiraVision.apk
rm -f system_ext/app/MiraVision/MiraVision.apk.* 2>/dev/null
cat system_ext/apex/com.android.vndk.v30.apex.* 2>/dev/null >> system_ext/apex/com.android.vndk.v30.apex
rm -f system_ext/apex/com.android.vndk.v30.apex.* 2>/dev/null
cat vendor_boot.img.* 2>/dev/null >> vendor_boot.img
rm -f vendor_boot.img.* 2>/dev/null
cat boot.img.* 2>/dev/null >> boot.img
rm -f boot.img.* 2>/dev/null
