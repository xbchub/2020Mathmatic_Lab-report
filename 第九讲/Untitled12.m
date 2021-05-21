    %let n be the number of cities that must be visited
  n=17;

%let numCS be the initial number of candidate solutions
numCS=128;

%Will first initialise the population of random candidate solutions
for i=1:numCS
    tempCandSol(i,1:n)=randperm(n);
end

%But a tour must end at the city it started from so that city must be added
candSol=[tempCandSol,tempCandSol(1:numCS,1)];

%Now we must evaluate the respective fitnesses of the candidate solutions

%must load the data set that tells us the traveling costs
load tspadata1.txt
%Will call this the costMatrix
costMatrix=tspadata1;

%Will now evaluate each candidate solution in terms of its total cost.
%Will create fitness numCSx1 matrix where each row is the fitness of each
%candiate solution.
sum=0;
for j=1:numCS
    for k=1:n
    fitness(j,1)=costMatrix(candSol(j,k),candSol(j,k+1))+sum;
    sum=fitness(j,1);
    end
    sum=0;
end

%will now sort the candidate solutions wrt their fitness in acsending order
%order

%put fitness in candSol matrix to make candSolFitness matrix
candSolFitness=[candSol,fitness];

%now sort in ascending order wrt last fitness column
[sortedCol,sorter]=sort(candSolFitness(:,n+2),'ascend');

%Will call the sorted matrix rankedSol
rankedSol=candSolFitness(sorter,:);

%now we will choose to top performing half to breed and mutate and will let
%the bottom performing half die off.  Will mutate the top performing quater
%but keep the the original solutions that were mutated too.  Will use crossover
%on the bottom quarter and keep both parents and offspring so that in the
%end we will have kept the population constant.

for e=1:250
%Will now mutate the first quarter using reciprocal exchange/swap operator and put the mutated versions of the
%first quarter in the thrid quarter while keeping the originals in the
%first quarter.

%Will first copy top quarter of rankedSol into third quarter (i.e.overwritting it)
for r=1:numCS/4
    rankedSol((numCS/2)+r,:)=rankedSol(r,:);
end

%now mutate the third quarter
 for m=numCS/2+1:(3/4)*numCS
     %pick two random cities to swap
     city1Pos=randi(17);
     city2Pos=randi(17);
     %cannot pick first city or else invalid route
     if city1Pos==1
          city1Pos=2;
     end
     if city2Pos==1
          city2Pos=2;
     end
    %swap city1Pos entry with city2Pos entry
    temp_mutated1=rankedSol(m,city1Pos);
    temp_mutated2=rankedSol(m,city2Pos);
    rankedSol(m,city2Pos)=temp_mutated1;
    rankedSol(m,city1Pos)=temp_mutated2; 
 end

   %will now use ox crossover operator on second quarter and put the offspring in the fourth quarter thus overwritting the original fourth quarter
   %must first define cut points
   %using n-1 instead of n because I don't want first city to be changed or
   %else would be invalide route.
   cutPoint1=floor((1/3)*(n-1));
   cutPoint2=ceil((2/3)*(n-1));

   %Initialize offspring as zero vectors
   %offspring1=zeros(1,n);
   %offspring2=zeros(1,n);

   for y=(numCS/4)+1:((1/2)*((numCS/2)-(numCS/4))+(numCS/4))
       %must preserve first city and last city to ensure valid route
       offspring1(y-(numCS/4),1)=rankedSol(y,1);
       offspring1(y-(numCS/4),n+1)=rankedSol(y,n+1);
       %offspring2(y-(numCS/4),1)=rankedSol(y+1,1);
       %offspring2(y-(numCS/4),n+1)=rankedSol(y+1,n+1);
       %copy cities between cutpoints to offspring
       offspring1(y-(numCS/4),cutPoint1:cutPoint2)=rankedSol(y,cutPoint1:cutPoint2);
       %offspring2(1,cutPoint1:cutPoint2)=rankedSol(y+1,cutPoint1:cutPoint2);
       %Now construct vector of cities outside cutpoints for both parents
   end

   for y=((1/2)*((numCS/2)-(numCS/4))+(numCS/4))+1:numCS/2

       %must preserve first city and last city to ensure valid route
       offspring2(y-(((1/2)*((numCS/2)-(numCS/4))+(numCS/4))),1)=rankedSol(y,1);
       offspring2(y-(((1/2)*((numCS/2)-(numCS/4))+(numCS/4))),n+1)=rankedSol(y,n+1);
       offspring2(y-(((1/2)*((numCS/2)-(numCS/4))+(numCS/4))),cutPoint1:cutPoint2)=rankedSol(y,cutPoint1:cutPoint2);
   end

     for y=(numCS/4)+1:((1/2)*((numCS/2)-(numCS/4))+(numCS/4))
       for s=1:n-(cutPoint2+1)+1
          newVect1(y-(numCS/4),s)=rankedSol(y,cutPoint2+s);
       end
       %newVect1(1,1:n-(cutPoint2+1))=rankedSol(cutPoint2+1:n);
       for w=n-(cutPoint2+1)+2:n-(cutPoint2-cutPoint1)-1
          newVect1(y-(numCS/4),w)=rankedSol(y,w-(cutPoint2-cutPoint1));
       end
       %newVect1(1,(n-(cutPoint2+1))+1:((n-(cutPoint2+1))+1)+((cutPoint1-1)-2))=rankedSol(y,2:cutPoint1-1);
     end

     for y=((1/2)*((numCS/2)-(numCS/4))+(numCS/4))+1:numCS/2
       for a=1:n-(cutPoint2+1)+1
          newVect2(y-(((1/2)*((numCS/2)-(numCS/4))+(numCS/4))),a)=rankedSol(y,cutPoint2+a);
       end
       %newVect2(1,1:(n-(cutPoint2+1)))=rankedSol(y+1,cutPoint2+1:n);
         for b=n-(cutPoint2+1)+2:n-(cutPoint2-cutPoint1)-1
          newVect2(y-(((1/2)*((numCS/2)-(numCS/4))+(numCS/4))),b)=rankedSol(y,b-(cutPoint2-cutPoint1));
       end
     end

