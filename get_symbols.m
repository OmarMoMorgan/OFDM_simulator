function [output_symbols] = get_symbols(equalized_signal,pilots_index,zeros_index)

indices_to_remove = [pilots_index,zeros_index];

output_symbols = equalized_signal;
output_symbols(indices_to_remove,:) = [];
end