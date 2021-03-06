#!/bin/bash

sudo pip install Cython
sudo pip install -U ipython
sudo pip install -U jinja2
sudo pip install -U scikit-learn==0.14.1
sudo pip install -U tornado
sudo pip install -U chembl_migration_model
echo "numpy==1.8.2" | cat > /tmp/pandas.requirement.txt
sudo pip install -U pandas -r /tmp/pandas.requirement.txt
#sudo pip install -U requests
sudo pip install -U mpld3
sudo pip install -U service_identity
sudo pip install https://garage.maemo.org/frs/download.php/8363/python-brisa_0.10.3maemo0.tar.gz
sudo pip install -U paste
sudo pip install -U netifaces
python -c "import mpld3; mpld3.utils.write_ipynb_local_js()"
