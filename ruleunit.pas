unit RuleUnit;

interface

uses BoardUnit;

function legal (board : string; position : integer) : boolean;
function rows (board : string; mark : char) : boolean;
function columns (board: string; mark : char) : boolean;
function crosses (board : string; mark : char) : boolean;
function win (board : string; mark : char) : boolean;
function lose (board : string; mark : char) : boolean;
function full (board : string) : boolean;
function draw (board : string) : boolean;
function over (board : string) : boolean;

implementation

const
  O = 'O';
  X = 'X';
  E = '+';

function legal (board : string; position : integer) : boolean;
begin
  legal := board[position] = E
end;

function rows (board : string; mark : char) : boolean;
begin
  rows :=
    ((board[1] = mark) and (board[1] = board[2]) and (board[1] = board[3])) or
    ((board[4] = mark) and (board[4] = board[5]) and (board[4] = board[6])) or
    ((board[7] = mark) and (board[7] = board[8]) and (board[7] = board[9]));
end;

function columns (board: string; mark : char) : boolean;
begin
  columns :=
    ((board[1] = mark) and (board[1] = board[4]) and (board[1] = board[7])) or
    ((board[2] = mark) and (board[2] = board[5]) and (board[2] = board[8])) or
    ((board[3] = mark) and (board[3] = board[6]) and (board[3] = board[9]));
end;

function crosses (board : string; mark : char) : boolean;
begin
  crosses :=
    ((board[1] = mark) and (board[1] = board[5]) and (board[1] = board[9])) or
    ((board[3] = mark) and (board[3] = board[5]) and (board[3] = board[7]));
end;

function win (board : string; mark : char) : boolean;
begin
  if rows(board, mark) or columns(board, mark) or crosses(board, mark) then win := true
  else win := false;
end;

function lose (board : string; mark : char) : boolean;
begin
  lose := win(board, switch(mark));
end;

function full (board : string) : boolean;
var index : integer;
begin
  for index := 1 to 9 do
    if board[index] = E then
      begin
        full := false;
        exit;
      end;
  full := true;
end;

function draw (board : string) : boolean;
begin
  draw := full(board);
end;

function over (board : string) : boolean;
begin
  over := win(board, O) or win(board, X) or draw(board);
end;

end.