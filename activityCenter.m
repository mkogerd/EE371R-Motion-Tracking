function [x,y] = activityCenter(difference_img)
%ACTIVITYCENTER calculates the activity centerpoint of a frame-difference
%image.
%   ACTIVITYCENTER returns the x and y center points as doubles. The
%   difference image should be a gray-scale image.
sum_x = double(0);
sum_y = double(0);
for x = 1:size(difference_img, 2)
    for y = 1:size(difference_img, 1)
        sum_x = sum_x + x*double(difference_img(y,x));
        sum_y = sum_y + y*double(difference_img(y,x));
    end
end
total = sum(difference_img(:));
if total
    x = sum_x/total;
    y = sum_y/total;
else
    x = 0;
    y = 0;
end
end

