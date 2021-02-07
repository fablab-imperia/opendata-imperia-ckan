#!/bin/bash 

pip install setuptools==44.1.0
pip install --upgrade pip

pip install -e 'git+https://github.com/ckan/ckan.git@ckan-2.9.1#egg=ckan[requirements]'

deactivate
. /usr/lib/ckan/default/bin/activate
