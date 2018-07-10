function epicycloid(x1,y1,r1,r2)
    close all; clear all;
    global theta; 
    theta = 0:pi/20:2*pi;
    if nargin == 0     
        x1 = 0;
        y1 = 0;
        r1 = 2 ;
        r2 = 1;
    end
    fig=figure;
    drawcircle(x1,y1,r1);
    axis equal;
    hold on;

    a = r1;
    b = r2;
    x0 = x1;
    y0 = y1;
    [x_e,y_e] = drawepicycloid(a,b,x0,y0);

    r3 = r1+r2;
    x3 = x1;
    y3= y1;
     x_3 = r3*cos(theta) + x3; 
     y_3 = r3*sin(theta)  + y3; 

    hp1 = plot(x_e(1),y_e(1),'marker','o','markersize',10,'markerfacecolor','r');
    drawcircle(x_3,y_3,r2);
    for k = 1:length(theta)
        set(hp1,'xdata',x_e(k),'ydata',y_e(k));
        drawcircle(x_3(k),y_3(k),r2);
        h = findobj;
        delete(h(5));
        pause(0.1);
    
        F = getframe(fig); 
        im = frame2im(F); 
        [I,map] = rgb2ind(im,256);  
        if k == 1
            imwrite(I,map,'epicycloid.gif','GIF', 'Loopcount',inf,'DelayTime',0.1); 
        else
            imwrite(I,map,'epicycloid.gif','GIF','WriteMode','append', 'DelayTime',0.1);
        end
    end

    function [x,y,hp] = drawcircle(x0,y0,r0)
        x = r0*cos(theta) + x0; 
        y = r0*sin(theta)  + y0; 
        hp = plot(x,y); 
    end

    function [x,y] = drawepicycloid(a,b,x0,y0)
        x = x0+(a+b)*cos(theta)-b*cos((a+b)*theta/b);
        y = y0+(a+b)*sin(theta)-b*sin((a+b)*theta/b);
        plot(x,y);
    end
end