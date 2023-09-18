python3 -m venv ./.virtualenv
source ./.virtualenv/bin/activate
pip3 install konsave
konsave -i ../kde.knsv
konsave -a kde
deactivate
rm -rf ./.virtualenv
