import SimpleITK as sitk
import glob
import os
import pandas as pd

def resample(img, ref_img):
    new_img = sitk.Resample(img, ref_img.GetSize(), sitk.Transform(), sitk.sitkNearestNeighbor, ref_img.GetOrigin(), ref_img.GetSpacing(), ref_img.GetDirection(), 0, img.GetPixelID())
    return new_img


table = pd.read_table('/scratch/users/kharold/VSD.tab', names=['name', 'VSD'])
VSD = table[table['VSD'] == 1]
VSD_list = list(VSD['name'])
no_VSD = VSD = table[table['VSD'] == 0]
no_VSD_list = list(no_VSD['name'])

VSD_n = len(VSD_list)
no_VSD_n = len(no_VSD_list)

train = VSD_list[:round(VSD_n*0.6)] + no_VSD_list[:round(no_VSD_n*0.6)]
val = VSD_list[round(VSD_n*0.6):round(VSD_n*0.8)] + no_VSD_list[round(no_VSD_n*0.6):round(no_VSD_n*0.8)]
test = VSD_list[round(VSD_n*0.8):] + no_VSD_list[round(no_VSD_n*0.8):]
print(train)
print(val)
print(test)

out_path = '/scratch/users/kharold/CHD_Data/'
for im_path in sorted(glob.glob('/scratch/users/kharold/CHD_Images/*')):
    print(im_path)
    ref_img = sitk.ReadImage(im_path)
    name = os.path.basename(im_path).split('_')[1]
    print(name)
    if int(name) in train:
        print("train")
        sitk.WriteImage(ref_img, out_path + 'ct_train/ct_' + name + '.nii')
    if int(name) in val:
        print("val")
        sitk.WriteImage(ref_img, out_path + 'ct_val/ct_' + name + '.nii')
    if int(name) in test:
        print("test")
        sitk.WriteImage(ref_img, out_path + 'ct_test/ct_' + name + '.nii')
    
    for i, m_path in enumerate(sorted(glob.glob('/scratch/users/kharold/CHD_Clean_Ground_Truths/ct_' + name + '*/*'))):
        print(m_path)
        img = sitk.ReadImage(m_path)
        img = resample(img, ref_img)
        if int(name) in train:
            sitk.WriteImage(img, out_path + 'ct_train_seg/ct_' + name + '_seg_' + str(i+1) + '.nii')
        if int(name) in val:
            sitk.WriteImage(img, out_path + 'ct_val_seg/ct_' + name + '_seg_' + str(i+1) + '.nii')
        if int(name) in test:
            sitk.WriteImage(img, out_path + 'ct_test_seg/ct_' + name + '_seg_' + str(i+1) + '.nii')
        