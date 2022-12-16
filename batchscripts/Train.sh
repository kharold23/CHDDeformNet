#!/bin/bash

# Name of your job
#SBATCH --job-name=CHDDeformNet
# Name of partition
#SBATCH --partition=owners

#SBATCH -G 1
#SBATCH -C 'GPU_BRD:TESLA&GPU_MEM:16GB'

# Specify the name of the output file. The %j specifies the job ID
#SBATCH --output=T2.o%j

# Specify a name of the error file. The %j specifies the job ID
#SBATCH --error=T2_err.e%j

# The walltime you require
#SBATCH --time=04:00:00

# Job QOS
#SBATCH --qos=normal

# Number of nodes you are requesting
#SBATCH --nodes=1

#SBATCH --cpus-per-gpu=16
#SBATCH --mem=12000

# Send an email to this address when you job starts and finishes
#SBATCH --mail-user=kharold@stanford.edu
#SBATCH --mail-type=begin
#SBATCH --mail-type=fail
#SBATCH --mail-type=end

# Load Modules
module purge
module load gcc/8.1.0
module load python/3.6
module load cudnn/7.6
module load cuda/10.0
module load mesa


nvidia-smi
# python3 /scratch/users/kharold/MeshDeformNet/train_gcn.py --im_train /scratch/users/kharold/Records  --im_val /scratch/users/kharold/Records  --mesh_txt  /scratch/users/kharold/Records/ct_train/mesh_info.txt  --mesh /scratch/users/kharold/Records/data_aux.dat --train_data_weights 1.0  --attr_trains ''  --attr_vals ''  --val_data_weights 1.0 --output  /scratch/users/kharold/Records/T1_Results  --modality ct  --num_epoch 250  --batch_size 1  --lr 0.01  --size 128 128 128  --weights 0.4 0.05 0.2 0.15  --mesh_ids 0 1 2  --num_seg 1  --seg_weight 100.0
python3 /scratch/users/kharold/MeshDeformNet/train_gcn.py --im_train /scratch/users/kharold/Records  --im_val /scratch/users/kharold/Records  --mesh_txt  /scratch/users/kharold/Records/ct_train/mesh_info.txt  --mesh /scratch/users/kharold/Records/data_aux.dat --train_data_weights 1.0  --attr_trains ''  --attr_vals ''  --val_data_weights 1.0 --output  /scratch/users/kharold/Records/T2_Results  --modality ct  --num_epoch 250  --batch_size 1  --lr 0.01  --size 128 128 128  --weights 0.29336324 0.05 0.46902252 0.16859047  --mesh_ids 0 1 2  --num_seg 1  --seg_weight 100.0

# Submit job with 
# sbatch ./Train.sh

# Check status with
# squeue -u $USER}
