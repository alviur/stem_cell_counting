%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate image labels
%
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



savePath='/media/lex/Lex/090303-F0009_780Frames/labels/';
inputImageSize=[1040 1392];


for i=1:length(positiveInstances)
    
    labelImage=zeros(inputImageSize);
   i
    for j=1:size(positiveInstances(i).objectBoundingBoxes,1)
        
        xPos=positiveInstances(i).objectBoundingBoxes(j,1);
        yPos=positiveInstances(i).objectBoundingBoxes(j,2);
        circleSize=min(positiveInstances(i).objectBoundingBoxes(j,3)...
            ,positiveInstances(i).objectBoundingBoxes(j,4));
       
        labelImage = insertShape(labelImage,'FilledCircle',[xPos,yPos,8],'Color','white','Opacity',1);
        labelImage = imgaussfilt(labelImage, 0.4);
        labelImage = insertShape(labelImage,'FilledCircle',[xPos,yPos,5],'Color','white','Opacity',1);
        %labelImage =drawIntensityGaussian(labelImage,[xPos,yPos],2,25,100);
        
    end
    
    %imshow(labelImage,[])
    %figure
    %imshow(imread(positiveInstances(i).imageFilename))
    %pause
    % Save Image
    fileName=positiveInstances(i).imageFilename(1,48:end);
    imwrite(labelImage,[savePath,fileName])
    
end
