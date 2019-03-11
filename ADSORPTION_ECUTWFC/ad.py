import numpy as np
import matplotlib.pyplot as plt
import sys

from matplotlib import rc

rc("font", **{"family": "sans-serif", "sans-serif": ["Helvetica"]})
rc("text", usetex=True)

plt.style.use("seaborn-darkgrid")


def function(names):
	
	_x = 0.13605698066 * np.loadtxt(names[0], dtype=float)[:,0]
	_y = - 13.605698066 *(np.loadtxt(names[2], dtype=float)[:,1] - np.loadtxt(names[0], dtype=float)[:,1] - np.loadtxt(names[1], dtype=float)[:,1])

	plt.plot(_x, _y, marker='d', markersize=12)
	plt.ylabel(r'$E_{abs}$ $[\mathrm{eV}]$', fontsize=25)
	plt.xlabel(r'$ECUTWFC$ $[10^2\mathrm{eV}]$', fontsize=25) 
	plt.xticks(size=25)
	plt.yticks(size=25)
	#plt.xlim(xmin=0, xmax=40)
	plt.show()


def main():
	names = ['Au.dat', 'CO.dat', 'Au_CO.dat']
	function(names)


if __name__ == '__main__':
	main()