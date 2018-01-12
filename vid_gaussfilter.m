function [vid_filtered] = vid_gaussfilter(video, window_size, sigma)
%VID_GAUSSFILTER filters an image using a gaussian filter.
%   Creates a guassian filter with specified window size and standard
%   deviation. Video is expected to be grayscale.

% Create gaussian filter
h = fspecial('gaussian', window_size, sigma);

% Apply filter
vid_filtered = zeros(size(video));
for frame = 1:size(video, 3)
    vid_filtered(:,:,frame) = imfilter(video(:,:,frame), h);
end

end

