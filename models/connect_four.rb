require 'pry'
class ConnectFour
  attr_accessor :game

  def initialize
    @game = []
  end

  def board_size(size)
    size.times do
      @game << Array.new(size, 'x')
    end
    game_board
  end

  def game_board
    rows = @game.length
    row = 0

    while row <= rows
      p @game[row]
      row += 1
    end
  end

  def player
    @turn ||= 0
    if @turn.even?
      player = '1'
      @chip = 'R'
    else
      player = '2'
      @chip = 'B'
    end
    @turn += 1
    player
  end

  def insert_chip(choice)
    row = @game.length - 1
    # puts row
    # puts @game
    while row >= 0
      if @game[row][choice - 1] == 'x'
        # location chip is placed to check if player won
        @column_location = choice - 1
        @row_location = row
        # insert chip at this location
        @game[row][choice - 1] = @chip
        horizontal
        return game_board
      else
        row -= 1
      end
    end
    # if the column is full...
    puts 'That column is full... pick a new column!'
    new_choice = gets.to_i
    insert_chip(new_choice)
  end

  def won
    return "Player Won!" if verticle || horizontal || diagonal_forward || diagonal_backwards
    false
  end

  def verticle
    count = 0
    start = @game[@row_location].index(@chip)
    @game.drop(start).each_index do |row|
      # next if @game[row][@column_location] == 'x'
      if @game[row][@column_location] == @chip
        count += 1
      else
        return false
      end
      puts "Player won verticle" if count == 4
    end
  end

  def horizontal
    return false if @game[@row_location].count(@chip) < 4
    start = @game[@row_location].index(@chip)
    count = 1

    @game[@row_location].drop(start).each do |x|
      if x != @chip
        return false
      else
        count += 1
      end

      puts "Player won horizontal" if count >= 4
    end
  end

  def diagonal_forward
    padding = @game.size - 1
    padded_matrix = []

    @game.each do |row|
      inverse_padding = @game.size - padding
      padded_matrix << ([nil] * inverse_padding) + row + ([nil] * padding)
      padding -= 1
    end

    diagonal_matrix = padded_matrix.transpose.map(&:compact).delete_if { |row| row.length < 4 }

    filtered = []
    diagonal_matrix.each do |row|
      filtered << row.each_index.select { |i| row[i] == @chip }
    end
    puts "Player won" if filtered.flatten.sort.each_cons(4).any? { |x,y| y == x + 1 }
  end

  def diagonal_backwards
    padding = @game.size - 1
    padded_matrix = []

    @game.reverse_each do |row|
      inverse_padding = @game.size - padding
      padded_matrix << ([nil] * inverse_padding) + row + ([nil] * padding)
      padding -= 1
    end

    diagonal_matrix = padded_matrix.transpose.map(&:compact).delete_if { |row| row.length < 4 }

    filtered = []
    diagonal_matrix.each do |row|
      filtered << row.each_index.select { |i| row[i] == @chip }
    end
    puts "Player won" if filtered.flatten.sort.each_cons(4).any? { |x,y| y == x + 1 }
  end
end
