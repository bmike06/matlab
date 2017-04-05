function run4Test ()


%global parameter
dataFolder = 'C:\kitti_Database\2011_09_26\2011_09_26_drive_0048_sync\';
dataFolder = 'C:\kitti_Database\simuTest\';
listLidarFileBin=dir(fullfile(strcat(dataFolder,'/velodyne_points/data/'),'*.bin'))
listLidarFileTxt=dir(fullfile(strcat(dataFolder,'/velodyne_points/data/'),'*.txt'))

listBin = size(listLidarFileBin);
listBin = listBin(1,1);

if listBin==0
   listLidarFile= listLidarFileTxt
else 
   listLidarFile= listLidarFileBin
end
nbFrame = size(listLidarFile);
nbFrame = nbFrame(1,1);

%oxtsFile = strcat(dataFolder,'oxts/data/',fileName,'.txt');
trackletsFile = strcat(dataFolder,'tracklet_labels.xml');
%velo2cam = strcat(dataFolder,'calib_velo_to_cam.txt');
%cam2cam = strcat(dataFolder,'calib_cam_to_cam.txt');

%load data
%tracklets = readTracklets(trackletsFile);
fullLidarData=cell(nbFrame,1);
   
for i=1:nbFrame
    %fileName=sprintf('%.10d\n',(i-1));
    %fileName=listLidarFile(i).name
    fileName=sprintf('%d',i);
    fileName=strcat('frame_',fileName,'.txt');
    lidarFile = strcat(dataFolder,'velodyne_points/data/',fileName)  
    fullLidarData{i}=loadLidarData(listBin,lidarFile);
end
%oxdsData = loadOxts(oxtsFile);
%figure
fclose('all')
    f = figure();  
    whitebg(f,'k');
    view([137 32]);
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    pbaspect([10 3 1]);
    grid on;
    grid minor;
    hold on; 
   
    i=1;
    while(1)
        currentFrame = i - 1;
        origin = plot3(0,0,0,'.','MarkerSize',25,'Color',[1 0 0]);
        lidarGraph =  plotLidar(fullLidarData{i},[0 0 0],[1 1 1]);
        %objectGraph = plotTracklets(tracklets,currentFrame)
        title(currentFrame);    
        pause(1);
        delete(origin)
        delete(lidarGraph)
        %for z = 1 : length(objectGraph)
        %    delete(objectGraph{z});
        %end
        i=i+1
        if i>nbFrame-1
            i = 1;
        end
    end
