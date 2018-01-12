clear();

% Read in movie
vidObj = VideoReader( 'video.mp4' );

% Extract video info
vidHeight = vidObj.Height;
vidWidth = vidObj.Width;
numberOfFrames = vidObj.NumberOfFrames;
frameRate = vidObj.FrameRate;

% Create a movie structure array
s = struct('cdata',zeros(vidHeight,vidWidth,3,'uint8'), 'colormap',[]);

% Extract video in row x col x rgb x frame format
vid = uint8(zeros(vidHeight, vidWidth, 3, numberOfFrames));
for frame = 1:numberOfFrames
    vid(:,:,:,frame) = read(vidObj, frame);
end
 
% Extract various image transforms
% Not as fast as doing it all in 1 loop, but much more readable
vid_gray = vid_rgb2gray(vid);
% vid_filt = vid_gaussfilter(vid_gray, 7, 1);
% vid_edge = vid_edgefilter(vid_filt);
vid_diff = diff(vid_gray, 1, 3);
