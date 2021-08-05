function L=lambdafcns(inmf,op)
if nargin < 2
    op=@min ;
end
num_rules=size(inmf,1);
L=cell(1,num_rules);
for i = 1 : num_rules
    L{i}=@(varargin)ruleStrength(i,varargin{:});
end
    function lambda=ruleStrength(i,varargin)
        Z=varargin;
        memberfcn=inmf{i,1};
        lambda = memberfcn(Z{1});
        for j=2:numel(varargin)
            memberfcn=inmf{i,j};
            lambda=op(lambda,memberfcn(Z{j}));
        end
    end
end
