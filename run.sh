#!/bin/bash

 nohup /google_appengine/dev_appserver.py --skip_sdk_update_check --host=0.0.0.0  /WebRTC/apprtc/out/app_engine &> apprtc.log &

/WebRTC/collider_root/bin/collidermain -port=8089 -tls=false -room-server=http://localhost:8080 

