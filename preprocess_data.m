function [data,targets] = preprocess_data(input_matrix)
users = 943;
movies = 1682;
%PREPROCESS_DATA 
full_length = users*movies;
i=1; k=1;
for i=1:movies:full_length
    data([i:i+(movies - 1)],1) = k;
    data([i:i+(movies - 1)],2) = [1:movies];
    k=k+1;
end

%sort input data
input_matrix = sortrows(input_matrix, [1 2]);

%create a bitmask for existing elements
c = data(:,[1 2]);
d = input_matrix(:,[1 2]);
b = ismember(c,d,'rows');
data(:,3) = b;

%fill in the ones with the input-matrix 3rd column elements(ratings)
i = 1;k = 1;
for i=1:full_length
        if data(i,3) == 1
            data(i,3) = input_matrix(k,3);
            k = k +1;
        end
end

%find the average rating of each user and pass it to a vector
[a,~,c] = unique(input_matrix(:,1));
AvgCost = [input_matrix(a,1) accumarray(c, input_matrix(:,3), [], @mean)];
averageperuser = round(AvgCost(:,2));

%%centering

%i=1; k=1; j=1;
%for i=1:movies:full_length %arraylen
 %   for j=i:i+movies
  %      if data(j,3) ~= 0
   %          data(j,3) = data(j,3) - averageperuser(k,1);
    %    end
     %   if j==full_length 
      %      break;
       % end
    %end
    %k = k+1;
%end


%fill in the zeros of each user with its average rating
i=1; k=1; j=1;
for i=1:movies:full_length %arraylen
    for j=i:i+movies
        if data(j,3) == 0
             data(j,3) = averageperuser(k,1);
        end
        if j==full_length 
            break;
        end
    end
    k = k+1;
end

%reshape the array into the correct dimensions
i=1;k=1;
targets = zeros(users,movies);
for i=1:users
    targets(i,:) = data([k:k+(movies - 1)],3);
    k=k+movies;
end

%rescale values into (0,1)
targets = rescale(targets);
end

