function y = knee_y(time)
	y = +0.262*cos(-7*2*pi*time+-2.659)+0.187*cos(-6*2*pi*time+-0.196)+0.398*cos(-5*2*pi*time+2.420)+1.423*cos(-4*2*pi*time+-1.543)+6.233*cos(-3*2*pi*time+-2.429)+8.543*cos(-2*2*pi*time+2.724)+7.427*cos(-1*2*pi*time+2.435)+510.099*cos(0*2*pi*time+0.000)+7.427*cos(1*2*pi*time+-2.435)+8.543*cos(2*2*pi*time+-2.724)+6.233*cos(3*2*pi*time+2.429)+1.423*cos(4*2*pi*time+1.543)+0.398*cos(5*2*pi*time+-2.420)+0.187*cos(6*2*pi*time+0.196)+0.262*cos(7*2*pi*time+2.659);
end