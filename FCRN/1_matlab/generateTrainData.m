%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate train file in HDF5 format
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Load resources and Paths

imagesPath='/media/lex/Lex/090303-F0009_780Frames/png/';
labelsPath='/media/lex/Lex/090303-F0009_780Frames/labels/';

filesInput=dir([labelsPath,'*.png']);
filesOutput=dir([labelsPath,'*.png']);

%% Parameters
sizeCuts=100; % square image
labelSize=100;
numImages=200*3;
spectralCuts=zeros(sizeCuts,sizeCuts,1,10*13*numImages);
spectralCutsOutput=zeros(labelSize,labelSize,1,10*13*numImages);
contDataSet=1;

% Get crops from dataset 64x64
for lenDataset=1:length(filesOutput)
    lenDataset
    % Load Image
    cutImage=imread([imagesPath,filesInput(lenDataset).name]);
    cutImage=imresize(cutImage,[700 1000]);
    
    
    cutImageLabel=sum(double(imread([labelsPath,filesInput(lenDataset).name])),3)/3;
    cutImageLabel=imresize(cutImageLabel,[700 1000]);
    
    for divRow=1:(size(cutImage,1)-mod(size(cutImage,1),sizeCuts))/sizeCuts
        
          for divCols=1:(size(cutImage,2)-mod(size(cutImage,2),sizeCuts))/sizeCuts             
              
              % Input image                               
              spectralCuts(:,:,:,contDataSet)=(cutImage(sizeCuts*(divRow-1)+1:sizeCuts*(divRow),...
                  sizeCuts*(divCols-1)+1:sizeCuts*(divCols),:));
              
              spectralCuts(:,:,:,contDataSet+1)=flipdim((cutImage(sizeCuts*(divRow-1)+1:sizeCuts*(divRow),...
                  sizeCuts*(divCols-1)+1:sizeCuts*(divCols),:)),2); 
              
              spectralCuts(:,:,:,contDataSet+2)=flipdim((cutImage(sizeCuts*(divRow-1)+1:sizeCuts*(divRow),...
                  sizeCuts*(divCols-1)+1:sizeCuts*(divCols),:)),2);   
             
             
              % Output image

              spectralCutsOutput(:,:,:,contDataSet)=(cutImageLabel(sizeCuts*(divRow-1)+1:sizeCuts*(divRow),...
                  sizeCuts*(divCols-1)+1:sizeCuts*(divCols),:));
              
              spectralCutsOutput(:,:,:,contDataSet+1)=flipdim((cutImageLabel(sizeCuts*(divRow-1)+1:sizeCuts*(divRow),...
                  sizeCuts*(divCols-1)+1:sizeCuts*(divCols),:)),2);  
              
              spectralCutsOutput(:,:,:,contDataSet+2)=flipdim((cutImageLabel(sizeCuts*(divRow-1)+1:sizeCuts*(divRow),...
                  sizeCuts*(divCols-1)+1:sizeCuts*(divCols),:)),2);              

              
              %labelImage = insertShape(cutImage,'Rectangle',[sizeCuts*(divCols-1)+1,sizeCuts*(divRow-1)+1,100,100],'Color','white','Opacity',1);
               % imshow(labelImage,[])
                %figure
%                (spectralCuts(:,:,1,contDataSet))
              %  pause
                 
              
                contDataSet=contDataSet+3;        
          end  
                
    end
    
    
end

spectralCuts=zscore(spectralCuts); 
% 
% %%Mix up dataset
% ix = randperm(contDataSet-1);
% spectralCuts =spectralCuts(:,:,:,ix);
% spectralCutsOutput =spectralCutsOutput(:,:,:,ix);
% % 
% 
% %% writing to HDF5
% display('writing to HDF5...')
% numberOfDataEpochs=1;
% shots=1;
% folder = 'Train';
% savepath =[ 'train_200',num2str(0),'.h5'];
% chunksz = 30;
% created_flag = false;
% totalct = 0;
% 
% for batchno = 1:floor((size(spectralCuts,4)*numberOfDataEpochs)/chunksz)
%     
%     last_read=(batchno-1)*chunksz;
%     batchdata = zscore(spectralCuts(:,:,1:shots,last_read+1:last_read+chunksz)); 
%     
%     if(batchno>floor((size(spectralCuts,4)*1)/chunksz))
%         last_read=(batchno-floor((size(spectralCuts,4)*1)/chunksz)-1)*chunksz;
%     end
%     
%     
%     batchlabs = (spectralCutsOutput(:,:,1,last_read+1:last_read+chunksz));           
%     startloc = struct('dat',[1,1,1,totalct+1], 'lab', [1,1,1,totalct+1]);
%     curr_dat_sz = store2hdf5(savepath, batchdata, batchlabs, ~created_flag, startloc, chunksz); 
%     created_flag = true;
%     totalct = curr_dat_sz(end);
%     
% %     %Visualization of labels
% %     subplot(2,3,1)
% %     size((spectralCutShuffled(:,:,1,1)))
% %     imshow((spectralCutShuffled(:,:,1,batchno)),[])
% %     title(['Banda 1'])
% %     subplot(2,3,2)
% %     imshow((spectralCutShuffled(:,:,2,batchno)),[])
% %     title(['Banda 2'])
% %     subplot(2,3,3)
% %     imshow((spectralCutShuffled(:,:,3,batchno)),[])
% %     title(['Banda 3'])
% %     subplot(2,3,4)
% %     imshow((spectralCutShuffled(:,:,4,batchno)),[])
% %     title(['Banda 4'])
% %     subplot(2,3,5)
% %     imshow(zscore(CASSImeasurements(:,:,1,batchno),[]))
% %     title(['CS measurements'])
% %     pause
%     
% end
% h5disp(savepath);