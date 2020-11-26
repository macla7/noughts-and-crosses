# frozen_string_literal: true

# noughts and crooses board game

class Player
  attr_reader :placement
  def initialize
    @@finished = false
    @@p1 = @@p2 = @@p3 = @@p4 = @@p5 = @@p6 = @@p7 = @@p8 = @@p9 = ' '
    @@used_values = []
    @@possible_places = [1,2,3,4,5,6,7,8,9]
  end

  def self.finished
    @@finished
  end

  def assign
    case @placement
    when 1
      @@p1 = @symbol
    when 2
      @@p2 = @symbol
    when 3
      @@p3 = @symbol
    when 4
      @@p4 = @symbol
    when 5
      @@p5 = @symbol
    when 6
      @@p6 = @symbol
    when 7
      @@p7 = @symbol
    when 8
      @@p8 = @symbol
    when 9
      @@p9 = @symbol
    else
      puts 'error'
    end
    @placement = 0
  end

  def winner
    winning_saying if @@p1 == @@p2 && @@p2 == @@p3 && @@p2 == @symbol
    winning_saying if @@p4 == @@p5 && @@p5 == @@p6 && @@p5 == @symbol
    winning_saying if @@p7 == @@p8 && @@p8 == @@p9 && @@p8 == @symbol
    winning_saying if @@p1 == @@p4 && @@p4 == @@p7 && @@p4 == @symbol
    winning_saying if @@p2 == @@p5 && @@p5 == @@p8 && @@p5 == @symbol
    winning_saying if @@p3 == @@p6 && @@p6 == @@p9 && @@p6 == @symbol
    winning_saying if @@p1 == @@p5 && @@p5 == @@p9 && @@p5 == @symbol
    winning_saying if @@p3 == @@p5 && @@p5 == @@p7 && @@p5 == @symbol
  end

  def winning_saying
    puts "Congrats #{@name}, you've won big!!"
    @@finished = true
  end

  def board
    puts "
     #{@@p1} | #{@@p2} | #{@@p3} 
    ---+---+---
     #{@@p4} | #{@@p5} | #{@@p6} 
    ---+---+---
     #{@@p7} | #{@@p8} | #{@@p9} 
    "
  end
end

class Human < Player
  def initialize(name)
    super()
    @symbol = 'x'
    @name = name
  end

  def place
    until @@possible_places.include? @placement
      puts "\n#{@name}, place a number between 1-9? Type 'help me mi'lord' if you're unsure.\n\n"
      @placement = gets.chomp.to_i
      while @@used_values.include? @placement
        puts "You cannot place onto a used tile."
        @placement = gets.chomp.to_i
      end
      if @placement>0 && @placement<10
        @@used_values.push(@placement)
        return @placement
      else @placement== "help me mi'lord"
        help
      end
    end
  end

  def help
    puts "\nplace a cross by typing one of the tile's numbers"
    puts "
      1 | 2 | 3 
    ---+---+---
      4 | 5 | 6 
    ---+---+---
      7 | 8 | 9 
    "
  end

  def turn
    place
    assign
    board
    winner
  end
end

class Comp < Player
  def initialize
    super()
    @name = 'Skynet'
    @symbol = 'o'
    @placement = nil
  end

  def rando_place
    until @@possible_places.include? @placement
      puts "#{@name} moves.."
      @placement = rand(1..9)
      while @@used_values.include? @placement
        @placement = rand(1..9)
      end
      @@used_values.push(@placement)
      return @placement
    end
  end

  def turn
    rando_place
    assign
    board
    winner
  end
end

puts "\nHow are you today? Would you like to play?"
puts "\nPlease enter your name if so:\n\n"
name = gets.chomp

person = Human.new(name)
sky = Comp.new()

until Player.finished
  person.turn
  unless Player.finished
    sky.turn
  end
end