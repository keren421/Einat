function g = growth_rate(P,cost)
%any reason to do it with exp or just random choice?
g = exp(-sum(P(:,1)*cost(1) + P(:,2)*cost(2))) ;
%g = 1-(P(:,2)>0)*0.3-(P(:,1)>0)*0.3 - sum(P(:,1)*cost(1) + P(:,2)*cost(2)) ;
end