import numpy as np
import matplotlib.pyplot as plt
import sys

from matplotlib import rc

rc("font", **{"family": "sans-serif", "sans-serif": ["Helvetica"]})
rc("text", usetex=True)

plt.style.use("seaborn-darkgrid")


def function(names):
	
	labels = [r'$\mathrm{Au}(111)$', r'$\mathrm{CO}/\mathrm{Au}(111)$(hollow)']
	for name, lab  in zip(names, labels):
		data_1 = np.loadtxt(name, dtype=float)

		_x = data_1[:,0]
		_y = 13.605698066 * data_1[:,1]

		plt.plot(_x, _y, label=lab)
	
	plt.ylabel(r'$V$ $[\mathrm{eV}]$', fontsize=25)
	plt.xlabel(r'$L$ $[a.u]$', fontsize=25) 
	plt.xticks(size=25)
	plt.yticks(size=25)
	plt.xlim(xmin=0, xmax=40)
	plt.legend(fontsize=25)
	plt.show()


def main():
	names = ['Au.average.dat', 'Au_CO.average.dat']
	function(names)


if __name__ == '__main__':
	main()
