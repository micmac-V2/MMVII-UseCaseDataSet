set -e

# The script must be launched from it's directory.
script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
cd "$script_dir"

# Workflow parameters.
image_pattern='.*jpg'
img_test='IMG_0319.jpg'
homol_archive='input_data/Homol.zip'

# Import the tie points computed by MicMac-v1.
unzip -oq "$homol_archive" -d .
MMVII TiePConvert "$image_pattern" MMV1 TiePts_2D

# Assign camera model, focal length, and initial principal point.
MMVII EditCalcMTDI ModelCam Modif=["$image_pattern","Canon EOS 5D Mark II",0] Save=1 ImTest="$img_test"
MMVII EditCalcMTDI Focalmm Modif=["$image_pattern",50,0] Save=1 ImTest="$img_test"
MMVII EditCalcMTDI PPPix Modif=["$image_pattern","[1404,936]",0] Save=1 ImTest="$img_test"

# Create the initial interior calibration from metadata.
MMVII OriCreateCalib "$image_pattern" CalibInit

# Select Pairs of images -> Estimate relative poses for all pairs -> Estimate relative poses for all triplets.
MMVII OriPoseSelecAllPAir "$image_pattern" RelAllPairs InTieP=TiePts_2D
MMVII OriPoseEstimRelAllPairs RelAllPairs CalibInit InTieP=TiePts_2D
MMVII OriPoseEstimRelAllTriplets RelAllPairs CalibInit InTieP=TiePts_2D

# Build global hierarchical orientation.
MMVII OriPoseEstimGlobHierarchical "$image_pattern" RelAllPairs CalibInit All InTieP=TiePts_2D

# Visualize the result in 3D.
MMVII VisuPose3D "$image_pattern" All InMulTieP=TiePts_2D
