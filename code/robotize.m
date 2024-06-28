clc
clear all
close all
[A fs] = wavread('prithvish_audio.wav');
windowSize = 2048;
A=A';
% Fixed window size = 2048
windowSize = 256;
halfSignal =1:windowSize;
%define window functino
%Y2 = .5*(1-cos(2*pi*halfSignal*1/(2048)));
Y2=window(@hamming,windowSize);
Y2=Y2';
%initialization
output2 = A(1:windowSize).*Y2;
hopSize = windowSize/2;
out=zeros(1,length(A));
for d=1 : length(A)/hopSize-1
    %In time domain
    wA = A((d-1)*hopSize+1: (d-1)*hopSize+windowSize);
    wX = Y2.*wA;
    %wX = wA;
    specSegment = wX;
    %In frequency domain
    Wx=fft(wX);
    abs(Wx);
    %take ifft of absolute value of FFT only
    YY = ifft(abs(Wx));
    %overlap add to reconstruct the audio signal
    out((d-1)*hopSize+1: (d-1)*hopSize+windowSize)=YY+out((d-1)*hopSize+1: (d-1)*hopSize+windowSize);
end
%soundsc(out, 44100);
%normalize
out = out ./ max(out);
soundsc(out)
%wavwrite(out, 44100, 'robotize.wav');