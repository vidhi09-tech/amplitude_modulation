clc;close all;clear all;

fs=10000;%sampling frequency
 
 
N=1024;%number of samples
 
AM=1;
 
fc=input('Input the carrier frequency :');
fm=input('Input the amplitude frequency :');
t=0:1/fs:(2/fm)-1/fs;
AC=input('Input amplitude of carrier wave :');
m=AM/AC;
c=cos(2*pi*fc*t);%carrier signal
x=cos(2*pi*fm*t);%modulation signal
 
y=((1+m*x).*c);%modulated signal
 
%Spectrum of modulated signal
 
Y=fft(y,N);
f=[((-(N-1)/2)*fs)/N:fs/N:(((N-1)/2)*fs)/N];%frequency axis

 
% % Demodulation (envelope detection)
for i=1:length(y)
    if y(i)<0
        y(i)=0;
    end
end
[b,a]=butter(5,2*pi*fm/fs);
out_demod=filter(b,a,y);

figure(1)
subplot(311)
plot(t,y) ;
title('Amplitude Modulated Signal');
xlabel('Time==>');
ylabel('Amplitude==>');
subplot(312)
plot(f,fftshift(abs(Y))) ;
title('AM Signal Spectrum');
xlabel('Frequency axis');
ylabel('Amplitude');
subplot(313)
plot(t,out_demod);
title('AM DEMODULATED');

