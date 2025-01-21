import matplotlib.pyplot as plt
import matplotlib.backends.backend_pdf
import os
name = os.path.basename(__file__).split(".py")[0]#name="prueba"
#pdf = matplotlib.backends.backend_pdf.PdfPages(name+".pdf")
font = {'size'   : 14}
matplotlib.rc('font', **font)
#############

import numpy as np
from scipy.stats import norm

step = 0.01
z = np.arange(-10,10+step,step)
msj_fm_m = [] # con x = 0
for m in np.arange(-10,10+step,step):
    msj_fm_m.append(sum(norm(loc=0, scale=1).pdf(z) * norm(loc=-m, scale=1).pdf(2*z**2))*(step))


plt.plot(np.arange(-10,10+step,step), msj_fm_m)
plt.xlabel("m|x'=0")
plt.ylabel("P(m|x'=0)")
plt.tight_layout()
plt.savefig(name )


################
#bash_cmd = "convert $(ls -rt pdf/example1*) pdf/example1.pdf"
##bash_cmd = "pdfcrop --margins '0 0 0 0' {0}.pdf {0}.pdf".format(name)
#os.system(bash_cmd)
