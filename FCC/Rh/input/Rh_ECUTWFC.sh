#!bin/bash

NAME='ecutwfc'

for i in `echo 5 70 5 | awk '{for(d=$1;d<=$2;d+=$3){printf "%d ",d}}'`
do
cat > Rh.$NAME.${i}.in << EOF
&control
    calculation = 'scf',
    verbosity = 'high'
    prefix = 'Rh'
    outdir = './tmp/'
    pseudo_dir = '/home/oropebuen/Documents/Job/Absortion/SSSP_efficiency_pseudos'
 /

 &system
    ibrav =  2, 
    celldm(1) = 7.18738, 
    nat =  1, 
    ntyp = 1,
    ecutwfc = ${i},
    ecutrho = $((i*8))
    occupations = 'smearing',
    smearing = 'gauss',
    degauss = 0.02
 /

 &electrons
    mixing_beta = 0.7
 /

ATOMIC_SPECIES
 Rh 102.9055  Rh_ONCV_PBE-1.0.upf

ATOMIC_POSITIONS (alat)
 Rh 0.0 0.0 0.0

K_POINTS (automatic)
  8 8 8 1 1 1
EOF
pw.x < Rh.$NAME.${i}.in > Rh.$NAME.${i}.out
grep "!" Rh.$NAME.${i}.out | awk '{print '${i}', $5}' >> E_vs_ECUTWFC.dat
done
