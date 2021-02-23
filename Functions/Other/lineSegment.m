function [y] = lineSegment(x,point1,point2)

y = point1(2) + (point2(2)-point1(2))/(point2(1)-point1(1))*(x-point1(1));

if isnan(y) || isinf(y)
    y = 0;
end

end












