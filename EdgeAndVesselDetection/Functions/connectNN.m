function [output] = connectNN(input)
%CONNECTNN Summary of this function goes here
%   Detailed explanation goes here

output = zeros(size(input));
windowSize = 5;

for i = 10:size(input, 1)-10
    for j = 10:size(input, 2)-10
        if input(i, j) == 1
            %disp('1 Found')
            xStart = i-windowSize;
            xFinish = i+windowSize;
            yStart = j-windowSize;
            yFinish = j+windowSize;
            
            if xStart <= 0
                xStart = 1;
            end
            if xFinish >= size(input,1)+1
                xFinish = size(input,1);
            end
            if yStart <= 0
                yStart = 1;
            end
            if yFinish >= size(input,2)+1
                yFinish = size(input,2);
            end
            
            %disp(xStart)
            %disp(xFinish)
            %disp(yStart)
            %disp(yFinish)
            interest = input(xStart:xFinish, yStart:yFinish);
            
            indices = find(interest == 1);
            indices = indices(indices~=13);
            [~, ind] = min(indices-13);
            
            xCoord = mod((indices(ind)-1), windowSize*2+1)-windowSize;
            yCoord = floor((indices(ind)-1)./5)-windowSize;
            
            % Fill in output array
            output(i,j) = 1;
            if xCoord < 0
                for xadd = 1:abs(xCoord)
                    output(i-xadd, j) = 1;
                end
            end
            if xCoord > 0
                for xadd = 1:abs(xCoord)
                    output(i+xadd, j) = 1;
                end
            end
            if yCoord < 0 && xCoord < 0
                for yadd = 1:abs(yCoord)
                    output(i-xadd,j-yadd) = 1;
                end
            end
            if yCoord < 0 && xCoord > 0
                for yadd = 1:abs(yCoord)
                    output(i+xadd,j-yadd) = 1;
                end
            end            
            if yCoord > 0 && xCoord < 0
                for yadd = 1:abs(yCoord)
                    output(i-xadd,j+yadd) = 1;
                end
            end
            if yCoord > 0 && xCoord > 0
                for yadd = 1:abs(yCoord)
                    output(i+xadd,j+yadd) = 1;
                end
            end            
        end
    end
end
end

