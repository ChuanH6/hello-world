e = 1/4;
T=[0,2];
n = 10;
for i = 1:n
   m = length(T)/2;
   l1 = zeros(1,m);%奇数点 interval 的左端点
   l2 = zeros(1,m);%偶数点 interval 的右端点
   for j = 1:m
       l1(j) = T(2*j-1);
       l2(j) = T(2*j);
       l = l2 - l1;
   end
   [val_max,num_max] = max(l);
   
   p = val_max/2 + l1(num_max);
   if p ==1
       p = p - val_max/100;
   end
   p
   if p<1
   num_Q = 0;
   for q = 0:4
       for j = 1:m
        if p+q*e> l1(j) && p+q*e<l2(j)
        num_Q=num_Q+1;
        else
        q1=q;
        end
       end
   end
   end
   if p>1
   num_Q = 0;
   for q = 0:4
       for j = 1:m
        if p-q*e> l1(j) && p-q*e<l2(j)
        num_Q=num_Q+1;
        else
        q2=q;
        end
       end
   end
   end
num_Q
   alpha = 2/3;%<1
   beta = 1/3;%<1/2
   if num_Q == 5
       temp = zeros(1,2*m*5);
       temp(1:2*m)=abs(T-ones(1,2*m)*p);
       temp(2*m+1:4*m)=abs(T-ones(1,2*m)*(p+e));
       temp(4*m+1:6*m)=abs(T-ones(1,2*m)*(p+2*e));
       temp(6*m+1:8*m)=abs(T-ones(1,2*m)*(p+3*e));
       temp(8*m+1:10*m)=abs(T-ones(1,2*m)*(p+4*e));
       lou = min(temp)*alpha;
       delta = e*beta;
       
       ita = min(lou,delta);
       temp1 = T(2*num_max:2*m);
       temp2 = T(1:2*num_max-1);
       T = zeros(1,2*m+2);
       T(1:2*num_max-1) = temp2;
       T(2*num_max:2*num_max+1) = [p-ita,p+ita];
       T(2*num_max+2:2*m+2) = temp1;
       ita
   end
   
   if num_Q <5
       if p < 1
           q0 = q1;
           [val_hole,num_hole] = min(abs(l2-ones(1,m)*(p+q0*e)));
           width_plug = alpha*min(l1(num_hole+1)-(p+q0*e),(p+q0*e)-l2(num_hole));
           temp = zeros(1,2*m*5);
           temp(1:2*m)=abs(T-ones(1,2*m)*p);
           temp(2*m+1:4*m)=abs(T-ones(1,2*m)*(p+e));
           temp(4*m+1:6*m)=abs(T-ones(1,2*m)*(p+2*e));
           temp(6*m+1:8*m)=abs(T-ones(1,2*m)*(p+3*e));
           temp(8*m+1:10*m)=abs(T-ones(1,2*m)*(p+4*e));
           lou = min(temp)*alpha;
           delta = e*beta;
           ita = min(lou,min(delta,width_plug));
           temp1 = T(2*num_max:2*num_hole);
           temp2 = T(1:2*num_max-1);
           temp3 = T(2*num_hole+1:2*m);
           T = zeros(1,2*m+4);
           T(1:2*num_max-1) = temp2;
           T(2*num_max:2*num_max+1) = [p-ita,p+ita];
           T(2*num_max+2:2*num_hole+2) = temp1;
           T(2*num_hole+3:2*num_hole+4) = [p+q0*e-width_plug,p+q0*e+width_plug];
           T(2*num_hole+5:2*m+4)=temp3;
           width_plug,ita
       end
       if p > 1
           q0 = q2;
           [val_hole,num_hole] = min(abs(l2-ones(1,m)*(p-q0*e)));
           width_plug = alpha*min(l1(num_hole+1)-(p-q0*e),(p-q0*e)-l2(num_hole));
           temp = zeros(1,2*m*5);
           temp(1:2*m)=abs(T-ones(1,2*m)*p);
           temp(2*m+1:4*m)=abs(T-ones(1,2*m)*(p-e));
           temp(4*m+1:6*m)=abs(T-ones(1,2*m)*(p-2*e));
           temp(6*m+1:8*m)=abs(T-ones(1,2*m)*(p-3*e));
           temp(8*m+1:10*m)=abs(T-ones(1,2*m)*(p-4*e));
           lou = min(temp)*alpha;
           delta = e*beta;
           ita = min(lou,min(delta,width_plug));
           temp1 = T(2*num_hole+1:2*num_max-1);
           temp2 = T(1:2*num_hole);
           temp3 = T(2*num_max:2*m);
           T = zeros(1,2*m+4);
           T(1:2*num_hole) = temp2;
           T(2*num_hole+1:2*num_hole+2) = [p-q0*e-width_plug,p-q0*e+width_plug];
           T(2*num_hole+3:2*num_max+1) = temp1;
           T(2*num_max+2:2*num_max+3) = [p-ita,p+ita];
           T(2*num_max+4:2*m+4)=temp3;
       end
   end
end
