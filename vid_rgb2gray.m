function [vid_gray] = vid_rgb2gray(video)
%VID_RGB2GRAY converts an rgb video to grayscale.
%   Returns the video as an array of grayscale doubles.

vid_gray = zeros(size(video,1), size(video,2), size(video,4));
for frame = 1:size(video, 4)
    vid_gray(:,:,frame) = im2double(rgb2gray(video(:,:,:,frame)));
end

end

