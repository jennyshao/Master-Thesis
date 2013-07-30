clc;
clear;
tdir='/Users/ll/Dropbox/sjproject/project/v7/query30/training/';
vdir='/Users/ll/Dropbox/sjproject/project/v7/query30/validation/';
tlist = fullfile(tdir, 'tlist');
vlist = fullfile(vdir, 'vlist');


% This file is to verify Pengyang's code by directly calculate the
% distance formula. 
% We consider 15 y(i)s for i = 1:15, also we consider A and B composed one
% case
% we divide the data set into validate and training sets, training set is composed of fixed features.

%=============== training matrix ======================
tfid = fopen(tlist);
if (tfid==1)
   error('Cannot open text file...press CTRL-C to exit ');pause
end

tmatrix=[];
emptyQuery = {};
ti = 0;
while ~feof(tfid)
    tline = fgetl(tfid);
    tfile = fullfile(tdir, tline);   % Get one cwnd file
    
    str = regexprep(tline, '\..*\.query$', '');
    protocol = regexprep(str,'\d+.*$', '');   % get protocol
    
    str1 = regexprep(tline, '^.*\-', '');
    timeout = regexprep(str1, '\.query', '');
    timeout = eval(timeout);   % get timeout
   
    if(length(protocol) == 0 )
        return;
    end

    fid = fopen(tfile,'r');
    A = fscanf(fid, '%f;%f:%f,%f %f %f %f %f %f;%f, %f %f %f %f %f %f:%d');
    if isempty(A)
        emptyQuery = [emptyQuery; tline];
        continue;
    end
    grow1=[A(9) A(8) A(7) A(6) A(5) A(4)];
    grow2=[A(16) A(15) A(14) A(13) A(12) A(11)];
 
    y3 = {};
  
    for i = 1 : 15
        %y1(i) = int32(i^5*grow1(1)) + int32(i^4*grow1(2)) + int32(i^3*grow1(3)) + int32(i^2*grow1(4)) + int32(i^1*grow1(5)) + int32(i^0*grow1(6));
        y1(i) = int32(i^5*grow1(1) + i^4*grow1(2) + i^3*grow1(3) + i^2*grow1(4) + i^1*grow1(5) + i^0*grow1(6));
        %y2(i) = int32(i^5*grow2(1)) + int32(i^4*grow2(2)) + int32(i^3*grow2(3)) + int32(i^2*grow2(4)) + int32(i^1*grow2(5)) + int32(i^0*grow2(6));
        y2(i) = int32(i^5*grow2(1) + i^4*grow2(2) + i^3*grow2(3) + i^2*grow2(4) + i^1*grow2(5) + i^0*grow2(6)); 
    end
    
    y3 = {A(3) y1(1) y1(2) y1(3) y1(4) y1(5) y1(6) y1(7) y1(8) y1(9) y1(10) y1(11) y1(12) y1(13) y1(14) y1(15) A(10) y2(1) y2(2) y2(3) y2(4) y2(5) y2(6) y2(7) y2(8) y2(9) y2(10) y2(11) y2(12) y2(13) y2(14) y2(15) timeout protocol} ;
    tmatrix = [tmatrix; y3];       
    
    %y3 = [A(3) y1(1) y1(2) y1(3) y1(4) y1(5) y1(6) y1(7) y1(8) y1(9) y1(10) y1(11) y1(12) y1(13) y1(14) y1(15) y1(15) y1(16) y1(17) y1(18) y1(19) y1(20)];
    %y4 = [A(10) y2(1) y2(2) y2(3) y2(4) y2(5) y2(6) y2(7) y2(8) y2(9) y2(10) y2(11) y2(12) y2(13) y2(14) y2(15) y2(15) y2(16) y2(17) y2(18) y2(19) y2(20)] ;

    %y3 = [A(3) A(9) A(8) A(7) A(6) A(5) A(4) A(10) A(16) A(15) A(14) A(13) A(12) A(11)];
    %matrix = [matrix; y3];
    
    fclose(fid);
    ti = ti + 1;
end
fclose(tfid);

[tm,tn]=size(tmatrix);

%=============== validation matrix ======================
vfid = fopen(vlist);
if (vfid==1)
   error('Cannot open text file...press CTRL-C to exit ');pause
end

