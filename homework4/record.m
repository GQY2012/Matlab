recObj = audiorecorder;  % 默认：单声道 ，采样率fs = 8000bps , 量化精度nbits = 8bit 
recordblocking( recObj, 5) %录音5秒钟 
play(recObj);  %播放声音 
y = getaudiodata(recObj); 
plot(y);
%audiowrite('录音1_学号_2018-7-10.wav',y,8000);
%audiowrite('录音2_matlab_2018-7-10.wav',y,8000);
audiowrite('录音3_12345_2018-7-10.wav',y,8000);