set -e

# The script must be launched from it's directory.
script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
cd "$script_dir"

# Workflow parameters.
image_pattern='.*tif'
img_test='043_0005_Scaled.tif'
gcp_coordinates_file='input_data/Panel_3D_coordinates.txt'

# Assign camera model, focal length, and block structure.
MMVII EditCalcMTDI ModelCam ImTest="$img_test" Modif=["$image_pattern","NIKON D5600",0] Save=1
MMVII EditCalcMTDI Focalmm ImTest="$img_test" Modif=["$image_pattern",24,0] Save=1
MMVII EditCalcMTDI AdditionalName ImTest="$img_test" Modif=["(.*)_.*_.*","\$1",0] Save=1

# Create the initial interior calibration from metadata.
MMVII OriCreateCalib "$image_pattern" CalibInit_311 Degree=[3,1,1]

# Import 3D coordinates of panel targets and generate their specifications.
MMVII ImportGCP "$gcp_coordinates_file" "NXYZ" Panel_3D NumL0=0 ChSys=[LocalPanel]
MMVII CodedTargetGenerateEncoding CERN 14 GCPNames=Panel_3D Out=Targets_Encoding_Panel.xml
MMVII CodedTargetGenerate Targets_Encoding_Panel.xml Out=Targets_FullSpecif_Panel.xml

# Extract targets and keep only images with suitable GCP distribution.
MMVII CodedTargetCircExtract "$image_pattern" Targets_FullSpecif_Panel.xml OutObjMesInstr=Panel_2D ZoomVisuEllipse=1
MMVII OriPoseEstimCheckGCPDist "$image_pattern" Panel_3D Panel_2D PrefSave=imgs

# Estimate initial poses and run the first bundle adjustment.
MMVII OriPoseEstimSpaceResection imgs_OK_Resec.xml Panel_3D Panel_2D CalibInit_311 SR_311
MMVII OriBundleAdj imgs_OK_Resec.xml SR_311 BA0_311 GCP3D=[[Panel_3D,0.001]] GCP2D=[[Panel_2D,0.1,1,-1,1]] NbIter=20

# Complete uncoded targets and run a second bundle adjustment with all detections.
MMVII CodedTargetCompleteUncoded imgs_OK_Resec.xml BA0_311 1.0 Panel_3D Panel_2D Panel_2D_Completed
MMVII OriBundleAdj imgs_OK_Resec.xml BA0_311 BA1_311 GCP3D=[[Panel_3D,0.001]] GCP2D=[[Panel_2D_Completed,0.1,1,-1,1]] NbIter=10
MMVII ReportGCP imgs_OK_Resec.xml Panel_3D Panel_2D_Completed BA1_311

# Create and initialize the camera block.
MMVII BlockInstrEdit block_init FromScratch=true
MMVII BlockInstrEdit block_init "PatsIm4Cam=[imgs_OK_Resec.xml,.*_(.*)_Scaled.tif]"
MMVII BlockInstrInitCam imgs_OK_Resec.xml block_init BA1_311 block_init

# Adjust the camera block and report the results.
MMVII OriBundleAdj imgs_OK_Resec.xml BA1_311 BA2_311 GCP3D=[[Panel_3D,0.001]] GCP2D=[[Panel_2D_Completed,0.1,1,-1,1]] InInstrBlock=block_init OutInstrBlock=block_adj BOI=[[,0.1,0.1,1],[]] NbIter=10
MMVII ReportGCP imgs_OK_Resec.xml Panel_3D Panel_2D_Completed BA2_311
MMVII ReportBlock imgs_OK_Resec.xml BA2_311 Panel_2D_Completed block_adj
