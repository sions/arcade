#!/bin/bash

rm -rf doc/build
rm dist/*
python3 setup.py clean
python3 setup.py build
python3 setup.py bdist_wheel
pip3 uninstall -y arcade
for file in dist/*
do
  pip install $file
done
python3 doc/preprocess_files.py
sphinx-build -b html doc doc/build/html
coverage run --source arcade setup.py test
coverage report -m
