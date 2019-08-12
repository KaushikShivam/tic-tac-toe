class Game 
  attr_accessor :matrix
  attr_accessor :players
  attr_accessor :active_player
  attr_accessor :winner
  attr_accessor :counter

  def initialize
    @matrix = [['_', '_', '_'], ['_', '_', '_'], ['_', '_', '_']]
    @players = []
    @active_player = 0
    @counter = 0
    @winner = nil
  end

  def display_matrix
    result = ''
    matrix.length.times { |n| result += "#{matrix[n].join(' ')}\n" }
    result
  end

  def switch_active_player
    self.active_player = active_player.zero? ? 1 : 0

  end

  def find_active_player
    active_player.zero? ? players[0] : players[1]
  end

  def update_matrix(row, column)
    if slot_taken?(row,column)
      return false
    else
      matrix[row - 1][column - 1] = find_active_player.symbol
      self.counter += 1
      return true
    end
  end
  def handle_move 
    if check_move
      self.winner = active_player
    else
      switch_active_player
    end
  end
  def slot_taken?(row,column)
    matrix[row - 1][column - 1] != '_'
  end

  def finished?
    winner || drawn?
  end
  
  def drawn?
    counter == 9
  end
  def check_move
    check_diagonal || check_horizontal || check_vertical
  end
  
  def check_diagonal
    if (
      matrix[0][0] != '_' &&
      matrix[0][0] == matrix[1][1] &&
      matrix[1][1] == matrix[2][2]
    ) ||
    (
      matrix[0][2] != '_' &&
      matrix[0][2] == matrix[1][1] &&
      matrix[1][1] == matrix[2][0]
    )

      return true
    end

    false
  end
  
  def check_vertical
    3.times do |x|
      if matrix[x][0] != '_' &&
      matrix[x][0] == matrix[x][1] &&
      matrix[x][1] == matrix[x][2]
        return true
      end
    end
    false
  end
  
  def check_horizontal
    3.times do |x|
      if matrix[0][x] != '_' &&
      matrix[0][x] == matrix[1][x] &&
      matrix[1][x] == matrix[2][x]
        return true
      end
    end
    false
  end
  

end
