This project is adapted from the base model of MeshDeformNet.

The orignal code for MeshDeformNet can be found at https://github.com/fkong7/MeshDeformNet

The following files were changed for this project:
    data/data_augmentation.py
    data/data2tfrecords.py
    src/pre_process.py
    prediction_gcn.py
    train_gcn.py

The following files were written from scratch for this project:
    data/Preprocessing.py
    batchscripts/Augment.sh
    batchscripts/Preprocessing.sh
    batchscripts/Train.sh
    batchscripts/Validate.sh
    Loss_Evaluation.ipynb (This also includes plots of loss for different trial runs.)
