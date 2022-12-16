#!/bin/bash

# Name of your job
#SBATCH --job-name=CHDDeformNet
# Name of partition
#SBATCH --partition=owners

# Specify the name of the output file. The %j specifies the job ID
#SBATCH --output=svFSI_job.o%j

# Specify a name of the error file. The %j specifies the job ID
#SBATCH --error=svFSI_job.e%j

# The walltime you require for your simulation
#SBATCH --time=3:00:00

# Job QOS
#SBATCH --qos=normal

# Number of nodes you are requesting
#SBATCH --nodes=3

# Amount of memory you require per node
#SBATCH --mem=192000

# Number of processors per node
#SBATCH --ntasks-per-node=32

# Send an email to this address when you job starts and finishes
#SBATCH --mail-user=kharold@stanford.edu
#SBATCH --mail-type=begin
#SBATCH --mail-type=fail
#SBATCH --mail-type=end

# Load Modules
module purge
module load openmpi/4.0.5
module load openblas
module load system
module load mesa
module load ffmpeg
module load gcc
module load python/2.7

mpirun -n 96 python MeshDeformNet/data/data_augmentation.py --im_dir '/scratch/users/kharold/CHD_Data/ct_train'  --seg_dir '/scratch/users/kharold/CHD_Data/ct_train_seg'  --out_dir '/scratch/users/kharold/CHD_Aug'  --modality ct  --mode train   --num 15

# Submit job with 
# sbatch ./Augment.sh

# Check status with
# squeue -u $USER}
