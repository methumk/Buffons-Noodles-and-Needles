function [midpoint, angle, intersect] = straight_needle_drop(l, n)
% inputs: 
% l = length of straight needle, n = number of drops
%
% outputs:
% midpoint = contains the x and y points for the midpoint of each needle,
% where x and y are cols and each pair is a row
%
% angle = contains the angle from the horizontal of the midpoint to the
% line, the other cols contain the rise and run from this angle e.g.
% (theta, (l/2)*sin(theta), (l/2)*cos(theta)
%
% intersect = contains if the corresponding needle from midpoint intersected one 
% of the horizontal lines (1 through 4), it also contains the start xy point and end xy point 

%create x and y midpoints from [0.5, 4.5]
nx = 4*rand(n, 1)+0.5;
ny = 4*rand(n, 1)+0.5;
midpoint = [];

%add each midpoint to midpoint array
for i=1:n
    point_pair = [nx(i), ny(i)];
    midpoint = [midpoint; point_pair];
end

%generate angle for each needle and the slope of that line in rise and run
%format
angle = [];
for i=1:n
    %angle goes from 0 to pi
    theta = pi*rand(1,1);
    %rise and run is a calculation based on the hypotenuse (l/2) and the
    %rise or the run (sin or cos)
    rise = (l/2)*sin(theta);
    run = (l/2)*cos(theta);
    angle = [angle; theta, rise, run];
end


%generate if the needle intersected a horizontal line and the start
% and end xy points of each corresponding needle
intersect = [];
for i=1:n
    %determined the start xy points and end xy point to be able to plot
    %them easily
   startx = -1*angle(i, 3) + midpoint(i, 1);
   starty = -1*angle(i, 2) + midpoint(i, 2);
   endx = angle(i, 3) + midpoint(i, 1);
   endy = angle(i, 2) + midpoint(i, 2);
   
  
   myi = midpoint(i, 2);
   inter = 0;
   
   %determine if the needle interesected on of the four horizontal lines
   %it does this by looking at intervals from where the midpoint is in
   %respect to the nearest midpoint line.
   if (0.5 <= myi && myi <= 1)
       %midpoint is between 0.5 and 1
       if (endy >= 1)
           %the endpoint (highest y point) is greater than y = 1, which
           %means it intersected it
           inter = 1;
       end
   elseif (1 <= myi && myi <= 1.5)
       %midpoint between 1 and 1.5
      if (starty <= 1)
          %start y point (lowest y point) is less than 1, which means it
          %intersected y = 1
          inter = 1;
      end
   elseif (1.5 <= myi && myi <= 2)
       %midpoint between 1.5 and 2
       if (endy >= 2) 
           %end y point (highest y point) is greater than 2, it intersected
           %y=2
           inter = 1;
       end
   elseif (2 <= myi && myi <= 2.5)
       %midpoint between 2 and 2.5
       if (starty <= 2)
           %start y point less than 2, it interesected y = 2
           inter = 1;
       end
   elseif (2.5 <= myi && myi <= 3)
       %midpoint between 2.5 and 3
       if (endy >= 3)
           %end y point greater than 3, it intersected y = 3
           inter = 1;
       end
   elseif (3 <= myi && myi <= 3.5)
       %midpoint between 3 and 3.5
       if (starty <= 3 )
           %start y point less than 3, it intersected y =3
           inter = 1;
       end
   elseif (3.5 <= myi && myi <= 4)
       %midpoint between 3.5 and 4
       if (endy >= 4)
           %end y point greater than 4, it intersected y = 4
           inter = 1;
       end
   elseif (4 <= myi && myi <= 4.5)
       %midpoint between 4 and 4.5
       if (starty <= 4)
           %start y point less than 4, it intersected y = -3
           inter = 1;
       end
   end
   
   %store determined values for each needle
   intersect = [intersect; inter, startx, starty, endx, endy];
end


end
