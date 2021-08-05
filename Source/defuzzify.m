function out = defuzzify(Qa,vrange)
v1=vrange(1);
v2=vrange(2);
v=linspace(v1,v2,100);
Qv=Qa(v);
out=sum(v.* Qv)/sum(Qv);
if isnan(out)
    out=mean(vrange) ;
end
end