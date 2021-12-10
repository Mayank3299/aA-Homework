require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    node= TicTacToeNode.new(game.board, mark)
    win_node= node.children.find do |child|
      child.winning_node?(mark)
    end
    return win_node.prev_move_pos if win_node

    win_node= node.children.find{|child| !child.losing_node?(mark)}
    return win_node.prev_move_pos if win_node

    raise "Kya yahi haar hai?!"
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
