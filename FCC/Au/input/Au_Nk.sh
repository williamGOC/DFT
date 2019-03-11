#!bin/bash

NAME='Nk'

for i in `echo 1 10 1 | awk '{for(d=$1;d<=$2;d+=$3){printf "%d ",d}}'`
do
cat > Au.$NAME.${i}.in << EOF
&control
    calculation = 'scf',
    verbosity = 'high'
    prefix = 'Au_exc1'
    outdir = './tmp/'
    pseudo_dir = '/home/oropebuen/Documents/Job/Absortion/SSSP_efficiency_pseudos'
 /

&system
    ibrav =  2, 
    celldm(1) = 7.706, 
    nat =  1, 
    ntyp = 1,
    ecutwfc = 40,
    ecutrho = 320,
    occupations = 'smearing',
    smearing = 'gauss',
    degauss = 0.02
/

&electrons
    mixing_beta = 0.7
/

ATOMIC_SPECIES
 Au 196.966569  Au_ONCV_PBE-1.0.upf

ATOMIC_POSITIONS (alat)
 Au 0.0 0.0 0.0

K_POINTS (automatic)
  ${i} ${i} ${i} 1 1 1
EOF
pw.x < Au.$NAME.${i}.in > Au.$NAME.${i}.out
grep "!" Au.$NAME.${i}.out | awk '{print '${i}', $5}' >> E_vs_Nk.dat
done