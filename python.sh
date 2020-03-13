set -x


if [ ! -f $(which pip) ]; then
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    python get-pip.py
fi


pip install glances pydf
