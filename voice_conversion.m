clc
clear all
close all

fs=8000; 

% %recording the audio
% recobj=audiorecorder;
% disp('Start');
% recordblocking(recobj,2);
% disp('Stop');
% %play(recobj);
% rec_source=getaudiodata(recobj);
% wavwrite(rec_source,source);
[rec,fs]=wavread('prithvish_audio.wav');
subplot(6,1,1);
plot(rec);

%normalised_rec=rec./(1.01*abs(max(rec)));
l=length(rec);
N=160;
s=l-N;
y1=rec(s+1:l);

w=window(@hamming,N);
yw=y1.*w;

subplot(6,1,2);
plot(yw);

yf=fft(yw);
subplot(6,1,3);
plot(abs(yf));

lyf=log(abs(yf));
subplot(6,1,4);
plot(lyf);

yc=ifft(lyf)
subplot(6,1,5);
plot(yc);

%liftering
yc1=yc(1:length(yc)/2);
L=zeros(length(yc1),1);
L(15:length(yc1))=1;
y4=real(yc1.*L);
subplot(6,1,6);
plot(y4);

%pitch estimation
[y_val,y_loc]=max(y4)
pitch_period=y_loc
pitch_frequency=(1/pitch_period)*fs