newNewVect1=[newVect1,offspring1(:,cutPoint1:cutPoint2)];
newNewVect2=[newVect2,offspring2(:,cutPoint1:cutPoint2)];

%start with first offspring

       for y=1:numCS/8
          for h=cutPoint2+1:n
              %make sure that no city is repeated
              if isRepeated(newNewVect2(y,h-cutPoint2),offspring1,y)==0
                  offspring1(y,h)=newNewVect2(y,h-cutPoint2);
              else
                  for u=h-cutPoint2:n
                      if isRepeated(newNewVect2(y,u),offspring1,y)==0
                          break
                      end
                  end
                  offspring1(y,h)=newNewVect2(y,u);
                  %offspring1(y,h)=newNewVect2(y,nextNewIndex(newNewVect2,h-cutPoint2,offspring1,y));
             end

          end
       end

       for y=1:numCS/8
       for t=2:cutPoint1-1
           if isRepeated(newNewVect2(y,(n-cutPoint2)+t-1),offspring1,y)==0
               offspring1(y,t)=newNewVect2(y,(n-cutPoint2)+t-1);
           else
               for u=(n-cutPoint2)+t-1:n
                      if isRepeated(newNewVect2(y,u),offspring1,y)==0
                          break
                      end
                  end
                  offspring1(y,t)=newNewVect2(y,u);
               %offspring1(y,t)=newNewVect2(y,nextNewIndex(newNewVect2,(n-cutPoint2)+t-1,offspring1,y));
           end

       end
       end
      %Now for second offspring

      for y=1:numCS/8

       for q=cutPoint2+1:n
       if isRepeated(newNewVect1(y,q-cutPoint2),offspring2,y)==0
           offspring2(y,q)=newNewVect1(y,q-cutPoint2);
       else
           for u=q-cutPoint2:n
                      if isRepeated(newNewVect1(y,u),offspring2,y)==0
                          break
                      end
                  end
                  offspring2(y,q)=newNewVect1(y,u);
           %offspring2(y,q)=newNewVect1(y,nextNewIndex(newNewVect1,q-cutPoint2,offspring2,y));
       end

       end
      end

      for y=1:numCS/8
       for c=2:cutPoint1-1
           if isRepeated(newNewVect1(y,(n-cutPoint2)+c-1),offspring2,y)==0
               offspring2(y,c)=newNewVect1(y,(n-cutPoint2)+c-1);
           else
               for u=(n-cutPoint2)+c-1:n
                      if isRepeated(newNewVect1(y,u),offspring2,y)==0
                          break
                      end
                  end
                  offspring2(y,c)=newNewVect1(y,u);
               %offspring2(y,c)=newNewVect1(y,nextNewIndex(newNewVect1,(n-cutPoint2)+c-1,offspring2,y));
           end

       end
      end
      %now that we have the offspring we can overwrite them into the fourth
      %quarter.

      rankedSol((3/4)*numCS+1:(7/8)*numCS,1:n+1)=offspring1;
      rankedSol((7/8)*numCS+1:numCS,1:n+1)=offspring2;

      %fitness column is out-of-date so must compute fitness of the new
      %solutions
      %take away old fitnesses
      unrankedSol=rankedSol(:,1:n+1);

      %evaluate new actual fitness
      sum2=0;
      for j=1:numCS
          for k=1:n
              fitness(j,1)=costMatrix(unrankedSol(j,k),unrankedSol(j,k+1))+sum2;
              sum2=fitness(j,1);
          end
          sum2=0;
      end

      %will now sort the candidate solutions wrt their fitness in acsending order
      %order

      %put fitness in candSol matrix to make candSolFitness matrix
      newCandSolFitness=[unrankedSol,fitness];

      %now sort in ascending order wrt last fitness column
      [sortedCol,sorter]=sort(newCandSolFitness(:,n+2),'ascend');

      %Will call the sorted matrix rankedSol
      newRankedSol=newCandSolFitness(sorter,:);

      rankedSol=newRankedSol;

end

disp('the best route that this algorithm was able to find is:');
disp(rankedSol(1,1:n+1));
disp('the cost associated with this route is:')
disp(rankedSol(1,n+2));