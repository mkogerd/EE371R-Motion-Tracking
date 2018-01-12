%%  Detect motion against a background using frame differencing
% Preallocating for tracked grayscale video
vid_track = uint8(zeros(vidHeight, vidWidth, 3, numberOfFrames));
% Preallocating for tracked grayscale video
vid_trackC = uint8(zeros(vidHeight, vidWidth, 3, numberOfFrames));

% Preallocating for guassian filtered video
vid_track2 = uint8(zeros(vidHeight, vidWidth, 3, numberOfFrames));
vid_track2C = uint8(zeros(vidHeight, vidWidth, 3, numberOfFrames));

% Preallocating for median filtered video
vid_track3 = uint8(zeros(vidHeight, vidWidth, 3, numberOfFrames));
vid_track3C = uint8(zeros(vidHeight, vidWidth, 3, numberOfFrames));

% Preallocating for thresholded video
vid_track4 = uint8(zeros(vidHeight, vidWidth, 3, numberOfFrames));
vid_track4C = uint8(zeros(vidHeight, vidWidth, 3, numberOfFrames));

for frame = 1:405
    % Find activity centerpoint    
    thisFrame = im2uint8(vid_diff(:,:,frame));
    [x, y] = activityCenter(thisFrame);
    
    % Guassian filtered image difference
    thisFrame2 = imgaussfilt(thisFrame, 3);
    [x2, y2] = activityCenter(thisFrame2);
    
    % Median filtered image difference
    thisFrame3 = medfilt2(thisFrame, [6 3]);
    [x3, y3] = activityCenter(thisFrame3);
    
    % Threshold difference image
    thisFrame4 = im2uint8(imbinarize(thisFrame, 0.2));
    [x4, y4] = activityCenter(thisFrame4);

    
    box_w = 75;
    box_h = 150;
    % Unfiltered difference image
    pos = [(x - box_w/2) (y - box_h/2) box_w box_h];
    vid_track(:,:,:,frame) = insertShape(thisFrame,'Rectangle',pos, 'Color', 'yellow');
    vid_trackC(:,:,:,frame) = insertShape(im2uint8(vid(:,:,:,frame)),'Rectangle',pos, 'Color', 'yellow');
    
    % Guassian filtered difference image
    pos2 = [(x2 - box_w/2) (y2 - box_h/2) box_w box_h];
    vid_track2(:,:,:,frame) = insertShape(thisFrame2,'Rectangle',pos2, 'Color', 'r');
    vid_track2C(:,:,:,frame) = insertShape(im2uint8(vid(:,:,:,frame)),'Rectangle',pos2, 'Color', 'r');
    
    % Median filtered difference image
    pos3 = [(x3 - box_w/2) (y3 - box_h/2) box_w box_h];
    vid_track3(:,:,:,frame) = insertShape(thisFrame3,'Rectangle',pos3, 'Color', 'blue');
    vid_track3C(:,:,:,frame) = insertShape(im2uint8(vid(:,:,:,frame)),'Rectangle',pos3, 'Color', 'blue');
    
    % Thresholded difference image
    pos4 = [(x4 - box_w/2) (y4 - box_h/2) box_w box_h];
    vid_track4(:,:,:,frame) = insertShape(thisFrame4,'Rectangle',pos4, 'Color', 'green');
    vid_track4C(:,:,:,frame) = insertShape(im2uint8(vid(:,:,:,frame)),'Rectangle',pos4, 'Color', 'green');

end
