function pitch=pitch_estimation(signal,FS)
% taking 160 samples of the audio
% normalised_rec=rec./(1.01*abs(max(rec)));
%[signal,fs]=wavread('prithvish_audio.wav');
rec=signal;
l=length(rec);
N=160;
interval=(l*2/N)-1;
% windowing
w=window(@hamming,N);

% liftering%
L=zeros(N/2,1);
L(15:N/2)=1;

% y
% y1=[];
% yw1=[];
% yf1=[];
% yc1=[];
% yl1=[];
% ycp1=[];
% yc1=[];
% yo1=[];
% y_val1=[];
 y_loc1=[];

for i=1:interval
    y=rec(1+80*(i-1):160+80*(i-1));
    %y1=[y1 y];
    yw=y.*w;
    %yw1=[yw1 yw];
    yf=fft(yw);
    %yf1=[yf1 yf];
    yl=log(abs(yf));
    %yl1=[yl1 yl];
    yc=ifft(yl);
    %yc1=[yc1 yc];
    ycp=yc(1:length(yc)/2);
    %ycp1=[ycp1 ycp];
    yo=real(ycp.*L);
    %yo1=[yo1 yo];
    [y_val,y_loc]=max(abs(yo));
    %y_val1=[y_val1 y_val];
    y_loc1=[y_loc1 y_loc];
    pitch_period=y_loc1;
    pitch_frequency=(1./pitch_period)*FS;
end
% x=[];
% for i=1:interval
%     if pitch_frequency(i)==FS
%         pitch_frequency(i)=0;
%         x=[x,pitch_frequency(i)];
%     else
%         x=[x,pitch_frequency(i)];
%     end
% end
% pitch_frequency
% t=[];
% %plotting
% for i=1:length(pitch_frequency)
% t=[t,i];
% end
% plot(t,smooth(pitch_frequency))
% pitch=max(pitch_frequency);

y=medfilt1(pitch_frequency)
x=medfilt1(y')
pitch=mean(x)



