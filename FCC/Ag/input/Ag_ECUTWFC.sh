#!bin/bash

NAME='ecutwfc'

for i in `echo 5 70 5 | awk '{for(d=$1;d<=$2;d+=$3){printf "%d ",d}}'`
do
cat > Ag.$NAME.${i}.in << EOF
&control
    calculation = 'scf',
    verbosity = 'high'
    prefix = 'Ag'
    outdir = './tmp/'
    pseudo_dir = '/home/oropebuen/Documents/Job/Absortion/SSSP_efficiency_pseudos'
 /

 &system
    ibrav =  2, 
    celldm(1) = 7.720, 
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
 Ag  107.8682  Ag_ONCV_PBE-1.0.upf

ATOMIC_POSITIONS (alat)
 Ag 0.0 0.0 0.0

K_POINTS (automatic)
  8 8 8 1 1 1
EOF
pw.x < Ag.$NAME.${i}.in > Ag.$NAME.${i}.out
grep "!" Ag.$NAME.${i}.out | awk '{print '${i}', $5}' >> E_vs_ECUTWFC.dat
done
 
