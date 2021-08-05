function F = fuzzysysfcn(inmf,outmf,vrange,op)
if nargin < 4
    op=@min;
end
L=lambdafcns(inmf, op);
F=@fuzzyOutput ;
    function out=fuzzyOutput(varargin)
        Z=varargin ;
        Zk=cell(1,numel(Z));
        out=zeros(size(Z{1}));
        for k=1:numel(Z{1})
            for p=1:numel(Zk)
                Zk{p} = Z{p}(k);
            end
            Q=implfcns(L,outmf,Zk{:});
            Qa=aggfcn(Q);
            out(k)=defuzzify(Qa,vrange);
        end
    end
end