program Game;

const
  CR = #13;
  LF = #10;
  CRLF = CR + LF;
  O = 'O';
  X = 'X';
  E = '+';

var
  input    : string  = 'tic tac toe';
  position : integer = 1;
  code     : integer = 0;
  board    : string  = E + E + E + E + E + E + E + E + E;
  mark     : char    = O;

function format (board : string) : string;
begin
  format := board[1] + board[2] + board[3] + CRLF
          + board[4] + board[5] + board[6] + CRLF
          + board[7] + board[8] + board[9];
end;

function play (board : string; position : integer; mark : char) : string;
begin
  board[position] := mark;
  play := board;
end;

function legal (board : string; position : integer) : boolean;
begin
  legal := board[position] = E
end;

function quit (input : string) : boolean;
begin
  quit := (input = 'q') or (input = 'quit')
end;

function switch (current : char) : char;
begin
  if current = O then switch := X;
  if current = X then switch := O;
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

function random (board : string; mark : char) : integer;
var index : integer;
begin
  for index := 1 to 9 do
    if board[index] = E then random := index;
end;

procedure print_board (board : string);
begin
  writeln(format(board));
  writeln('===');
end;

procedure declare_winner (mark : char);
begin
  writeln('Game over. ' + mark + ' has won.');
end;

begin
  while not quit(input) do
    begin
      print_board(board);

      if mark = O then
        begin
          writeln('Play a move (type q to quit):');
          readln(input);
          val(input, position, code); { convert string to integer }
        end
      else
        begin
          {position := random(board, mark);}
          position := best_move(board, mark);
        end;

      if not legal(board, position) and not quit(input) then
        writeln(input + ' is illegal.')
      else
        begin
          board := play(board, position, mark);

          if win(board, mark) then
            begin
              print_board(board);
              declare_winner(mark);
              exit;
            end;

          if lose(board, mark) then
            begin
              print_board(board);
              declare_winner(switch(mark));
              exit;
            end;

          if draw(board) then
            begin
              print_board(board);
              writeln('Game over. Nobody wins.');
              exit;
            end;

          mark := switch(mark);
        end;

    end;
end.
