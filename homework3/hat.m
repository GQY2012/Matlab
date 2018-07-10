[x,y] = meshgrid(-3*pi:pi/30:3*pi);
r = sqrt(x.^2+y.^2);
z = sin(r)./r;
mesh(x,y,z);

