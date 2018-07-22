% script to read and plot centreline velocity data from excel
% 
%
% % load data from excel
dist = xlsread('centreLineData.xlsx','dist');
vel = xlsread('centreLineData.xlsx','vel');
date1 = xlsread('centreLineData.xlsx','startDate');
date2 = xlsread('centreLineData.xlsx','endDate');
% 
% % convert dates to matlab datenumber
for i = 1:length(date1)
     dummy = date1(i);
     year1 = dummy{1:4};
     month1 = dummy{5:6};
     day1 = dummy{7:8};
     date1(i) = datenum(year1.month1,day1);
 end
% 
% % find where new date starts
 idx = find(dist==0);
 diffzero = diff(idx);
 maxdiff = max(diffzero);
% 
% % pre-allocate arrays for efficiency
 distUse = (zeros(1000,79)+1)*-9999;
 velUse = (zeros(1000,79)+1)*-9999;
% 
% % extract data: each column is one velocity map
 for i = 1:78
     l = (idx(i+1)-1)-idx(i)+1;
     distUse(1:l,i) = dist(idx(i):idx(i+1)-1);
     velUse(1:l,i) = vel(idx(i):idx(i+1)-1);
 end
%
%
% % alternate method
% velUse = xlsread('S1CSV.csv');
% velUse(:,1) = [];
% dist = 0:100:22000;
% time = 1:78;

% [x,y] = meshgrid(time,dist);
% figure; 
% set(gcf,'color',[0.5 0.5 0.5]);
% axes
% set(gca,'color',[0.5 0.5 0.5]);
% pcolor(y,x,velUse);
% %shading interp
% caxis([0 1.5])



% set no data to NaN
distUse(distUse==-9999) = NaN;
% velUse(velUse==-9999) = -.000001;

% % plot
% cmap = colormap(jet(79));
% for i = 1:79
%     hold on
%     plot(distUse(:,i)/1000,velUse(:,i),'linewidth',2,'color',cmap(i,:))
%     xlabel('Distance from terminus(ish) (km)')
%     ylabel('Velocity (m d^-^1)')
% end

% make colormap
c = colormap(jet);

%
% % plot as 'Hovmoller' using imagesc 
data = load('CentreLineData.csv');
imagesc(data'); axis xy; caxis([0 1]);
colormap jet;
set(gca,'xtick',0:50:200,'xticklabel',0:5:20);
xlabel('Distance (km)'); ylabel('Date')
c=colorbar;
ylabel(c,'Speed (m/day)')
set(gif,'color','w')
%
%
%
% % alternate plot as 'Hovmoller'
%velUse = xlsread('PointCenterLineDataCSV.csv');
%velUse(:,1) = [];
%velUse(velUse==-9999) = -.000001;
%figure; 
%set(gcf,'color',[0.5 0.5 0.5]);
%axes
%set(gca,'color',[0.5 0.5 0.5]);
%imagesc(flipud(velUse'))
%colormap(jet)
%caxis([0,1.5])
%xlabel('Distance')
%ylabel('Date')
%cb = colorbar;
%ylabel(cb,'Velocity (m d^-^1)')
%set(gca,'fontsize',14)
%set(gcf,'color','w');
%axes
%set(gca,'color','w');

