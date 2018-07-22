function [Y,N] = popmove(P,X0,N,method)
    if nargin < 4
        method = 1;
    end
    if nargin < 3
        N = 10;
    end
    
    if isempty(find(sum(P) ~= 1))   
        if method == 1
           Y = method1(P,X0,N);
        elseif method == 2
           Y = real(method2(P,X0,N));     
        else
            disp('方法不存在')
        end
    else
        disp('P不是概率转移矩阵')
        return
    end

function Y = method1(P,X0,N)
    Y = P^N * X0;
        
function Y = method2(P,X0,N)
    [V D] = eig(P);
    Y = V*D^N*inv(V) *X0;