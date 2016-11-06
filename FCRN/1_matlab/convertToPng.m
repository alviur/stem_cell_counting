


%% Paths
% mainPath='/home/alviur/2_SUPSI/090303-F0009_780Frames/originalTiff/'
% savePath='/home/alviur/2_SUPSI/090303-F0009_780Frames/png/';

mainPath='/media/lex/Lex/090303-F0009_780Frames/originalTiff/'
savePath='/media/lex/Lex/090303-F0009_780Frames/png/';


names=dir([mainPath,'*.tif'])

%% Main Loop
for i=1:length(names)
   i
    image=imread([mainPath,names(i).name]);

    saveName=names(i).name;
    imwrite(imadjust(image),[savePath,saveName(1:end-1),'.png']);
   % pause 
    
end