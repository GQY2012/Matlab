R = 6; 
r = 2;
syms u v;
subplot(2,1,1);
ezmesh((R+r*cos(u))*cos(v),(R+r*cos(u))*sin(v),r*sin(u));
subplot(2,1,2);
ezsurf((R+r*cos(u))*cos(v),(R+r*cos(u))*sin(v),r*sin(u));
axis equal;