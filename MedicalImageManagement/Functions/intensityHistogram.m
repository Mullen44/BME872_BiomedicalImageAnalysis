function [bins, freq, Nfreq] = intensityHistogram(img, binNumber)
    if length(size(img)) == 2
        minI = min(min(img));
        maxI = max(max(img));
    elseif length(size(img)) == 3
        minI = min(min(min(img)));
        maxI = max(max(max(img)));
    end
    
    factor = (maxI - minI)/binNumber;
    
    for z = (1:binNumber)
        bins(z) = minI + factor*z;
    end
    
    imgSize = [size(img), 1];
    
    freq = zeros(1,length(bins));
    
    for i = (1:imgSize(1))
        for j = (1:imgSize(2))
            for k = (1:imgSize(3))
                for l = (1:binNumber)
                    if l ~= 1 && 1 ~= binNumber
                        if img(i,j,k) <= bins(l) && img(i,j,k) > bins(l-1)
                            freq(l) = freq(l) + 1;
                        end
                    elseif l == 1
                        if img(i,j,k) <= bins(l)
                            freq(l) = freq(l) + 1;
                        end
                    elseif 1 == binNumber
                        if img(i,j,k) <= maxI && img(i,j,k) > bins(l-1)
                            freq(l) = freq(l) + 1;
                        end
                    end
                end
            end
        end
    end
    
    for z = (1:binNumber)
        bins(z) = bins(z) - factor/2;
    end
    
    Nfreq = freq/(imgSize(1)*imgSize(2)*imgSize(3));
end

