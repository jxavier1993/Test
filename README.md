# hw_arch_ml_slide

Instructions for building SLIDE on TACC (maverick2) :

module load gcc/7.3.0
module load cuda/9.2
mkdir bin && cd bin
cmake ../
make

 - Change the path of training, test data files in SLIDE/Config_amz.csv
