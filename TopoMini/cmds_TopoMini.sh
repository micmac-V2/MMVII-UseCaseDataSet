set -e

# The script must be launched from it's directory.
script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
cd "$script_dir"

# Workflow parameters.
coordinates_file='input_data/initial_coordinates.txt'
measurements_file='input_data/topometric_measurements.obs'

# Import the initial coordinates and perform a transformation to a local RTL coordinate system.
MMVII ImportGCP "$coordinates_file" ANXYZ InitRTL ChSys=[L93,RTL] AddInfoFree=0 Sigma=0.001 Comment=*

# Import topometric observations.
MMVII ImportOBS "$measurements_file" Obs

# Run the adjustment.
MMVII OriBundleAdj NONE NONE NONE GCP3D=[[InitRTL,1,FinalRTL]] TopoDirIn=Obs TopoDirOut=Obs_out

# Export the adjusted coordinates to RGF93-Lambert93 cartographic projection.
MMVII GCPChSysCo L93 FinalRTL FinalL93