#!/bin/bash

# Name of your job
#SBATCH --job-name=CHDDeformNet_Val
# Name of partition
#SBATCH --partition=bioe

# Specify the name of the output file. The %j specifies the job ID
#SBATCH --output=validate.o%j

# Specify a name of the error file. The %j specifies the job ID
#SBATCH --error=validate.e%j

# The walltime you require
#SBATCH --time=10:00:00

# Job QOS
#SBATCH --qos=normal

# Number of nodes you are requesting
#SBATCH --nodes=1

#SBATCH --ntasks-per-node=16

# Send an email to this address when you job starts and finishes
#SBATCH --mail-user=kharold@stanford.edu
#SBATCH --mail-type=begin
#SBATCH --mail-type=fail
#SBATCH --mail-type=end

# Load Modules
module purge
module load gcc/8.1.0
module load python/3.6
module load py-h5py/2.10.0_py36
module load cudnn/7.6
module load cuda/10.0
module load mesa

python3 /scratch/users/kharold/MeshDeformNet/prediction_gcn.py  --image /scratch/users/kharold/CHD_Data  --mesh_dat /scratch/users/kharold/Records/data_aux.dat  --mesh_txt /scratch/users/kharold/Records/ct_train/mesh_info.txt  --attr _test  --mesh_tmplt /scratch/users/kharold/MeshDeformNet/data/template/init3.vtk  --model /scratch/users/kharold/Records/T1_Results/weights_gcn.hdf5  --output /scratch/users/kharold/Validate/T1  --modality ct  --seg_id 1 2 3   --size 128 128 128  --mode validate

# Submit job with 
# sbatch ./Validate.sh

# Check status with
# squeue -u $USER}
