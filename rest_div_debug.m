x = input("Enter Dividend value : ");
y = input("Enter Divisor value  : ");

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

if m+1 <= 8
len = 8;
elseif m+1 <=16
    len = 16;
elseif m+1 <=32
    len = 32;
else
    len = 64;
end

len2 = max(n,len);
space = floor(log10(n+1));

Q = fi(x,0,n,0,'OverflowAction','Wrap');
M = fi(y,0,m,0);
A = fi(0,0,m+1,0,'OverflowAction','Wrap');

for c = 1:(2*len)+len2+space+7
    fprintf('-')
end

fprintf('\n')

fprintf('n  ')
if space > 0
       for c = 1:space
           fprintf(' ')
       end
end

fprintf('M (%d)',m)
for c = 1:len-3
    fprintf(' ')
end
fprintf('A (%d)',m+1)
for c = 1:len-3
    fprintf(' ')
end
fprintf('Q (%d)\n',n)

for c = 1:(2*len)+len2+space+7
    fprintf('-')
end

fprintf('\n')

for count = 1:n
   space2 = floor(log10(n-count+1));
   fprintf('%d  ',n-count+1)
   if space - space2 ~= 0
       for c = 1:space-space2
       fprintf(' ')
       end
   end
   fprintf('%s  %s  %s  cycle start\n',dec2bin(M,len),dec2bin(A,len),dec2bin(Q,len2))
   
   A = bitshift(A,1);

   if getmsb(Q) == 1
    A = bitset(A,1);
   end

   Q = bitshift(Q,1);

   if space > 0
       for c = 1:space
           fprintf(' ')
       end
   end
   fprintf('   %s  %s  %s  shift left AQ (LSB of Q is not finalised)\n',dec2bin(M,len),dec2bin(A,len),dec2bin(Q,len2))

   A = accumneg(A,M);

   if space > 0
       for c = 1:space
           fprintf(' ')
       end
   end
   fprintf('   %s  %s  %s  A = A - M\n',dec2bin(M,len),dec2bin(A,len),dec2bin(Q,len2))

   if getmsb(A)==0
       Q = bitset(Q,1);
       if space > 0
          for c = 1:space
              fprintf(' ')
          end
       end
       fprintf('   %s  %s  %s  Q[0] = 1\n',dec2bin(M,len),dec2bin(A,len),dec2bin(Q,len2))
   else
       A = accumpos(A,M);
       if space > 0
          for c = 1:space
              fprintf(' ')
          end
       end
       fprintf('   %s  %s  %s  Q[0] = 0 & Restore A\n',dec2bin(M,len),dec2bin(A,len),dec2bin(Q,len2))
   end
end

for c = 1:(2*len)+len2+space+7
    fprintf('-')
end

fprintf('\n')

fprintf('Quotient  = %d\nRemainder = %d\n',Q,A);

for c = 1:(2*len)+len2+space+7
    fprintf('-')
end

fprintf('\n')
