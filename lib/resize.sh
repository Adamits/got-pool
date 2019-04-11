#! /bin/bash

for f in /Users/ajwieme/got-pool/app/assets/images/*.jpeg; do
  python3 /Users/ajwieme/got-pool/lib/resize.py "$f" 1.1;
done
