clc
clear

%{
x=linspace(0,4*pi,300)
y1=sin(x);
y2=cos(x);
y3=sin(x)+cos(x);
plot(x,y1,x,y2,x,y3)


 multiplying vectors/strings require .* or ./ for element-by-element
 operations
 y1=sin(x);
 y2=exp(-x/3);
 y=y1.*y2;
 plot(x,y)
 

   OPERATORS

   == "is this equal to ... "

   more found on lecture slides


   FLOW CONTROL

   if, for, while

%}


function [y]=addtwo(A,B);

if size(A)==size(b){
    y=A+B
    }
else{
    print('sizes are not equal')
    }

end

    
   







