function clocked
clear sound
%[y,Fs] = audioread('musictrack.mp3');
%sound(y,Fs);
%image addition

set(gcf,'color','black');
fig = gcf;

img  = imread('superStar.png');

min_x = -1;
max_x = 1;
min_y = -1;
max_y = 1;


% Flip the image upside down before showing it
I = imagesc([min_x max_x], [min_y max_y], flipud(img));
IoCData = I.CData;
Igray = rgb2gray(I.CData);
Alpha = ones(size(Igray));
Alpha(Igray==0) = 0;
Alpha(60:140,80:170) = 1;
I.AlphaData = Alpha; 
% NOTE: if your image is RGB, you should use flipdim(img, 1) instead of flipud.
 
hold on;
% plot(x,y,'b-*','linewidth',1.5);
 
% set the y-axis back to normal.
set(gca,'ydir','normal','color','black');
axis off;

%     angles = 0:2*pi;
    angles = 0:0.001:2*pi;
    r=1.5;
    xCoord=0;
    yCoord=0;
    x = r*cos(angles) + xCoord;
    y = r*sin(angles) + yCoord;
    plot(x,y,'LineStyle','-','LineWidth',5.0,'Color','b');
    plot(x,y,'LineStyle','--','LineWidth',1.0,'Color','g');
    hold on;
%ticks
     tickLength = 0.1;

    
    line('XData', [0 0], 'YData', [ 1 1 - tickLength],'Color','w','LineWidth', 2);
    line('XData', [0 0], 'YData', [-1 tickLength - 1],'Color','w','LineWidth', 2);
    line('YData', [0 0], 'XData', [ 1 1 - tickLength],'Color','w','LineWidth', 2);
    line('YData', [0 0], 'XData', [-1 tickLength - 1],'Color','w','LineWidth', 2);
    viscircles([0 0], 1, 'EdgeColor', 'k');

    
    text(0, 1 - tickLength, '12', 'HorizontalAlignment', 'center', 'VerticalAlignment', 'cap','FontWeight','bold','FontAngle','italic','Fontsize',18,'FontName','Algerian','color','red');
    text(0, tickLength - 1, '6' , 'HorizontalAlignment', 'center', 'VerticalAlignment', 'baseline','FontWeight','bold','FontAngle','italic','Fontsize',18,'FontName','Algerian','color','yellow');
    text(1 - tickLength, 0, '3', 'HorizontalAlignment', 'right' , 'VerticalAlignment', 'middle','FontWeight','bold','FontAngle','italic','Fontsize',18,'FontName','Algerian' ,'color','yellow' );
    text(tickLength - 1, 0, '9' , 'HorizontalAlignment', 'left'  , 'VerticalAlignment', 'middle','FontWeight','bold','FontAngle','italic','Fontsize',18,'FontName','Algerian',  'color','yellow');
    text(0.75,tickLength-1, 'Mario' , 'HorizontalAlignment', 'left'  , 'VerticalAlignment', 'middle','FontWeight','bold','Fontsize',18,'FontName','Courier',  'color','red');
    text(-1,tickLength-1, 'Luigi' , 'HorizontalAlignment', 'left'  , 'VerticalAlignment', 'middle','FontWeight','bold','Fontsize',18,'FontName','Courier',  'color','g');

    hourLength = 0.6;
    minLength  = 0.75;
    secLength  = 0.95;
    hourLine   = line('XData', [0 0], 'YData', [0, hourLength], 'LineStyle', '-','Color','w', 'LineWidth',5.0,'Marker','o','MarkerSize',6.0 );
    minLine    = line('XData', [0 0], 'YData', [0, minLength ], 'LineStyle', '-.','Color','g', 'LineWidth',3.0, 'Marker','d','MarkerSize',6.0 );
    secLine    = line('XData', [0 0], 'YData', [0, secLength ], 'LineStyle', '--','Color','r','Marker','*','MarkerSize',6.0 );
    
    hold on;
    
    pause(1)
    secTimer = timer('ExecutionMode', 'fixedRate', 'Period', 1,'TimerFcn',@(~,~) updateClock());
%     secTimer.TimerFcn = @(~,~) updateClock();
    start(secTimer);
    
    fig.CloseRequestFcn = @closefcn;
   
    function updateClock()
            c         =  fix(clock());
            secAngle  =  c(6)/30*pi;
            minAngle  = (c(5) + c(6)/60)/30*pi;
            hourAngle = (c(4) + c(5)/60)/6 *pi;
            set(hourLine, 'XData', [0 sin(hourAngle)*hourLength], 'YData', [0 cos(hourAngle)*hourLength]);
            set(minLine , 'XData', [0 sin(minAngle )*minLength ], 'YData', [0 cos(minAngle )*minLength ]);
            set(secLine , 'XData', [0 sin(secAngle )*secLength ], 'YData', [0 cos(secAngle )*secLength ]);
            disp(size(I.CData));
            if(abs(secAngle) > 0.001)
                I.CData = imrotate(I.CData,secAngle);
                I.AlphaData = imrotate(I.AlphaData,secAngle);
            else
                I.CData = IoCData;
                I.AlphaData = Alpha;
            end
                
    end

    function closefcn(a,b)
        clear sound
        stop(secTimer);
        pause(1);
        delete(secTimer);
        h = gcf;
        delete(h);
    end
end  


    
    