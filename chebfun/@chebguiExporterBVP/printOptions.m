function printOptions(fid, expInfo)
%PRINTOPTIONS   Print problem options when they are exported.
%
% Calling sequence:
%   PRINTOPTIONS(FID, EXPINFO)
% where
%   FID:        ID of a file-writing stream.
%   EXPINFO:    Struct containing information for printing the problem.

% Copyright 2014 by The University of Oxford and The Chebfun Developers.
% See http://www.chebfun.org/ for Chebfun information.

% Extract info from the expInfo struct:
tol = expInfo.tol;
dampingOn = expInfo.dampingOn;
discretization = expInfo.discretization;
plotting = expInfo.plotting;

% Set up preferences
fprintf(fid, '\n%%%% Setup preferences for solving the problem.');
fprintf(fid, '\n%% Create a CHEBOPPREF object for passing preferences: \n');
fprintf(fid, 'options = cheboppref();\n');

% Always show iteration information:
fprintf(fid, 'options.display = ''iter'';\n');

% Specify tolerance:
if ( ~isempty(tol) )
    fprintf(fid, '\n%% Option for tolerance.\n');
    fprintf(fid, 'options.errTol = %s;\n', tol);
end

% Option for damping:
fprintf(fid, '\n%% Option for damping.\n');
if ( strcmp(dampingOn, '1') )
    fprintf(fid, 'options.damping = true;\n');
else
    fprintf(fid, 'options.damping = false;\n');
end

% Option for discretization:
fprintf(fid, ['\n%% Option for discretization (either ''collocation'' ' ...
    'or ''ultraspherical'').\n']);
if ( isa(discretization(), 'colloc') )
    discString = 'collocation';
else
    discString = 'ultraspherical';
end
fprintf(fid, 'options.discretization = ''%s'';\n', discString);

% Plot during Newton iteration?
if ( ~strcmp(plotting, 'off') )
    fprintf(fid, ['\n%% Option for determining how long each Newton step ' ...
        'is shown.\n']);
    fprintf(fid, 'options.plotting = %s;\n', plotting);
else
    fprintf(fid, ['\n%% Option for determining how long each Newton step ' ...
        'is shown.\n']);
    fprintf(fid,'options.plotting = ''off'';\n');
end

end