% Lab 8

clear all
load points.txt

figure(1);clf
plot(points(:,1),points(:,2),'bo');
hold on;
grid on;



%we are going to change size of A after elimination process
A = points;
Best_circ = [];
% run code for 1 circles and find most optimal one 
ncirc = 1;
while ncirc <=3
    check_if_better = 0;
    incr = 1;
while incr <= 30
    r=3;
    while r>2
        no_of_row = size(A);
        no_of_row = no_of_row(1);
        Nrow = randi([1,no_of_row],1,3);
      %matrix of points
      B = [A(Nrow(:),1), A(Nrow(:),2)] ;
      if Nrow(1)== Nrow(2) || Nrow(1)==Nrow(3) || Nrow(2)==Nrow(3)
          Nrow = [Nrow randi([1,no_of_row],1,1) ];
          B = [B; [A(Nrow(4),1) A(Nrow(4),2)]];
      end
        n = size(Nrow);
        n= n(2);
        [xc, yc, r] = find_param(B, n);
    end
    %plot_circle(xc, yc, r);
    
    % Here we analyze circle and make "vote"
    % clear Nrow, because we are going to go through all pts
    % so we don't repeat pts several times
    clear Nrow
    Nrow = [];
    no_of_row = size(A);
    no_of_row = no_of_row(1);
     for j = 1:1:no_of_row
         d = sqrt((xc - A(j,1))^2+(yc-A(j,2))^2);
         e = abs(d-r);
         if e< 0.075 %initial 0.05
             % appending elected point to the init list
             Nrow = [Nrow, j];
             %plot(A(j,1),A(j,2),'ro'); %for check
         end
     end
     length = size(Nrow);
    
     length= length(2);
     %check if better
     if check_if_better < length
         check_if_better = length;
         Nrow_best = Nrow;
         x_best = xc;
         y_best = yc;
         r_best = r;
     end
         
    incr = incr + 1; 
end

Best_circ = [Best_circ; [x_best y_best r_best]];
plot_circle(x_best, y_best, r_best);
% next step is to extract already used points, and
% run algorythm one more time.

no_of_row = size(A);
no_of_row = no_of_row(1);
% using this "C" we can keep track of prev. used Matrix with 
% avialible elements
C = A;
clear A;
A= [];
for i = 1:1:no_of_row
    if find(Nrow_best == i) >= 1
        continue;
    end
    A = [A; [C(i,1) C(i,2)]];
end

ncirc = ncirc + 1;
clear x_best y_best r_best Nrow_best length check_if_better; 
end
 


