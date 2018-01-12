function [vid_filtered] = vid_edgefilter(video)
%VID_EDGEFILTER performs a Canny edge filter on a grayscale video.

% Apply filter
vid_filtered = zeros(size(video));
for frame = 1:size(video, 3)
    vid_filtered(:,:,frame) = edge(video(:,:,frame),'Canny');
end

end

