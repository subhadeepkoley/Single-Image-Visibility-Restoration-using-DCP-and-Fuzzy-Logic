function g=specfiedTransform(f,txfun)
txfun=txfun(:);
if any(txfun)>1 || any(txfun)<=0
    error('All elements of txfun must be in the range [0 1].')
end
T=txfun;
X=linspace(0,1,numel(T))';
g=interp1(X,T,f,'nearest');
end