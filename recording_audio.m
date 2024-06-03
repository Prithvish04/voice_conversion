recobj=audiorecorder;
disp('Start');
recordblocking(recobj,5);
disp('Stop');
%play(recobj);
recording=getaudiodata(recobj);
plot(recording);
wavwrite(recording,8000,'shraddha_audio.wav')