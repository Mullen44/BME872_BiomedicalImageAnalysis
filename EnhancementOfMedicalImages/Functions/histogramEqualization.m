function [output] = histogramEqualization(input, PDF)

I_max = double(max(max(input)));
CDF = PDF;
for i = 2:length(CDF)
    CDF(i) = CDF(i)+CDF(i-1);
end
%disp(CDF)
%disp(I_max)

% Create Transfer Function Lookup table
T = CDF*I_max;
%disp(T)
output = contrast_tfrm_curve(input, T);

end

