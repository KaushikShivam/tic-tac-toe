class Game 
  attr_accessor :matrix
  attr_accessor :players
  attr_accessor :active_player
  attr_reader :winner
  
  def initialize
    @matrix = [["_", "_", "_"], ["_", "_", "_"], ["_", "_", "_"]]
    @players = []
    @active_player = 0
    @counter=0
    @winner = nil
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
    return false if matrix[row - 1][column - 1] != "_"
    matrix[row - 1][column - 1] = get_active_player.symbol
    
    if check_move
      @winner = @active_player
    else
      switch_active_player
    end
    @counter+=1
    true
  end
  
  def is_finished?
    if @winner
      return 1
    elsif @counter == 9
      return -1
    else
      return 0
    end
  
  end
  
  def check_move
    if (( matrix[0][0] != "_" && matrix[0][0] == matrix[1][1] && matrix[1][1] == matrix[2][2]) ||
      (matrix[0][2] != "_" && matrix[0][2]== matrix[1][1] && matrix[1][1]== matrix[2][0] ))
      return true
    end
    3.times do |x|
      if ((matrix[x][0]!="_" && matrix[x][0]== matrix[x][1] && matrix[x][1]== matrix[x][2] ) ||
          (matrix[0][x]!="_" && matrix[0][x]== matrix[1][x] && matrix[1][x]== matrix[2][x]))
        return true
      end
    end
    false
  end
  
end