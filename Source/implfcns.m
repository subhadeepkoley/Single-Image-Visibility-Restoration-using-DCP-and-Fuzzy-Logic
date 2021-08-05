function Q=implfcns(L,outmf,varargin)
Z=varargin;
num_rules=numel(L);
Q=cell(1,numel(outmf));
lambdas=zeros(1,num_rules);
for i=1:num_rules
    lambdas(i)=L{i}(Z{:});
end
for i = 1 : num_rules
    Q{i}=@(v)implication(i,v);
end
if numel(outmf)==(num_rules+1)
    Q{num_rules+1}=@elseRule;
end

    function q=implication(i,v)
        q=min(lambdas(i),outmf{i}(v));
    end
    function q=elseRule(v)
        lambda_e=min(1-lambdas);
        q=min(lambda_e,outmf{end}(v));
    end
end