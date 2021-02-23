clearvars

printPictures = 0;

nSbj = 16;
matrixTypeSet = {'fullFC','maskedFC','fullEC','maskedEC'};

for iM = 1:length(matrixTypeSet)
    matrixType = matrixTypeSet{iM};
    
    load(['Service/SW_iEEG/Matrices/SW_iEEG_' matrixType '.mat']);
    tt = [];
    for iS = 1:nSbj
        tt = [tt; pre{iS}(:)];
        tt = [tt; sz{iS}(:)];
    end
    tt = unique(tt); q1 = quantile(tt,0.05); q2 = quantile(tt,0.95);
    
    fig = figure('pos',[10 10 1800 1100]);
    for iS = 1:8
        subplot(4,8,iS);
        imagesc(sz{iS}); caxis([q1 q2]);
        title([matrixType ' Sz ' mat2str(iS)]);
    end
    for iS = 1:8
        subplot(4,8,iS+8);
        imagesc(pre{iS}); caxis([q1 q2]);
        title([matrixType ' Pre ' mat2str(iS)]);
    end
    for iS = 9:16
        subplot(4,8,iS+8);
        imagesc(sz{iS}); caxis([q1 q2]);
        title([matrixType ' Sz ' mat2str(iS)]);
    end
    for iS = 9:16
        subplot(4,8,iS+16);
        imagesc(pre{iS}); caxis([q1 q2]);
        title([matrixType ' Pre ' mat2str(iS)]);
    end
    
    if printPictures
        saveFigure(fig,'Pictures/SW_iEEG/',['SW_iEEG_' matrixType],2);
    end
    
end



matrixTypeSet = {'fullFC','maskedFC'};

for iM = 1:length(matrixTypeSet)
    matrixType = matrixTypeSet{iM};
    
    load(['Service/SW_iEEG/Barcodes/SW_barcodes_' matrixType '.mat']);
    
    fig = figure('pos',[10 10 1200 500]);
    hold on;
    for iS = 1:nSbj
        scatter(barcodes0{iS}(:,1)+iS,barcodes0{iS}(:,2),'r','LineWidth',1);
        scatter(iS,mean(barcodes0{iS}(:,2)),'kx','LineWidth',2.5);
        scatter(barcodes0{iS+nSbj}(:,1)+iS+nSbj,barcodes0{iS+nSbj}(:,2),'b','LineWidth',1);
        scatter(iS+nSbj,mean(barcodes0{iS+nSbj}(:,2)),'kx','LineWidth',2.5);
    end
    title([matrixType ' PD dim0']);
    xlabel('Subject');
    ylabel('Component Death');
    legend({'Sz','Pre'},'location','southeast');
    
    set(findall(gcf,'Type','text','-depth',inf),'FontName','times','FontSize',18)
    set(findall(gcf,'Type','axes','-depth',inf),'FontName','times','FontSize',18)
        
    if printPictures
        saveFigure(fig,'Pictures/SW_iEEG/',['SW_iEEG_PD0_' matrixType],2);
    end
     
end



for iM = 1:length(matrixTypeSet)
    matrixType = matrixTypeSet{iM};
    
    load(['Service/SW_iEEG/Barcodes/SW_barcodes_' matrixType '.mat']);
    
    fig = figure('pos',[10 10 1800 1100]);
    for iS = 1:8
        subplot(4,8,iS);
        scatter(barcodes1{iS}(:,1),barcodes1{iS}(:,2),'r','LineWidth',2); 
        axis([0.4 1 0.4 1]);
        title([matrixType ' Sz ' mat2str(iS)]);
    end
    for iS = 9:16
        subplot(4,8,iS);
        scatter(barcodes1{iS+8}(:,1),barcodes1{iS+8}(:,2),'b','LineWidth',2); 
        axis([0.4 1 0.4 1]);
        title([matrixType ' Pre ' mat2str(iS-8)]);
    end
    for iS = 17:24
        subplot(4,8,iS);
        scatter(barcodes1{iS-8}(:,1),barcodes1{iS-8}(:,2),'r','LineWidth',2); 
        axis([0.4 1 0.4 1]);        
        title([matrixType ' Sz ' mat2str(iS-8)]);
    end
    for iS = 25:32
        subplot(4,8,iS);
        scatter(barcodes1{iS}(:,1),barcodes1{iS}(:,2),'b','LineWidth',2); 
        axis([0.4 1 0.4 1]);
        title([matrixType ' Pre ' mat2str(iS-nSbj)]);
    end
    
    if printPictures
        saveFigure(fig,'Pictures/SW_iEEG/',['SW_iEEG_PD1_' matrixType],2);
    end
     
end













