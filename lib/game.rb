class Game 
  attr_reader :matrix
  
  def initialize
    @matrix = [["_", "_", "_"], ["_", "X", "_"], ["_", "_", "_"]]
  end
  def get_matrix
    result=""
    matrix.length.times { |n| result += "#{matrix[n].join(' ')}\n" }
    result
  end
end