# This will install:
# - AlmaLinux 9
# - Jupyter 
# - ROOT

# To see the version numbers (which change as the EPEL and PyPI repositories evolve)
# start the Terminal from the Jupyter notebook and type (e.g.):

FROM almalinux:9

ENV PANDA_WORKDIR /

WORKDIR /work

# Install packages from AlmaLinux base and EPEL
RUN dnf -y install 'dnf-command(config-manager)'
RUN dnf config-manager --set-enabled crb
RUN dnf -y install epel-release

RUN dnf -y update

# Install packages needed for ROOT
RUN dnf -y install python3 python3-pip  python3-devel which
RUN dnf -y install root\*  python3-root python3-jupyroot python3-distrdf

# curl will be needed when we install python packages below.
RUN dnf -y install curl libcurl libcurl-devel --allowerasing

# Additional packages for some C++ work:
RUN dnf -y install make boost-devel gsl-devel binutils-devel 

# Other Linux packages required for python package compilation.
RUN dnf -y install python3-pillow-devel openssl-devel

# Install packages from PyPI. These are the ones needed for almost any
# Jupyter installation. 
RUN pip3 install --upgrade wheel
RUN pip3 install --upgrade jupyter metakernel
RUN pip3 install --upgrade numpy scipy matplotlib coffea

# These additional packages are handy, but not critical. 
RUN pip3 install --upgrade jupyterlab "jupyter-server<2.0.0"
RUN pip3 install --upgrade iminuit pandas sympy terminado urllib3 tables
RUN pip3 install --upgrade uproot

RUN pip3 install --no-cache-dir "dask[complete]"
RUN pip3 install --no-cache-dir dask-awkward dask-histogram

# Wrap it up.
RUN dnf clean all

# Forward current workdir to user so they can find input files staged in by pilot
RUN export PANDA_WORKDIR=$PANDA_WORKDIR

# Run jupyter when this docker container is started.
# CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8080", "--allow-root"]
