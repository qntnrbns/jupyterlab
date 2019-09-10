# Prep a fresh conda environment in a temporary folder for a release
if [[ $# -ne 1 ]]; then
    echo "Specify branch"
else
    branch=$1
    env=jlabrelease_$branch

    WORK_DIR='/tmp/$env'
    rm -rf $WORK_DIR
    mkdir -p $WORK_DIR
    cd $WORK_DIR

    conda deactivate
    conda remove --all -y -n jlabrelease_$branch

    conda create --override-channels --strict-channel-priority -c conda-forge -c anaconda -y -n $env notebook nodejs twine
    conda activate $env

    git clone https://github.com/jupyterlab/jupyterlab.git
    cd jupyterlab

    git checkout $branch

    pip install -ve .
fi