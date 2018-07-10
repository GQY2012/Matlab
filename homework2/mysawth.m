function sig = mysawth(A,T1,T2)
	if nargin == 0
		A = 1;
		T1 = 0;
		T2 = 0.5;
    end
    fs = 500;
    T = T2 - T1;
    t = T1-1:1/fs:T2+1;
    t1 = find(t<T1);
    t2 = find(t>T1 & t < T2);
    t3 = find(t>T2);
    x = zeros(1,size(t,2));
    x(t1) = 0;
    x(t2) = A*(t(t2) - T1)/T;
    x(t3) = 0;
    plot(t,x);
    title('¾â³Ý²¨');
    xlabel('Ê±¼ä/s');
    ylabel('Õñ·ù');
    sig = x;