clc
clear

A=[1 2 3 ; 4 5 6 ; 7 8 9];
B=[9 8 7 ; 6 5 4 ; 3 2 1];

A
inv_A=inv(A)
det_A=det(A)
trans_A=A'
A(1,3)
A(3,1)

A(1,1:3)

sum=A+B
product=A*B
element_by_element_multiplication=A.*B
element_by_element_division=A./B


