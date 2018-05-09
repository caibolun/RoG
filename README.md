# Edge/Structure Preserving Smoothing via Relativity-of-Gaussian
Bolun Cai, Xiaofen Xing, Xiangmin Xu
### Introduction
This paper presents a novel edge/structure-preserving image smoothing via relativity-of-Gaussian. As a simple local regularization, it performs the local analysis of scale features and globally optimizes its results into a piecewise smooth. The central idea to ensure proper texture smoothing is based on cross-scale relative that captures the weak textures from the most prominent edges/structures. Our method outperforms the previous methods in removing the detail information while preserving main image content.

If you use these codes in your research, please cite:


	@article{cai2017rog,
		author = {Bolun Cai, Xiaofen Xing and Xiangmin Xu},
		title={Edge/Structure Preserving Smoothing via Relativity-of-Gaussian},
		booktitle={IEEE International Conference on Image Processing (ICIP)},
		year={2017}
		}

### Usage
Download the code and test images
```
git clone https://github.com/caibolun/RoG.git
```

#### Edge/Structure Preserving Smoothing

 Smooth the image with edge/structure Preserving by simply typing in Matlab.
```
 run('demo.m')
```
<img width="300" src="https://raw.githubusercontent.com/caibolun/RoG/master/input.png"/> &nbsp;&nbsp; <img width="300" src="https://raw.githubusercontent.com/caibolun/RoG/master/rog.png"/>
#### Detail Enhancement ([Link](https://caibolun.github.io/RoG/detail_enhance.html))

 As a nonlinear edge-preserving image smoothing (K = 1), our method can be used for detail enhancement via base and detail layer decomposition.
```
run('detail_example\demo.m')
```
<img width="400" src="https://raw.githubusercontent.com/caibolun/RoG/master/detail_example/flower.png"/> &nbsp;&nbsp; <img width="400" src="https://raw.githubusercontent.com/caibolun/RoG/master/detail_example/result.png"/>

#### Structure Extraction ([Link](https://caibolun.github.io/RoG/structure.html))

As a nonlinear structure-preserving image smoothing (K > 1), we apply our method for structure-texture separation. 
```
run('struct_example\demo.m')
```
<img width="400" src="https://raw.githubusercontent.com/caibolun/RoG/master/struct_example/fish.png"/> &nbsp;&nbsp; <img width="400" src="https://raw.githubusercontent.com/caibolun/RoG/master/struct_example/result.png"/>

#### HDR Tone Mapping ([Link](https://caibolun.github.io/RoG/tone_mapping.html))

One of the challenges in image processing is the rendering of an HDR scene on a conventional LDR display. RoG smoothing is easily harnessed to perform tone mapping of HDR images. 
```
run('hdr_example\demo.m')
```
<img width="400" src="https://raw.githubusercontent.com/caibolun/RoG/master/hdr_example/result.png"/>
