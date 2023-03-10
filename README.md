# [In Defense of Locality-Sensitive Hashing](https://ieeexplore.ieee.org/abstract/document/7636996)

This code implements the paper: 

```
@ARTICLE{LSTSH,
     author={Ding, Kun and Huo, Chunlei and Fan, Bin and Xiang, Shiming and Pan, Chunhong},
      journal={IEEE Transactions on Neural Networks and Learning Systems}, 
      title={In Defense of Locality-Sensitive Hashing}, 
      year={2018},
      volume={29},
      number={1},
      pages={87-103}
  }
```



The code is tested on 64-bit CentOS Linux 7.1.1503 (Core) system with MATLAB 2014b and 64-bit Windows 10 system with MATLAB 2014a. It includes:

1. [demo.m](demo.m): demo code for LS-TSH.
2. [TSH_label.m](codes/LS-TSH/TSH_label.m): use "label hashing" to generate binary codes.
3. [TSH_trans.m](codes/LS-TSH/TSH_trans.m): use "transformation hashing" to generate binary codes.
4. [TSH_kernl.m](codes/LS-TSH/TSH_kernl.m): use "kernel hashing" to generate binary codes.

To try the code, please run [demo.m](demo.m). If all goes well, it will print the MAP of four different

methods. 



If you have any questions, please contact me by Email: kun.ding AT ia.ac.cn.
