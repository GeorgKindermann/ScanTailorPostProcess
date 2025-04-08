#Just take the images as they are

#Get the size of them
du -bc /tmp/st/pic/*.jpg #size: 71639885
du -bc /tmp/st/outA1/*.tif # 1088240912
du -bc /tmp/st/outA2/*.tif # 4106885020
du -bc /tmp/st/outB1/*.tif #   35230916
du -bc /tmp/st/outB2/*.tif #  121703962

#Get resolution of page-076_2R
identify /tmp/st/outA1/page-076_2R.tif # 1291x2167
identify /tmp/st/outA2/page-076_2R.tif # 2582x4334
identify /tmp/st/outB1/page-076_2R.tif # 1291x2167
identify /tmp/st/outB2/page-076_2R.tif # 2582x4334
