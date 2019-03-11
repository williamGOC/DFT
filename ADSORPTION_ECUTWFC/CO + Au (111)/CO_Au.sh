#!bin/bash

NAME='ecutwfc'

for i in `echo 5 60 5 | awk '{for(d=$1;d<=$2;d+=$3){printf "%d ",d}}'`
do
cat > CO_Au.$NAME.${i}.in << EOF
&control
    calculation='scf'
    prefix='CO_Au',
    pseudo_dir = '/home/oropebuen/Documents/Job/Absortion/SSSP_efficiency_pseudos',
    outdir='./tmp/'
/

&system
    ibrav=4,
    celldm(1)=5.449,
    celldm(3)=7.427,
    nat=6,
    ntyp=3,
    ecutwfc = ${i}
    ecutrho = $((i*8))
    occupations='smearing', 
    smearing='gauss', 
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
C   12.0107  C.pbe-n-kjpaw_psl.1.0.0.UPF
O   15.9994  O.pbe-n-kjpaw_psl.0.1.U
 
ATOMIC_POSITIONS alat
Au      0.000000        0.000000        0.000000
Au      0.500000        0.288675        0.816497
Au      0.000000        0.577350        1.632993 
Au      0.000000        0.000000        2.449490 
C       0.000000        0.000000        3.073734
O       0.000000        0.000000        3.464844
K_POINTS automatic
8 8 1 1 1 1

EOF
pw.x < CO_Au.$NAME.${i}.in > CO_Au.$NAME.${i}.out
grep "!" CO_Au.$NAME.${i}.out | awk '{print '${i}', $5}' >> E_vs_ctff.dat
done
