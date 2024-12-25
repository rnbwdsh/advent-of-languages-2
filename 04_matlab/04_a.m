fid = fopen('04.in', 'r');
fc = fread(fid, '*char')';
m = strsplit(fc, '\n');
needle = "XMAS";

char_to_int = containers.Map({'X', 'M', 'A', 'S'}, [1, 2, 3, 4]);
int_array = cellfun(@(str) cellfun(@(char) char_to_int(char), num2cell(str)), m, 'UniformOutput', false);
int_matrix = cell2mat(int_array');
kernel = [1, 8, 64, 256];
needle_value = 1*char_to_int(needle(1)) + 8*char_to_int(needle(2)) + 64*char_to_int(needle(3)) + 256*char_to_int(needle(4));

total = 0;
for i = 1:4
    result = conv2(int_matrix, kernel, "valid");
    total = total + sum(result(:) == needle_value);
    result = conv2(int_matrix, diag(kernel), "valid");
    total = total + sum(result(:) == needle_value);
    int_matrix = rot90(int_matrix);
end
disp(total)