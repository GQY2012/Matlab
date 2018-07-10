function sid = mysawth_Fourier(n)
if nargin == 0
    n = 10;
end
Fn=1000;
t=-3*pi:0.5:3*pi;
y=sawtooth(t);
plot(t,y);
title('¾â³Ý²¨');
xlabel('Ê±¼ä/s');
ylabel('Õñ·ù');
hold on
N=1:n;
COSIN=sin(N'*t);
AN=-2./(N*pi);
AN_1=meshgrid(AN,ones(size(t)))';
COSIN_1=AN_1.*COSIN;
ft=sum(COSIN_1);
plot(t,ft);
sid = ft;


