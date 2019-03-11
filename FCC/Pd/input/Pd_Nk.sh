#!bin/bash

NAME='Nk'

for i in `echo 1 10 1 | awk '{for(d=$1;d<=$2;d+=$3){printf "%d ",d}}'`
do
cat > Pd.$NAME.${i}.in << EOF
&control
    calculation = 'scf',
    verbosity = 'high'
    prefix = 'Pd'
    outdir = './tmp/'
    pseudo_dir = '/home/oropebuen/Documents/Job/Absortion/SSSP_efficiency_pseudos'
 /

 &system
    ibrav =  2, 
    celldm(1) = 7.35235, 
    nat =  1, 
    ntyp = 1,
    ecutwfc = 30.0,
    ecutrho = 240.0,
    occupations = 'smearing',
    smearing = 'gauss',
    degauss = 0.02
 /

 &electrons
    mixing_beta = 0.7
 /

ATOMIC_SPECIES
 Pd 106.42  Pd_ONCV_PBE-1.0.upf

ATOMIC_POSITIONS (alat)
 Pd 0.0 0.0 0.0

K_POINTS (automatic)
  ${i} ${i} ${i} 1 1 1
EOF
pw.x < Pd.$NAME.${i}.in > Pd.$NAME.${i}.out
grep "!" Pd.$NAME.${i}.out | awk '{print '${i}', $5}' >> E_vs_Nk.dat
done
