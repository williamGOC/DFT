#!bin/bash

NAME='Nk'

for i in `echo 1 10 1 | awk '{for(d=$1;d<=$2;d+=$3){printf "%d ",d}}'`
do
cat > Ir.$NAME.${i}.in << EOF
&control
    calculation = 'scf',
    verbosity = 'high'
    prefix = 'Ir'
    outdir = './tmp/'
    pseudo_dir = '/home/oropebuen/Documents/Job/Absortion/SSSP_efficiency_pseudos'
 /

 &system
    ibrav =  2, 
    celldm(1) = 7.25465, 
    nat =  1, 
    ntyp = 1,
    ecutwfc = 30.0,
    ecutrho = 240.0
    occupations = 'smearing',
    smearing = 'gauss',
    degauss = 0.02
 /

 &electrons
    mixing_beta = 0.7
 /

ATOMIC_SPECIES
 Ir 192.217  Ir_pbe_v1.2.uspp.F.UPF

ATOMIC_POSITIONS (alat)
 Ir 0.0 0.0 0.0

K_POINTS (automatic)
  ${i} ${i} ${i} 1 1 1
EOF
pw.x < Ir.$NAME.${i}.in > Ir.$NAME.${i}.out
grep "!" Ir.$NAME.${i}.out | awk '{print '${i}', $5}' >> E_vs_Nk.dat
done
