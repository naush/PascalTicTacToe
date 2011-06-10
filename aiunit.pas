unit AIUnit;

interface

uses
  RuleUnit, BoardUnit;

function minmax (board : string; mark : char) : integer;
function best_move (board : string; mark : char) : integer;
function random_move (board : string; mark : char) : integer;

implementation

function minmax (board : string; mark : char) : integer;
var index : integer;
var candidate : integer;
var min : integer = 1;
begin
  if win(board, mark) then
    begin
      minmax := 1;
      exit;
    end
  else if draw(board) then
    begin
      minmax := 0;
      exit;
    end;

  mark := switch(mark);
  for index := 1 to 9 do
    if board[index] = E then
      begin
        candidate := -minmax(play(board, index, mark), mark);
        if candidate < min then min := candidate;
      end;

  minmax := min;
end;

function best_move (board : string; mark : char) : integer;
var
  scoreboard : array[1..9] of integer;
  index : integer;
  max : integer = -2;
  best : integer;
begin
  for index := 1 to 9 do
    scoreboard[index] := -2;

  for index := 1 to 9 do
    if board[index] = E then
      scoreboard[index] := minmax(play(board, index, mark), mark);
 
  for index := 1 to 9 do
    if scoreboard[index] > max then
      begin
        max := scoreboard[index];
        best := index;
      end;

  best_move := best;
end;

function random_move (board : string; mark : char) : integer;
var index : integer;
begin
  for index := 1 to 9 do
    if board[index] = E then random_move := index;
end;

end.
