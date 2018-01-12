%%  Detect motion against a background using frame averaging (mode)
% Calculate the background image
background = mode(vid_gray,3);
background_c = mode(vid,4);

% Preallocate for foreground, binary foreground, and motion tracking vids
vid_foreground = zeros(vidHeight, vidWidth, numberOfFrames);
vid_threshold = zeros(vidHeight, vidWidth, numberOfFrames);

% Foreground image tracking
vid_track1 = uint8(zeros(vidHeight, vidWidth, 3, numberOfFrames));
vid_track1C = uint8(zeros(vidHeight, vidWidth, 3, numberOfFrames));

% Binzarized foreground image tracking
vid_track2 = uint8(zeros(vidHeight, vidWidth, 3, numberOfFrames));
vid_track2C = uint8(zeros(vidHeight, vidWidth, 3, numberOfFrames));

% Preallocate for creating disparity (abandoned)
vid_edge = zeros(vidHeight, vidWidth, numberOfFrames);
vid_left = uint8(zeros(vidHeight, vidWidth, 3, numberOfFrames));
vid_right = uint8(zeros(vidHeight, vidWidth, 3, numberOfFrames));

for frame = 1:406
    % Create a difference image
    thisFrame = vid_gray(:,:,frame);
    vid_foreground(:,:,frame) = abs(thisFrame - background);
    % Threshold difference image
    vid_threshold(:,:,frame) = imbinarize(vid_foreground(:,:,frame), 0.2);
    % Find border image
    % vid_edge(:,:,frame) = edge(vid_foreground(:,:,frame),'Canny');
       
    % Extract activity centers
    [x, y] = activityCenter(vid_foreground(:,:,frame));
    [x2, y2] = activityCenter(vid_threshold(:,:,frame));

    box_w = 75;
    box_h = 150;
    % Draw box calculated using difference from background
    pos = [(x - box_w/2) (y - box_h/2) box_w box_h];
    vid_track1(:,:,:,frame) = insertShape(im2uint8(vid_foreground(:,:,frame)), ...
        'Rectangle',pos, 'Color', 'red');
    vid_track1C(:,:,:,frame) = insertShape(im2uint8(vid(:,:,:,frame)), ...
        'Rectangle',pos, 'Color', 'red');
    
    % Draw box calculated using thresholded difference from background
    pos2 = [(x2 - box_w/2) (y2 - box_h/2) box_w box_h];
    vid_track2(:,:,:,frame) = insertShape(im2uint8(vid_threshold(:,:,frame)), ...
        'Rectangle', pos2, 'Color', 'cyan');
    vid_track2C(:,:,:,frame) = insertShape(im2uint8(vid(:,:,:,frame)), ...
        'Rectangle', pos2, 'Color', 'cyan');
end
