function [output] = derivative_kernel(name)
% A function to give you the derivatve filter kernel that you desire
%
%   Input: String that will indicate which derivative filter kernel
%           Options - Central, Forward, Prewitt, Sobel
%
%   Output: Derivative filter kernel's coefficients

if name == "Central"
    output = [1 0 -1];
    
elseif name == "Forward"
    output = [0 1 -1];
    
elseif name == "Prewitt"
    output = [1 0 -1;
            1 0 -1;
            1 0 -1];
        
elseif name == "Sobel"
    output = [1 0 -1;
            2 0 -2;
            1 0 -1];
else
    disp('Enter a proper option')
    output = [];
    

end

