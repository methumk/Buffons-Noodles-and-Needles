function [bent_intersect] = bent_needle_drop(l, bend, n)
% inputs: 
% l = length of entire bent needle,
% bend = sets acute angle between needle to a constant (if bend = 0, acute angle random from pi/6 to 5pi/6),
% n = # of bent needles
%
% output:
% bent_intersect = first column contains if the needle intersected the
% horizontal line (1 - yes, 0 - no), the 2 next columns contain the x and
% y pos for the left most side, the next 2 columns contain the middle x
% and y pos, and the next 2 columns contain the x and y pos for the right
% most side

% generate midpoints for n needles from 0.5 to 4.5
midpoint = [];
for i=1:n
    mx = 4*rand(1,1) + 0.5;
    my = 4*rand(1,1) + 0.5;
    midpoint = [midpoint; mx, my];
end

% angle will contain random angle for needle orientation from 0 to 2pi
% and left and right needles rise and run
% if bend = 0, will generate random acute angle from pi/6 to 5pi/6,
% otherwise constant bend angle
angle = [];
if (bend == 0)
    for i=1:n
        norient = (2*pi)*rand(1,1);
        nbend = (4*pi/6)*rand(1,1) + (pi/6);
        
        %left most needle rise and run values
        lrun = (l/2)*cos(norient + (nbend/2));
        lrise = (l/2)*sin(norient + (nbend/2));
        
        %right most needle rise and run values
        rrun = (l/2)*cos(norient - (nbend/2));
        rrise = (l/2)*sin(norient - (nbend/2));
        
        angle = [angle; norient, nbend, lrun, lrise, rrun, rrise];
    end
else
    for i=1:n
        norient = (2*pi)*rand(1,1);
        
        %left most needle rise and run values
        lrun = (l/2)*cos(norient + (bend/2));
        lrise = (l/2)*sin(norient + (bend/2));
        
        %right most needle rise and run values
        rrun = (l/2)*cos(norient - (bend/2));
        rrise = (l/2)*sin(norient - (bend/2));
        
        angle = [angle; norient, bend, lrun, lrise, rrun, rrise];
    end  
end


bent_intersect = [];
for i=1:n
    %find values for left and right needles x and y points
    lx = midpoint(i, 1) + angle(i, 3);
    ly = midpoint(i, 2) + angle(i, 4);
    rx = midpoint(i, 1) + angle(i, 5);
    ry = midpoint(i, 2) + angle(i, 6);
    
    % determine if the lines intersected
    inter = 0;
    if ((midpoint(i, 2) <= 1 && (ly >=1 || ry >=1)) || (midpoint(i,2) >= 1 && (ly <= 1 || ry <= 1)))
        inter = 1;
    elseif ((midpoint(i, 2) <= 2 && (ly >= 2 || ry >= 2)) || (midpoint(i,2) >= 2 && (ly <= 2 || ry <= 2)))
        inter = 1;
    elseif ((midpoint(i, 2) <= 3 && (ly >= 3 || ry >= 3)) || (midpoint(i,2) >= 3 && (ly <= 3 || ry <= 3)))
        inter = 1;
    elseif ((midpoint(i, 2) <= 4 && (ly >= 4 || ry >= 4)) || (midpoint(i,2) >= 4 && (ly <= 4 || ry <= 4)))
        inter = 1;
    end
   
    % store needle points and if it intersected or not
    bent_intersect = [bent_intersect; inter, lx, ly, midpoint(i,1), midpoint(i,2), rx, ry];
end

end