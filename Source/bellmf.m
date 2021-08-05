function mu=bellmf(z,a,b)
mu=zeros(size(z));
left_side=z<b;
mu(left_side)=smf(z(left_side),[a,b]);
right_side=z>=b;
mu(right_side)=smf(2*b-z(right_side),[a,b]);
end