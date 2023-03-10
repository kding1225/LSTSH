function ns = estimate_ns(Y)
%Y: each column is a label vector

N = size(Y,2);
if(all(sum(Y)==1))
    ns = sum(sum(Y,2).^2);
else
    if(N<10000)
        ns = nnz(Y'*Y);
    elseif(N<200000)
        Ysamp = Y(:,randsample(N,round(0.1*N)));
        ns = min(N^2,10^2*nnz(Ysamp'*Ysamp));
    else
        Ysamp = Y(:,randsample(N,round(0.02*N)));
        ns = min(N^2,50^2*nnz(Ysamp'*Ysamp));
    end
end

end