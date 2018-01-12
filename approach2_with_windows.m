%%  Detect motion against a background using frame averaging (mode)
% Calculate the background image
background = mode(vid_gray,3);

% Preallocate for foreground, binary foreground, and motion tracking vids
vid_foreground = zeros(vidHeight, vidWidth, numberOfFrames);
vid_threshold = zeros(vidHeight, vidWidth, numberOfFrames);
% new video dimensions
width = 150; height = 200; 
% Window size for frame smoothing via coordinate averaging (Odd #)
window = 25;
vid_new = uint8(zeros(height, width, 3, numberOfFrames));
xy = int16(zeros(size(vid, 4), 2));

% Find activity center points
for frame = 1:406
    % Create a difference image
    thisFrame = vid_gray(:,:,frame);
    vid_foreground(:,:,frame) = abs(thisFrame - background);
    % Threshold difference image
    vid_threshold(:,:,frame) = imbinarize(vid_foreground(:,:,frame), 0.2);
    
    % Extract activity center (rounded to nearest int)
    [x, y] = activityCenter(vid_threshold(:,:,frame));
    [xy(frame, 1), xy(frame, 2)] = activityCenter(vid_threshold(:,:,frame));
end
% Extract new video
for frame = 1:406
    if (frame > (window-1)/2) && (frame < size(vid, 4) - (window-1)/2)
        x = mean(xy(frame-(window-1)/2:frame+(window-1)/2,1)); 
        y = mean(xy(frame-(window-1)/2:frame+(window-1)/2,2)); 

    else
        x = xy(frame, 1);
        y = xy(frame, 2);
    end
    
    left = min(size(vid,2) - width, max(1, x-int16((width-1)/2)));
    right = left + width - 1;
    top = min(size(vid,1) - height, max(1, y-int16((height-1)/2)));
    bottom = top + height - 1;
    
    vid_new(:,:,:,frame) = vid(top:bottom, left:right, :, frame);
end
