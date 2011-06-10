unit IOUnit;

interface

procedure ask_move ();
procedure print_board (board : string);
procedure print_outcome (board : string; mark : char);
procedure declare_winner (mark : char);
procedure declare_draw ();
procedure print_illegal_message(input : string);
function quit (input : string) : boolean;

implementation

uses RuleUnit, BoardUnit;

function format (board : string) : string;
const
  CR = #13;
  LF = #10;
  CRLF = CR + LF;
begin
  format := board[1] + board[2] + board[3] + CRLF
          + board[4] + board[5] + board[6] + CRLF
          + board[7] + board[8] + board[9];
end;

procedure ask_move ();
begin
  writeln('Play a move (type q to quit):');
end;

procedure print_board (board : string);
begin
  writeln(format(board));
  writeln('===');
end;

procedure print_outcome (board : string; mark : char);
begin
  print_board(board);
  if win(board, mark) then declare_winner(mark)
  else if lose(board, mark) then declare_winner(switch(mark))
  else if draw(board) then declare_draw();
end;

procedure declare_winner (mark : char);
begin
  writeln('Game over. ' + mark + ' has won.');
end;

procedure declare_draw ();
begin
  writeln('Game over. Nobody wins.')
end;

procedure print_illegal_message(input : string);
begin
  writeln(input + ' is illegal.')
end;

function quit (input : string) : boolean;
begin
  quit := (input = 'q') or (input = 'quit')
end;

end.