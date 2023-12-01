function clocked
    
    radius=linspace(0,2*pi,1000);
    x1=9*cos(radius);
    y1=9*sin(radius);
    plot(x1,y1,'b','linewidth',3,'color','black') %Draws a thick black circle
    hold on
    axis off
    axis([-10 10 -10 10]) %Draws the figure with +/-10 for [Xmin Xmin Ymin Ymax]
    axis equal
    
    fontSize = 16;                                  % controls the font size of the numbers of the clock
    position = (pi/3:-2*pi/12:-3*pi/2)';           % sets the Theta for each number position
    radiusPos = 8;                                 % sets the Raduis for each number position
    numbers = (1:1:12)';
    allPositions = [radiusPos*cos(position) radiusPos*sin(position) numbers];
    text(allPositions(:,1),allPositions(:,2),num2str(allPositions(:,3)),...
    'horizontalAlignment','center','verticalAlignment','middle','FontSize',fontSize);

end  


    
    