clc
clear all
close all
%source voice
[source, FS] = wavread('daksh_audio.wav');
%target voice
[target, FS] = wavread('prithvish_audio.wav');
%source pitch estimation
sourcePitch = pitch_estimation(source,FS)
%target pitch estimation
targetPitch= pitch_estimation(target,FS)
%pitch shift ratio
pit_ratio = targetPitch/sourcePitch
out_signal = pitch_shift(pit_ratio,source);
soundsc(out_signal)