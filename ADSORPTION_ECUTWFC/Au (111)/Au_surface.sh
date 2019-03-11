#!bin/bash

NAME='ecutwfc'

for i in `echo 5 60 5 | awk '{for(d=$1;d<=$2;d+=$3){printf "%d ",d}}'`
do
cat > Au.$NAME.${i}.in << EOF
&control
    calculation='scf'
    prefix='Au',
    pseudo_dir = '/home/oropebuen/Documents/Job/Absortion/SSSP_efficiency_pseudos',
    outdir='./tmp'
/

&system
    ibrav=4, celldm(1)=5.449, celldm(3)=7.4272, nat=4, ntyp=1,
    ecutwfc = ${i}
    ecutrho = $((i*8))
    occupations='smearing' 
    smearing='gauss'
    degauss=0.01
/

&electrons
/

&ions
/

&cell
/

ATOMIC_SPECIES
 Au  196.966  Au_ONCV_PBE-1.0.upf
ATOMIC_POSITIONS (alat)
 Au  0.000000  0.000000  0.000000
 Au  0.500000  0.288675  0.816497
 Au  0.000000  0.577350  1.632993 
 Au  0.000000  0.000000  2.449490 
K_POINTS (automatic)
 8 8 1 1 1 1

EOF
pw.x < Au.$NAME.${i}.in > Au.$NAME.${i}.out
grep "!" Au.$NAME.${i}.out | awk '{print '${i}', $5}' >> E_vs_ctff.dat
done
