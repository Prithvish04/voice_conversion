%overlap and add method
clc
clear all
close all

x=[4 8 2 7 4 9 7 1 6 3 8 2 6 5 0 7];
l=length(x);
win=window(@hamming,4);
w=win'
k=1;
hop=2;
for i=1:hop:l-hop
    xn=x(i:i+3)
    yn(k:k+3)=xn.*w
    k=k+4;
end
l1=length(yn)
out=[];
out(1:hop)=yn(1:hop);
for i=hop+1:2*hop:l1-hop    
    for j=1:1:hop
    out1=yn(i+j-1)+yn(i+j-1+hop);
    out=[out,out1]
    end
end
out_last=yn(l1-hop+1:l1)
out=[out,out_last]
   
