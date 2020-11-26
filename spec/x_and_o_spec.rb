require './noughts_and_crosses'

describe Human do
  describe '#winning saying' do
    it 'returns finished == true' do
      human = Human.new('jon')
      expect(human.winning_saying).to eql(true)
    end
  end

  describe '#place' do
    it 'places tile' do
      human = Human.new('jon')
      expect(human.place).to eql(human.placement)
    end
  end

  describe '#help' do
    it 'prints example board when you help me mi\'lord' do
      human = Human.new('jon')
      expect(human.help).to eql(puts "
        1 | 2 | 3 
      ---+---+---
        4 | 5 | 6 
      ---+---+---
        7 | 8 | 9 
      ")
    end
  end
end

describe Comp do
  describe '#rando_place' do
    it 'returns a random place' do
      computer = Comp.new
      expect(computer.rando_place).to eql(computer.placement)
    end
  end
end