class Board
  def initialize()
  	@case1 = BoardCase.new
  	@case2 = BoardCase.new
  	@case3 = BoardCase.new
  	@case4 = BoardCase.new
  	@case5 = BoardCase.new
  	@case6 = BoardCase.new
  	@case7 = BoardCase.new
  	@case8 = BoardCase.new
  	@case9 = BoardCase.new
  end
  def change_value_boardCase(values,boardcase)
    boardcase.value=("values")
  end
end
class BoardCase
  attr_accessor :value
  def initialize(value="")
  	@value = value
  end
end

class Player
  attr_accessor :player_name
  attr_accessor :etat
  def initialize(player_name,etat="")
  	@player_name = player_name
  	@etat = etat
  end
end

class Game
  def initialize()
  	
  end 

end
