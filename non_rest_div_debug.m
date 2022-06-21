x = input("Enter Dividend value : ");
y = input("Enter Divisor value : ");

n=log2(x);
			if x==0
				n=1;
			elseif n==floor(n)
				n=n+1;
			else
				n=ceil(n);
			end%if

m=log2(y);
			if y==0
				m=1;
			elseif m==floor(m)
				m=m+1;
			else
				m=ceil(m);
			end%if

Q = fi(x,0,n,0,'OverflowAction','Wrap');
M = fi(y,0,m,0);
A = fi(0,1,m+2,0,'OverflowAction','Wrap');  %not 100% sure why we need +2 here

fprintf('n  M ')
for c = 1:n
    fprintf(' ')
end
fprintf('A         Q\n')

for count = 1:n

    fprintf('%d  %s  %s  %s  cycle start\n',n-count+1,dec2bin(M,m+1),dec2bin(A,m+1),dec2bin(Q,n))

   if getmsb(A) == 1
    A = bitshift(A,1);

    if getmsb(Q) == 1
    A = bitset(A,1);
    end
    A = accumpos(A,M);
    Q = bitshift(Q,1);
    fprintf('   %s  %s  %s  shift left AQ & A = A + M (LSB of Q is not finalised)\n',dec2bin(M,m+1),dec2bin(A,m+1),dec2bin(Q,n))
   else
     A = bitshift(A,1);

    if getmsb(Q) == 1
     A = bitset(A,1);
    end
     Q = bitshift(Q,1);
     A = accumneg(A,M);
     fprintf('   %s  %s  %s  shift left AQ & A = A - M (LSB of Q is not finalised)\n',dec2bin(M,m+1),dec2bin(A,m+1),dec2bin(Q,n))
   end

   if getmsb(A) == 0
       Q = bitset(Q,1);
       fprintf('   %s  %s  %s  Q[0] = 1\n',dec2bin(M,m+1),dec2bin(A,m+1),dec2bin(Q,n))
   else
       fprintf('   %s  %s  %s  Q[0] = 0\n',dec2bin(M,m+1),dec2bin(A,m+1),dec2bin(Q,n))
   end
end

if getmsb(A) == 1
    A = accumpos(A,M);
    fprintf('   %s  %s  %s  A = A + M\n',dec2bin(M,m+1),dec2bin(A,m+1),dec2bin(Q,n))
end

fprintf('Quotient = %d\nRemainder = %d\n',Q,A);
