# MMVII Use Case Dataset

This repository brings together datasets and processing examples for
[MMVII](https://github.com/micmac-v2/mmvii), free and open-source
photogrammetry software developed by the
[LASTIG laboratory](https://www.umr-lastig.fr/) at
[IGN](https://www.ign.fr/), the French National Institute of Geographic and
Forest Information.

The repository contains several independent use cases, each illustrating a
specific workflow. The table below lists the datasets currently available and
links to their tutorials and processing scripts.

## Datasets

| Dataset | Description | Wiki tutorial | Processing script |
| --- | --- | --- | --- |
| [Circular Coded Targets](./Circular-Coded-Targets/) | Images from two cameras of a calibration panel with coded and uncoded circular targets whose 3D coordinates are known. The workflow detects targets, estimates image poses, refines them with bundle adjustment, and estimates the camera block. | [Circular Coded Targets](https://github.com/micmac-V2/MMVII-UseCaseDataSet/wiki/Circular-Coded-Targets) | [`cmds_Circular-Coded-Targets.sh`](./Circular-Coded-Targets/cmds_Circular-Coded-Targets.sh) |

## Requirements

Build [MMVII](https://github.com/micmac-v2/mmvii) and make the `MMVII` executable available on your `PATH`. The
processing script requires Bash.

## Processing a dataset

Example, for [Circular Coded Targets](./Circular-Coded-Targets/)  dataset, run the processing script as follows:

```bash
cd MMVII-UseCaseDataSet/Circular-Coded-Targets/
bash cmds_Circular-Coded-Targets.sh
```
