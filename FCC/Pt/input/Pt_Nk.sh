#!bin/bash

NAME='Nk'

for i in `echo 1 10 1 | awk '{for(d=$1;d<=$2;d+=$3){printf "%d ",d}}'`
do
cat > Pt.$NAME.${i}.in << EOF
&control
    calculation = 'scf',
    verbosity = 'high'
    prefix = 'Pt'
    outdir = './tmp/'
    pseudo_dir = '/home/oropebuen/Documents/Job/Absortion/SSSP_efficiency_pseudos'
 /

 &system
    ibrav =  2, 
    celldm(1) = 7.4156, 
    nat =  1, 
    ntyp = 1,
    ecutwfc = 20.0,
    ecutrho = 200.0,
    occupations = 'smearing',
    smearing = 'gauss',
    degauss = 0.02
 /

 &electrons
    mixing_beta = 0.7
 /

ATOMIC_SPECIES
 Pt 195.084  pt_pbe_v1.4.uspp.F.UPF

ATOMIC_POSITIONS (alat)
 Pt 0.0 0.0 0.0

K_POINTS (automatic)
  ${i} ${i} ${i} 1 1 1
EOF
pw.x < Pt.$NAME.${i}.in > Pt.$NAME.${i}.out
grep "!" Pt.$NAME.${i}.out | awk '{print '${i}', $5}' >> E_vs_Nk.dat
done
