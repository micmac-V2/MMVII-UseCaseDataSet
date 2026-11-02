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
| [Ramses](./Ramses/) | A sequence of a close-range convergent acquisition performed in a circular geometry around a statue with loop closure. | [Ramses](https://github.com/micmac-V2/MMVII-UseCaseDataSet/wiki/Ramses) | [`cmds_Ramses.sh`](./Ramses/cmds_Ramses.sh) |
| [Circular Coded Targets](./Circular-Coded-Targets/) | Images from two cameras of a calibration panel with coded and uncoded circular targets whose 3D coordinates are known. The workflow detects targets, estimates image poses, refines them with bundle adjustment, and estimates the camera block. | [Circular Coded Targets](https://github.com/micmac-V2/MMVII-UseCaseDataSet/wiki/Circular-Coded-Targets) | [`cmds_Circular-Coded-Targets.sh`](./Circular-Coded-Targets/cmds_Circular-Coded-Targets.sh) |
| [TopoMini](./TopoMini/) | A minimal example of a topometric network adjustment using angular and distance observations and approximate coordinates. | [TopoMini](https://github.com/micmac-V2/MMVII-UseCaseDataSet/wiki/TopoMini) | [`cmds_TopoMini.sh`](./TopoMini/cmds_TopoMini.sh) |

## Requirements

Build [MMVII](https://github.com/micmac-v2/mmvii) and make the `MMVII`
executable available on your `PATH`. The processing scripts require `Bash`.

## Processing a dataset

For example, to run the [Circular Coded Targets](./Circular-Coded-Targets/)
workflow, execute:

```bash
cd MMVII-UseCaseDataSet/Circular-Coded-Targets/
bash cmds_Circular-Coded-Targets.sh
```

To run the [Ramses](./Ramses/) workflow instead, execute:

```bash
cd MMVII-UseCaseDataSet/Ramses/
bash cmds_Ramses.sh
```
