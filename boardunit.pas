unit BoardUnit;

interface

function switch (current : char) : char;
function play (board : string; position : integer; mark : char) : string;

const
  O = 'O';
  X = 'X';
  E = '+';

implementation

function switch (current : char) : char;
begin
  if current = O then switch := X;
  if current = X then switch := O;
end;

function play (board : string; position : integer; mark : char) : string;
begin
  board[position] := mark;
  play := board;
end;

end.
