function plot_circle(x, y, radius)
angle = linspace (0, 2*pi, 360);
xx = radius*cos(angle)+x;
yy = radius*sin(angle)+y;
plot (xx,yy);
axis('equal');
hold on;