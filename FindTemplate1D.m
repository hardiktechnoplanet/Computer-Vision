% Find template 1D
% NOTE: Function definition must be the very first piece of code here!
function index = find_template_1D(t, s)
    % TODO: Locate template t in signal s and return index
    % We need to use crosscorrelation 
    c=normxcorr2(t,s); %corelate t over s and returns a normalized set of values
    [maxVlaue, rawIndex]=max(c); %it returns the max value and the index
    %max returns the raw index, in order to get the right index, subtract the 
    %window size and add 1
    index=rawIndex - size(t,2)+1;
endfunction

pkg load image; % AFTER function definition

% Test code:
s = [-1 0 0 1 1 1 0 -1 -1 0 1 0 0 -1];
t = [1 1 0];
disp('Signal:'), disp([1:size(s, 2); s]);
disp('Template:'), disp([1:size(t, 2); t]);

index = find_template_1D(t, s);
disp('Index:'), disp(index);