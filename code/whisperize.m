[A fs] = wavread('prithvish_audio.wav');
A=A';
% Fixed window size
windowSize = 256;
halfSignal =1:windowSize;
Y2 = .5*(1-cos(2*pi*halfSignal*1/(windowSize)));
output2 = A(1:windowSize).*Y2;
hopSize = windowSize/2;
out=zeros(1,length(A));
for d=1 : length(A)/hopSize-1
    %In time domain
    wA = A((d-1)*hopSize+1: (d-1)*hopSize+windowSize);
    wX = Y2.*wA;
   
    %In frequency domain
    Wx=fft(wX);   
    r = abs(Wx);
    phi = 2*pi*rand(1,length(Wx));
    Wx = r.*exp(i*phi);
    
    YY = real(ifft(Wx));
    fft_x = ifft(Wx);
    out((d-1)*hopSize+1: (d-1)*hopSize+windowSize)=YY+out((d-1)*hopSize+1: (d-1)*hopSize+windowSize);
    
end
soundsc(out, fs);
%Normalizing
out = out ./ max(out);
soundsc(out)
%wavwrite(out, fs, 'whisperize.wav');