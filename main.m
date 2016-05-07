clear all
%% params

which=8;
path='imgs';
%             1       2unorder          3           4             5
datasets={'ucsb4','family_house','glacier4','yellowstone2','GrandCanyon1',...
    'yellowstone5','yellowstone4','west_campus1','redrock','intersection',...
...%     6              7               8unorder            9      10
'GrandCanyon2'};
% 11  
%       1   2  3    4     5   6    7    8    9    10   11
focus=[595,400,2000,1000,1000,1000,1000,1000,2000,2000,2000];
Full360=[0,0,0,0,0,0,0,0,0,0,0];
unordered=[0,1,0,0,0,0,0,1,0,0,0];
%%
full=Full360(which);
f=focus(which);
run('lib/vlfeat-0.9.20/toolbox/vl_setup');
disp(['creating panorama for ',datasets{which}])
s=imageSet(fullfile(path,datasets{which}));
img=read(s,1);
imgs=zeros(size(img,1),size(img,2),size(img,3),s.Count,'like',img);
for i=1:s.Count
    imgs(:,:,:,i)=read(s,i);
end


if unordered(which)
    t=cputime;
    disp('ordering unordered images');
    imgs=imorder(imgs);
    disp([int2str(cputime-t),' sec']);
end


panorama=create( imgs, f, full);
imwrite(panorama,['./results/',datasets{which},'.jpg']);
if unordered(which)
    imwrite(panorama,['./results/',datasets{which},'from unordered.jpg']);
end