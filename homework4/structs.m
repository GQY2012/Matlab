close all;
clear all;
[y1,fs1] = audioread('Â¼Òô1_Ñ§ºÅ_2018-7-10.wav');
[y2,fs2] = audioread('Â¼Òô2_matlab_2018-7-10.wav');
[y3,fs3] = audioread('Â¼Òô3_12345_2018-7-10.wav');
record.name = '¹ùÇïÑó';
record.contents = y1;
record.fs = fs1;
record.time = '2018-7-10';

record(2).name = '¹ùÇïÑó';
record(2).contents = y2;
record(2).fs = fs2;
record(2).time = '2018-7-10';

record(3).name = '¹ùÇïÑó';
record(3).contents = y3;
record(3).fs = fs3;
record(3).time = '2018-7-10';

close all;