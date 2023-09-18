python3 -m venv ./.virtualenv
source ./.virtualenv/bin/activate
pip3 install konsave
konsave -i ../kde3.knsv
deactivate
rm -rf ./.virtualenv
