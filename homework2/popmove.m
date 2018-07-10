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
        end
    else
        disp('P不是概率转移矩阵')
        return
    end

function Y = method1(P,X0,N)
    Y = P^N * X0;
        
function Y = method2(P,X0,N)
    lambda = eig(P);
    P1 = diag(lambda);
    Y = P1^N *X0;