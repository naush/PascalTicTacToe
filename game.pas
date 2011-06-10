program Game;

uses
  IOUnit, RuleUnit, BoardUnit, AIUnit;

var
  input    : string  = 'tic tac toe';
  position : integer = 1;
  code     : integer = 0;
  board    : string  = E + E + E + E + E + E + E + E + E;
  mark     : char    = O;

begin

  while not quit(input) do
    begin
      print_board(board);

      if mark = O then
        begin
          ask_move();
          readln(input);
          val(input, position, code); { convert string to integer }
        end
      else
        position := best_move(board, mark);

      if not legal(board, position) and not quit(input) then
        print_illegal_message(input)
      else
        begin
          board := play(board, position, mark);
          if over(board) then
            begin
              print_outcome(board, mark);
              exit;
            end;
          mark := switch(mark);
        end;

    end;

end.
