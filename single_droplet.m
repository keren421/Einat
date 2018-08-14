function [y1,y2] = single_droplet(P1,P2,cost)
f1 = fitness(P1,cost) ;
f2 = fitness(P2,cost) ;

switch 'keren'
    case 'roy'
        i1 = all(P1(:,1)>=P2(:,2)) ;
        i2 = all(P2(:,1)>=P1(:,2)) ;
        res = f1+f2 ;
        %why divide by f1+f2?
        y1 = i1/(i1+i2)*f1 ;
        y2 = i2/(i1+i2)*f2 ;
    case 'keren'
        growth1 = f1 - min(sum(max(P2(:,2)-P1(:,1),0)),f1);
        growth2 = f2 - min(sum(max(P1(:,2)-P2(:,1),0)),f2);
        y1 = growth1/(growth1+growth2);
        y2 = growth2/(growth1+growth2) ;
    case 'keren_2'
        growth1 = f1 - min(sum(max(P2(:,2)+P1(:,2)-P1(:,1),0)),f1);
        growth2 = f2 - min(sum(max(P1(:,2)+P2(:,2)-P2(:,1),0)),f2);
        y1 = growth1/(growth1+growth2);
        y2 = growth2/(growth1+growth2);
end
end


function f = fitness(P,cost)
%any reason to do it with exp or just random choice?
f = exp(-sum(P(:,1)*cost(1) + P(:,2)*cost(2))) ;
end
