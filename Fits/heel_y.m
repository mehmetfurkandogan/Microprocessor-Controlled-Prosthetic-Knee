function y = heel_y(time)
	y = +0.160*cos(-7*2*pi*time+-2.739)+0.419*cos(-6*2*pi*time+-0.056)+0.337*cos(-5*2*pi*time+2.563)+3.043*cos(-4*2*pi*time+1.571)+9.864*cos(-3*2*pi*time+1.071)+26.027*cos(-2*2*pi*time+0.645)+46.872*cos(-1*2*pi*time+0.245)+101.393*cos(0*2*pi*time+0.000)+46.872*cos(1*2*pi*time+-0.245)+26.027*cos(2*2*pi*time+-0.645)+9.864*cos(3*2*pi*time+-1.071)+3.043*cos(4*2*pi*time+-1.571)+0.337*cos(5*2*pi*time+-2.563)+0.419*cos(6*2*pi*time+0.056)+0.160*cos(7*2*pi*time+2.739);
end