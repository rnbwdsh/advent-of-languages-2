% Step 1: Read the file and split the content by lines
fid = fopen('04.in', 'r');
fc = fread(fid, '*char')';
fclose(fid);
m = strsplit(fc, '\n');

% Step 2: Convert each character to its corresponding integer value
char_to_int = containers.Map({'X', 'M', 'A', 'S', '.'}, [1, 2, 3, 4, 0]);
int_array = cellfun(@(str) cellfun(@(char) char_to_int(char), num2cell(str)), m, 'UniformOutput', false);
int_matrix = cell2mat(int_array');

% Define the new kernel and needle value
kernel = [1, 0, 8; 0, 64, 0; 64*8, 0, 64*64];
needle_value = 1*char_to_int('M') + 0*char_to_int('.') + 8*char_to_int('M') + ...
              0*char_to_int('.') + 64*char_to_int('A') + 0*char_to_int('.') + ...
              64*8*char_to_int('S') + 0*char_to_int('.') + 64*64*char_to_int('S');

total = 0;
for i = 1:4
    result = conv2(int_matrix, kernel, "valid");
    total = total + sum(result(:) == needle_value);
    int_matrix = rot90(int_matrix);
end
disp(total);