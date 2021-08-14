function [noodle_points, noodle_intersect] = drop_noodle(l, n)
% inputs:
% l = length of noodle
% n = number of noodles dropped
%
% outputs:
% noodle_intersect = first column contains if the needle intersected the
% horizontal line (0 - no, 1 - yes), the 2nd column contains +1 and -1 or 0
% determining if the preferred end is above or below the horizontal line
% noodle_points = the first 2 columns contains the left end point for the needle, the other
% 2 columns contain the eye end points, the next 2 columns contains the
% right end points for the needle, the next 2 columns contains the noodle
% end points, the last column contains what type of noodle it is (\/\ (0) or /\/ (1))

%determine center left and right x and y points, this is the eye of the
%noodle
eye = [];
for i=1:n
   cx = 4*rand(1,1)+0.5;
   cy = 4*rand(1,1)+0.5;
   eye = [eye; cx, cy];
end

%determine the angles needed to create the two lines that stem from the eye 
% (to create \/ shape) and the noodle type (\/\ or /\/)
angle = [];
for i=1:n
    % orient angle is random angle from horizontal to first needle
    orient = 2*pi*rand(1,1);
    
    % generate bend angle, random from pi/6 to 5pi/6
    bend = (4*pi/6)*rand(1,1) + (pi/6);
    
    %generate left and right needle rise and run points
    lrun = (l/3)*cos(orient+bend);
    lrise = (l/3)*sin(orient+bend);
    rrun = (l/3)*cos(orient);
    rrise = (l/3)*sin(orient);
    
    %randomly choose if needle will look like \/\ (0) or /\/ (1)
    noodle_type = randi([0,1], 1);
    angle = [angle; lrun, lrise, rrun, rrise, noodle_type, orient, bend];
end

%determine the x and y points for each needle
noodle_points = [];
for i=1:n
    % V shape left x and y points
    lx = eye(i, 1) + angle(i, 1);
    ly = eye(i, 2) + angle(i, 2);
    
    % V shape right x and y points
    rx = eye(i, 1) + angle(i, 3);
    ry = eye(i, 2) + angle(i, 4);
    
    %Find points for the last leg of the noodle 
    noodle_angle = pi/2 - (angle(i, 7)/2);
    noodle_arm_length = 2*(l/3)*cos(noodle_angle);
    if (angle(i, 5) == 1)
       % /\/ (1)
       angle_to_noodle_arm = angle(i, 6) + angle(i, 7) + noodle_angle;
    else
       % \/\ (0)
       angle_to_noodle_arm = angle(i, 6) - noodle_angle;
    end
    %determine x and y points for noodle
    nx = noodle_arm_length*cos(angle_to_noodle_arm) + eye(i, 1);
    ny = noodle_arm_length*sin(angle_to_noodle_arm) + eye(i, 2);
    
    
    %store noodle x and y based on what type of bend it is
    if (angle(i, 5) == 1)
        % /\c/ (1)
        noodle_points = [noodle_points; nx, ny, lx, ly, eye(i, 1), eye(i, 2), rx, ry, angle(i, 5)];
    else
        % \c/\ (0)
        noodle_points = [noodle_points; lx, ly, eye(i, 1), eye(i, 2), rx, ry, nx, ny, angle(i, 5)];
    end
end


%determine if the noodle intersected the line and if the eye is above
%or below the horizontal line 
noodle_intersect = [];
for i=1:n
    intersect = 0;
    o_cross = 0;
    
    %check intersection cases based on noodle type
    
    if ((noodle_points(i, 2) <= 1 && noodle_points(i, 8) >= 1) || (noodle_points(i, 6) <= 1 && noodle_points(i, 4) >= 1)|| (noodle_points(i, 8) <= 1 && noodle_points(i, 2) >= 1) || (noodle_points(i, 4) <= 1 && noodle_points(i, 6) >= 1))
        intersect = 1;
        %determine if positive or negative intersection
        if (eye(i, 2) < 1)
            o_cross = -1;
        elseif (eye(i, 2) > 1)
            o_cross = 1;
        end
    elseif ((noodle_points(i, 2) <= 2 && noodle_points(i, 8) >= 2) || (noodle_points(i, 6) <= 2 && noodle_points(i, 4) >= 2) || (noodle_points(i, 8) <= 2 && noodle_points(i, 2) >= 2) || (noodle_points(i, 4) <= 2 && noodle_points(i, 6) >= 2))
        intersect = 1;
        %determine if positive or negative intersection
        if (eye(i, 2) < 2)
            o_cross = -1;
        elseif (eye(i, 2) > 2)
            o_cross = 1;
        end
    elseif ((noodle_points(i, 2) <= 3 && noodle_points(i, 8) >= 3) || (noodle_points(i, 6) <= 3 && noodle_points(i, 4) >= 3) || (noodle_points(i, 8) <= 3 && noodle_points(i, 2) >= 3) || (noodle_points(i, 4) <= 3 && noodle_points(i, 6) >= 3))
        intersect = 1;
        %determine if positive or negative intersection
        if (eye(i, 2) < 3)
            o_cross = -1;
        elseif (eye(i, 2) > 3)
            o_cross = 1;
        end
    elseif ((noodle_points(i, 2) <= 4 && noodle_points(i, 8) >= 4) || (noodle_points(i, 6) <= 4 && noodle_points(i, 4) >= 4) || (noodle_points(i, 8) <= 4 && noodle_points(i, 2) >= 4) || (noodle_points(i, 4) <= 4 && noodle_points(i, 6) >= 4))
        intersect = 1;
        %determine if positive or negative intersection
        if (eye(i, 2) < 4)
            o_cross = -1;
        elseif (eye(i, 2) > 4)
            o_cross = 1;
        end
    end
    
   %store the information about the intersections
   noodle_intersect = [noodle_intersect; intersect, o_cross];
end

end
