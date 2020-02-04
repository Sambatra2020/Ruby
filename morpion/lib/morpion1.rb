require "pry"

class BoardCase
  #TO DO : la classe a 2 attr_accessor, sa valeur en string (X, O, ou vide), ainsi que son identifiant de case
  attr_accessor :case_value
  attr_accessor :case_id
  def initialize(case_id,case_value)
    #TO DO : doit régler sa valeur, ainsi que son numéro de case
    @case_value = case_value
    @case_id = case_id
  end
end

class Board
  #TO DO : la classe a 1 attr_accessor : un array/hash qui contient les BoardCases.
  #Optionnellement on peut aussi lui rajouter un autre sous le nom @count_turn pour compter le nombre de coups joué
  attr_accessor :cbc

  def initialize
    #TO DO :
    #Quand la classe s'initialize, elle doit créer 9 instances BoardCases
    #Ces instances sont rangées dans un array/hash qui est l'attr_accessor de la classe
    @cbc = Array.new
    for i in 1..9
        @boardcase = BoardCase.new(i," ")
        @cbc << @boardcase
    end
  end

  def play_turn(joueur)
    #TO DO : une méthode qui :
    #1) demande au bon joueur ce qu'il souhaite faire
    #2) change la BoardCase jouée en fonction de la valeur du joueur (X ou O)
    puts "#{joueur.nom}! a vous de jouer,choississer une case"
    case_number = Integer(gets.chomp)-1
    while case_number+1 > 9 || case_number+1 <1
      puts "#{joueur.nom}! a vous de jouer,choississer une nombre appartient [1,9]"
      case_number = Integer(gets.chomp)-1
    end
    while @cbc[case_number].case_value == "X" || @cbc[case_number].case_value == "O" 
      puts "#{joueur.nom}! a vous de jouer,choississer une case vide"
      case_number = Integer(gets.chomp)-1
    end
    @cbc[case_number].case_value = (joueur.valeur)
  end

  def victory?
    #TO DO : une méthode qui vérifie le plateau et indique s'il y a un vainqueur ou match nul
    if ((@cbc[0].case_value == @cbc[1].case_value) && (@cbc[0].case_value == @cbc[2].case_value) && (@cbc[2].case_value == "X" || @cbc[2].case_value == "O")) || ((@cbc[3].case_value == @cbc[4].case_value) && (@cbc[4].case_value == @cbc[5].case_value) && (@cbc[5].case_value == "X" || @cbc[5].case_value == "O")) || ((@cbc[6].case_value == @cbc[7].case_value) && (@cbc[6].case_value == @cbc[8].case_value) && (@cbc[6].case_value == "X" || @cbc[6].case_value == "O")) || ((@cbc[0].case_value == @cbc[3].case_value) && (@cbc[0].case_value == @cbc[6].case_value) && (@cbc[0].case_value == "X" || @cbc[0].case_value == "O")) || ((@cbc[1].case_value == @cbc[4].case_value) && (@cbc[1].case_value == @cbc[7].case_value) && (@cbc[1].case_value == "X" || @cbc[1].case_value == "O")) || ((@cbc[2].case_value == @cbc[5].case_value) && (@cbc[2].case_value == @cbc[8].case_value) && (@cbc[2].case_value == "X" || @cbc[2].case_value == "O")) || ((@cbc[0].case_value == @cbc[4].case_value) && (@cbc[4].case_value == @cbc[8].case_value) && (@cbc[4].case_value == "X" || @cbc[4].case_value == "O")) || ((@cbc[2].case_value == @cbc[4].case_value) && (@cbc[2].case_value == @cbc[6].case_value) && (@cbc[2].case_value == "X" || @cbc[2].case_value == "O"))
      return true
    else
      return false
    end
  end

  def testCase?
    a=0
    @cbc.each { |bc| a=1 if bc.case_value == (" ") }
    if a==0
      return true
    else
      return false
    end
  end
end

class Player
  #TO DO : la classe a 2 attr_reader, son nom et sa valeur (X ou O).
  attr_reader :nom
  attr_reader :valeur
  def initialize(nom,valeur)
    #TO DO : doit régler son nom et sa valeur
    @nom = nom
    @valeur = valeur
  end
end

class Game
  #TO DO : la classe a plusieurs attr_accessor: le current_player (égal à un objet Player), le status (en cours, nul ou un objet Player s'il gagne), le Board et un array contenant les 2 joueurs.
  attr_accessor :current_player
  attr_accessor :status
  attr_accessor :board
  attr_accessor :joueurs
  def initialize 
    #TO DO : créé 2 joueurs, créé un board, met le status à "on going", défini un current_player
    puts "taper le nom du premier joueur :"
    @player1 = Player.new(gets.chomp,"X")
    puts "taper le nom du deuxième joueur :"
    @player2 = Player.new(gets.chomp,"O")
    @status = 0
    @joueurs = Array.new
    @joueurs << @player1
    @joueurs << @player2
    @board = Board.new
    puts "ON GOING BOONGLE'S MORPION"
    @current_player = @joueurs[0]
    @show = Show.new
    @index = 0
  end
  def turn
    #TO DO : méthode faisant appelle aux méthodes des autres classes (notamment à l'instance de Board). Elle affiche le plateau, demande au joueur ce qu'il joue, vérifie si un joueur a gagné, passe au joueur suivant si la partie n'est pas finie.
    @show.show_board(@board)
    @board.play_turn(@current_player)
   
    if @board.victory? || @board.testCase?
      @status = 1
      self.game_end
    else
      @index += 1
      @current_player = joueurs[@index%2]
    end
  end

  def new_round
    # TO DO : relance une partie en initialisant un nouveau board mais en gardant les mêmes joueurs.
    @board = Board.new
    self.turn
  end

  def game_end
    # TO DO : permet l'affichage de fin de partie quand un vainqueur est détecté ou si il y a match nul
    @show.show_board(@board)
    if @board.victory? 
      puts "end game!!! Felicitation #{@current_player.nom}, vous êtes le vainqueur"
    else
      puts "end game!!! match nul"
    end
  end    
end


class Show

  def show_board(board)
    table = board.cbc
    #TO DO : affiche sur le terminal l'objet de classe Board en entrée. S'active avec un Show.new.show_board(instance_de_Board)
    puts "*************    *************"
    puts "* #{table[0].case_value} * #{table[1].case_value} * #{table[2].case_value} *    * 1 * 2 * 3 *"
    puts "*************    *************"
    puts "* #{table[3].case_value} * #{table[4].case_value} * #{table[5].case_value} *    * 4 * 5 * 6 *"
    puts "*************    *************"
    puts "* #{table[6].case_value} * #{table[7].case_value} * #{table[8].case_value} *    * 7 * 8 * 9 *"
    puts "*************    *************"
  end
end

class Application

  def perform
    # TO DO : méthode qui initialise le jeu puis contient des boucles while pour faire tourner le jeu tant que la partie n'est pas terminée.
    # 
    partie = Game.new
    while partie.status == 0
      partie.turn
    end
    partie.status = 0
    puts "vous voulez lancer une nouvelle partie O/N?"
    reponse = gets.chomp
    if reponse == "O"
      while partie.status == 0
        partie.new_round
      end
    end

  end

end
Application.new.perform
