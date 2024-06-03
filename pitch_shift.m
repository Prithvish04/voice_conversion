function out_signal=pitch_shift(pit_ratio,source)
n1 = 256;
%pitch shift ratio
%pit_ratio = .8;
WLen = 2048;
w1 = hanning(WLen);
w2 = w1;
%[in_signal, FS] = wavread('prithvish_audio.wav');
%soundsc(in_signal, FS);
in_signal=source;
L = length(in_signal);
%in_signal = [zeros(WLen, 1);in_signal;zeros(WLen-mod(L, n1),1)] / max(abs(in_signal));
out_signal = zeros(length(in_signal), 1);
grain = zeros(WLen, 1);
ll = WLen/2;
omega = 2*pi*n1*[0:ll-1]'/WLen;
phi0 = zeros(ll, 1);
r0 = zeros(ll, 1);
psi = zeros(ll, 1);
res = zeros(n1, 1);
pin = 0;
pout = 0;
pend = length(in_signal)-WLen;
while pin<pend
     %multiply audio segment with window function
     grain = in_signal(pin+1:pin+WLen).*w1;
     %compute magnitude and phase of FFT
     fc = fft(fftshift(grain));
     f = fc(1:ll);
     r = abs(f);
     phi = angle(f);
     %unwrap phase to get phase increment
     delta_phi = omega + princarg(phi - phi0-omega);
     delta_r = (r-r0)/n1;
     %multiply the phase with the pitch ratio factor
     delta_psi = pit_ratio*delta_phi/n1;
    
     %reconstruct the audio signal
     for k = 1:n1
         r0 = r0 + delta_r;
         psi = psi + delta_psi;
         res(k) = r0'*cos(psi);
     end
    
     phi0 = phi;
     r0 = r;
     psi = princarg(psi);
    
     out_signal(pout+1:pout+n1) = out_signal(pout+1:pout+n1)+res;
     pin = pin + n1;
     pout = pout + n1;
  
end
%Normalize output signal
%out_signal = out_signal(WLen/2 + n1 + 1:length(out_signal))/max(abs(out_signal));
%soundsc(out_signal, FS);
out_signal = out_signal./max(out_signal);
%wavwrite(out_signal, FS, 'pitch_shift.wav');
end