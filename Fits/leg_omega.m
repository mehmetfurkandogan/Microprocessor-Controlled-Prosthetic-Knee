function y = leg_omega(time)
	y = +0.133*cos(-5*2*pi*time+3.077)+0.177*cos(-4*2*pi*time+1.393)+0.305*cos(-3*2*pi*time+-2.439)+1.403*cos(-2*2*pi*time+2.446)+1.600*cos(-1*2*pi*time+1.338)+0.017*cos(0*2*pi*time+3.142)+1.600*cos(1*2*pi*time+-1.338)+1.403*cos(2*2*pi*time+-2.446)+0.305*cos(3*2*pi*time+2.439)+0.177*cos(4*2*pi*time+-1.393);
end