vi = 0;
vmatrix=[];
while ~feof(vfid)
    vline = fgetl(vfid);
    vfile = fullfile(vdir, vline);   % Get one cwnd file
    
    str = regexprep(vline, '\..*\.query$', '');
    protocol = regexprep(str,'\d+.*$', '');   % get protocol
    
    str1 = regexprep(vline, '^.*\-', '');
    timeout = regexprep(str1, '\.query', '');
    timeout = eval(timeout);   % get timeout
   
    if(length(protocol) == 0 )
        return;
    end

    fid = fopen(vfile,'r');
    A = fscanf(fid, '%f;%f:%f,%f %f %f %f %f %f;%f, %f %f %f %f %f %f:%d');
    if isempty(A)
        emptyQuery = [emptyQuery; vline];
        continue;
    end
    grow1=[A(9) A(8) A(7) A(6) A(5) A(4)];
    grow2=[A(16) A(15) A(14) A(13) A(12) A(11)];
 
    y3 = {};
  
    for i = 1 : 15
        %y1(i) = int32(i^5*grow1(1)) + int32(i^4*grow1(2)) + int32(i^3*grow1(3)) + int32(i^2*grow1(4)) + int32(i^1*grow1(5)) + int32(i^0*grow1(6));
        y1(i) = int32(i^5*grow1(1) + i^4*grow1(2) + i^3*grow1(3) + i^2*grow1(4) + i^1*grow1(5) + i^0*grow1(6));
        %y2(i) = int32(i^5*grow2(1)) + int32(i^4*grow2(2)) + int32(i^3*grow2(3)) + int32(i^2*grow2(4)) + int32(i^1*grow2(5)) + int32(i^0*grow2(6));
        y2(i) = int32(i^5*grow2(1) + i^4*grow2(2) + i^3*grow2(3) + i^2*grow2(4) + i^1*grow2(5) + i^0*grow2(6)); 
    end
    
    y3 = {A(3) y1(1) y1(2) y1(3) y1(4) y1(5) y1(6) y1(7) y1(8) y1(9) y1(10) y1(11) y1(12) y1(13) y1(14) y1(15) A(10) y2(1) y2(2) y2(3) y2(4) y2(5) y2(6) y2(7) y2(8) y2(9) y2(10) y2(11) y2(12) y2(13) y2(14) y2(15) timeout protocol} ;
    vmatrix = [vmatrix; y3];       
    
    fclose(fid);
    vi = vi + 1;
end
fclose(vfid);
[vm,vn]=size(vmatrix);

%================= start validate ==========================

fid = fopen('knn-fix-variable.txt','w+');

total_correct = 0;
total_cases = 0;

train_60 = {};
train_120 = {};
train_240 = {};
train_480 = {};

for i = 1 : tm
    if tmatrix{i,33}(1) == 60
        train_60 = [train_60; tmatrix(i,:)]; 
    elseif tmatrix{i,33}(1) == 120
        train_120 = [train_120; tmatrix(i,:)]; 
    elseif tmatrix{i,33}(1) == 240
        train_240 = [train_240; tmatrix(i,:)]; 
    elseif tmatrix{i,33}(1) == 480
        train_480 = [train_480; tmatrix(i,:)];
    end
end

mindistance ={};
for i = 1 : vm  
    d=[];
    pre_correct = 0;
    
    if vmatrix{i,33}(1) == 60
        candidate = train_60;
    elseif vmatrix{i,33}(1) == 120
        candidate = train_120;
    elseif vmatrix{i,33}(1) == 240
        candidate = train_240;
    elseif vmatrix{i,33}(1) == 480
        candidate = train_480;
    end
    [sz_candidate, k] = size(candidate);
        
    W=1000;
    v1 = vmatrix(i,:);

    for j = 1 : sz_candidate  % now starts calculate distance
        v2 = candidate(j,:);

        sum1 = 0;
        sum2 = 0;
        for s = 1 : 15
            a1 = double((v1{s+1} - v2{s+1})^2)/30;
            a2 = double((v1{s+17} - v2{s+17})^2)/30;
            sum1 = sum1 + a1;
            sum2 = sum2 + a2;
        end

        w1 = W^2 * (v1{1} - v2{1})^2;
        w2 = W^2 * (v1{17} - v2{17})^2;

        sum = w1 + w2 + sum1 + sum2;
        if sum <= 0
            d(j) = 0;
        else
            d(j) = sqrt(double(sum));
        end
    end

    [min_dist, min_idx] = min(d);
    mindistance = [mindistance; min_dist];
    if( strcmp(candidate{min_idx, 34}, vmatrix{i, 34}))
        total_correct = total_correct + 1;
    end
end

pa = total_correct/vm   %pa, prediction accuracy
fprintf(fid, 'prediction accuracy = %f\n', pa);
        
fclose(fid);
