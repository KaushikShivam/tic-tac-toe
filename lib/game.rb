class Game 
  attr_accessor :matrix
  attr_accessor :players
  attr_accessor :active_player
  
  def initialize
    @matrix = [["_", "_", "_"], ["_", "_", "_"], ["_", "_", "_"]]
    @players = []
    @active_player = 0
  end
  def get_matrix
    result = ""
    matrix.length.times { |n| result += "#{matrix[n].join(' ')}\n" }
    result
  end
  
  def switch_active_player
    @active_player = @active_player == 0 ? 1 : 0 
  end
  
  def get_active_player
    active_player == 0 ? players[0] : players[1]
  end
  
  def update_matrix(row, column)
    matrix[row - 1][column - 1] = get_active_player.symbol
    switch_active_player
  end
  
  
end