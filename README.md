# DFT

The main objective of this repository is to study the adsorption of carbon monoxide (CO) on the metal surface Au (111). To carry out this study it is required that you have the ```quantum-espresso``` and ```xcrysden``` packages installed. In addition, basic knowledge about ```ab-initio``` calculations is necessary.

## Convergence parameters
in the ```./FCC``` folder we can find different metals with a structure face-centered cubic (fcc). The following figure shows the convergence of energy as a function of paramater ```ecutwfc```. The calculation made is of type ```scf``` and the ```k-points``` are ```8, 8, 8```

![ecut_e](https://user-images.githubusercontent.com/37848611/41562372-bccedfec-7322-11e8-8679-c27af20f0aab.jpeg)



Then we analyzed the convergence of the energy with regard to the points k, we show below a table with the results obtained in the convergence:

element | ecutwfc [eV] |k-points| lattice const [a.u] | lattice const (exp)[a.u] | energy [Ry]
--------|--------------|--------|---------------------|--------------------------|------------
<a href="https://www.codecogs.com/eqnedit.php?latex=\dpi{120}&space;\mathrm{Au}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\dpi{120}&space;\mathrm{Au}" title="\mathrm{Au}" /></a> |545|6-8|7.859|7.706|-274.72
<a href="https://www.codecogs.com/eqnedit.php?latex=\dpi{120}&space;\mathrm{Ag}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\dpi{120}&space;\mathrm{Ag}" title="\mathrm{Ag}" /></a> |545|6-8|7.839|7.720|-287.63
<a href="https://www.codecogs.com/eqnedit.php?latex=\dpi{120}&space;\mathrm{Pt}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\dpi{120}&space;\mathrm{Pt}" title="\mathrm{Pt}" /></a> |272|4-6|7.474|7.415|-210.27
<a href="https://www.codecogs.com/eqnedit.php?latex=\dpi{120}&space;\mathrm{Pd}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\dpi{120}&space;\mathrm{Pd}" title="\mathrm{Pd}" /></a> |408|4-6|7.458|7.352|-253.38
<a href="https://www.codecogs.com/eqnedit.php?latex=\dpi{120}&space;\mathrm{Ir}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\dpi{120}&space;\mathrm{Ir}" title="\mathrm{Ir}" /></a> |408|8-10|7.319|7.255|-181.78
<a href="https://www.codecogs.com/eqnedit.php?latex=\dpi{120}&space;\mathrm{Rh}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\dpi{120}&space;\mathrm{Rh}" title="\mathrm{Rh}" /></a> |272|> 10|7.196|7.187|-216.51

## Adsorption of CO on Au (111)
Using the experimental lattice parameter of the Au, we built the cell with the ```slab``` representing the surface (111) of the Au. The following figure shows the surface with the CO molecule arranged in a ```top``` place.

![pwi2xsf](https://user-images.githubusercontent.com/37848611/41565852-e2dc7850-732e-11e8-9d90-ea3cc75533eb.jpg)

The energy of adsorption on the surface is given by:

<a href="https://www.codecogs.com/eqnedit.php?latex=\dpi{120}&space;E_{abs}&space;=&space;-&space;\left&space;(&space;E_{\mathrm{CO}/Sup}&space;-&space;E_{Sup}&space;-&space;E_{\mathrm{CO}}\right&space;)" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\dpi{120}&space;E_{abs}&space;=&space;-&space;\left&space;(&space;E_{\mathrm{CO}/Sup}&space;-&space;E_{Sup}&space;-&space;E_{\mathrm{CO}}\right&space;)" title="E_{abs} = - \left ( E_{\mathrm{CO}/Sup} - E_{Sup} - E_{\mathrm{CO}}\right )" /></a>

Without relaxing this structure we calculate how is the convergence of the adsorption energy in function of the ```ecutwfc``` parameter, the input files are in ```./ADSORPTION_ECUTWFC```. The value in convergence is ```ecutwfc = 408 eV```, see the output files and the following figure:

## Surface Au(111)
We carry out a relaxation of the surface Au (111) to obtain the distance between relaxed layers. And later calculate the work function of the surface. the work function turned out to be ```5.2709 eV``` and the relaxed structure turned out to be:

```text
...
ATOMIC_POSITIONS (alat)
Au       0.000000000  -0.000000000  -0.071640824
Au       0.500000000   0.288675000   0.797508797
Au       0.000000000   0.577350000   1.652174586
Au       0.000000000  -0.000000000   2.520937441
...
```
the results and some graphs can be observed in the output files in ```./RELAX```.

## CO molecule
We are a relaxation of the CO molecule starting from the experimental distance ```112.8 pm```, the input files can be found in ```./MOLECULE/CO/``` . The modes of vibration of said molecule were also analyzed:

```text
freq (1) = -3.922381 [THz] = -130.836530 [cm-1]
freq (2) = -3.922381 [THz] = -130.836530 [cm-1]
freq (3) =  4.864145 [THz] =  162.250398 [cm-1]
freq (4) =  5.492662 [THz] =  183.215483 [cm-1]
freq (5) =  5.492662 [THz] =  183.215483 [cm-1]
freq (6) =  64.08384 [THz] =  2137.60691 [cm-1]
```
We can see how the frequency of interest, ```freq(6) = 2137.6 [cm-1]``` is very similar to experimental value ```~2143 [cm-1]```.

## Chemisorption of CO on Au(111)
#### high symmetry points
Firstly, we locate the CO molecule almost vertically, allowing it to lean. Then we relax the structure, keeping the two lower layers of the surface fixed. To leave a fixed atom during relaxation we have to proceed as shown below in the input file:

```text
...
ATOMIC_POSITIONS alat
Au      0.000000        0.000000        0.000000    0   0   0
Au      0.500000        0.288675        0.816497    0   0   0
Au      0.000000        0.577350        1.632993 
Au      0.000000        0.000000        2.449490
 
C       0.500000        0.288675        3.073734
O       0.500001        0.289675        3.464843
...
```
then we perform this procedure again for different high symmetry sites ```top```, ```bridge``` and ```hollow```.

config |	Energy CO/Au(111) [Ry]	| Energy Au(111)	[Ry]|	Energy CO	[Ry] |	adsoption [Ry]|
-------|------------------------|--------------------|----------------|-----------------
```top``` |	-1158.8585489846	|	-1098.8639312247   |	-59.9853925693 	| 0.006376638799871159
```bridge``` |		-1158.8315677922|		-1098.8639312247|		-59.9853925694    |  -0.020492089900123744 
```hollow``` |	-1158.8218290875|	-1098.8639312247 |	-59.9853837055  |     	-0.030414201700068588


#### electronic density
In the following figure we can see some surfaces of isodensity:

![rho_3d](https://user-images.githubusercontent.com/37848611/41580842-c027893c-7372-11e8-9884-e64839475567.png)
![rho_35](https://user-images.githubusercontent.com/37848611/41580849-c58c449e-7372-11e8-9d6d-79ee72a62215.png)

#### work function
The work function can be calculated from the output files, by post-processing with ```pp.x```. The mathematical expression that allows to calculate depends on the potential at infinity and the level of fermi.

<a href="https://www.codecogs.com/eqnedit.php?latex=\dpi{120}&space;\phi_{Au(111)}&space;=&space;v(\infty)&space;-&space;\epsilon_{fermi}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\dpi{120}&space;\phi_{Au(111)}&space;=&space;v(\infty)&space;-&space;\epsilon_{fermi}" title="\phi_{Au(111)} = v(\infty) - \epsilon_{fermi}" /></a>

To calculate the potential, we place a molecule on both sides of the surface and then relax the system. Then the post-processing programs ```pp.x``` and ```average.x``` were used, the details of the calculation can be seen in ```./CHEMISORPTION/work_function```. The level of fermi can be found from the output of the calculations with ```pw.x``` using a simple bash command:

```bash
grep 'Fermi' name_scf_output.out
```

The results for the calculation of the potential are shown in the following figure:

![figure_1](https://user-images.githubusercontent.com/37848611/41584651-3e89198e-737e-11e8-9927-59109c0e67b1.png)

we will assume that the potential at infinity corresponds to the flat part of the curve, in the region between surfaces. The calculations for the job function are shown in the following table:

                                                                                                                                                                                                                                                                    
element | potential [eV]|fermi lever[eV] |work funcntion [eV]| work function (exp) [eV]
--------|---------------|----------------|-------------------|-------------------------
```Au (111)``` |11.347| 6.0925|5.2709 | 5.10 – 5.47
```CO/Au (111)```|13.283| 6.8064|6.4765| -

