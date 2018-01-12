myVideo = VideoWriter('vidnew_smooth.mp4');
myVideo.FrameRate = frameRate;  % Default 30
myVideo.Quality = 100;    % Default 75

open(myVideo);
writeVideo(myVideo, vid_new);
close(myVideo);