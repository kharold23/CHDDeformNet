#!/bin/bash

# Name of your job
#SBATCH --job-name=DataPreprocessing
# Name of partition
#SBATCH --partition=owners

# Specify the name of the output file. The %j specifies the job ID
#SBATCH --output=preprocessing.o%j

# Specify a name of the error file. The %j specifies the job ID
#SBATCH --error=preprocessing.e%j

# The walltime you require for your simulation
#SBATCH --time=1:30:00

# Job QOS
#SBATCH --qos=normal

# Number of nodes you are requesting
#SBATCH --nodes=1

# Amount of memory you require per node
#SBATCH --mem=32000

# Number of processors per node
#SBATCH --ntasks-per-node=32

# Send an email to this address when you job starts and finishes
#SBATCH --mail-user=kharold@stanford.edu
#SBATCH --mail-type=begin
#SBATCH --mail-type=fail
#SBATCH --mail-type=end

# Load Modules
module purge
module load openmpi/4.1.0
module load openblas
module load system
module load mesa
module load ffmpeg
module load gcc
module load python/3.6

# python3 /scratch/users/kharold/MeshDeformNet/data/data2tfrecords.py --folder /scratch/users/kharold/CHD_Data --modality ct --size 128 128 128 --folder_postfix _train --deci_rate 0 --smooth_ite 50 --out_folder "/scratch/users/kharold/Records" --seg_id 1 2 3
python3 /scratch/users/kharold/MeshDeformNet/data/data2tfrecords.py --folder /scratch/users/kharold/CHD_Data --modality ct --size 128 128 128 --folder_postfix _val --deci_rate 0 --smooth_ite 50 --out_folder "/scratch/users/kharold/Records" --seg_id 1 2 3

# Submit job with 
# sbatch ./Preprocessing.sh

# Check status with
# squeue -u $USER}
