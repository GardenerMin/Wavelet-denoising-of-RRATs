# Wavelet-denoising-of-RRATs
This is the Matlab demo code for our paper "Wavelet Denoising of Radio Observations of Rotating Radio Transients (RRATs): Improved Timing Parameters for Eight RRATs". [[Paper link->]](https://iopscience.iop.org/article/10.3847/1538-4357/aa88c3/meta)

## Usage
1. Data download from [[this link]](https://drive.google.com/file/d/1trgLGdYNPTRcK-kyXcFxP81g96QXzict/view?usp=sharing). Note that this is a piece of original time series (after dedispersion) of RRAT J1048-5838 saved in Matlab format (.mat).

2. To apply the wavelet denoising method, please run **_wavelet_denoising_Demo.m_**. The parameters are pre-set for the time series of J1048-5838. If you apply wavelet denoising method for other time series, please **modify** the parameters before usage. 

3. After applying the wavelet denoising, use **_calculate_TOAs.m_** to calculate the TOAs (time of arrivals) candidates.

4. Other useful code for folding will be updated soon.

## Ciation
Please cite the paper in your publications if it helps your research:
```
@article{jiang2017wavelet,
  title={Wavelet Denoising of Radio Observations of Rotating Radio Transients (RRATs): Improved Timing Parameters for Eight RRATs},
  author={Jiang, Min and Cui, B-Y and Schmid, NA and McLaughlin, MA and Cao, Z-C},
  journal={The Astrophysical Journal},
  volume={847},
  number={1},
  pages={75},
  year={2017},
  publisher={IOP Publishing}
}
```

## Otehr useful links
1. Sigproc (pulsar signal processing programs). [[Link]](http://sigproc.sourceforge.net/)
2. Filterbank Tutorial. [[Link]](https://github.com/UCBerkeleySETI/breakthrough/blob/master/GBT/filterbank_tutorial/Filterbank%20Tutorial%20(public).ipynb)
