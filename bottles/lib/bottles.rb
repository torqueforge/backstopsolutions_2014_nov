module BottleNumberFactory
  refine Fixnum do
    def to_bottle_number
      begin
        Object.const_get("BottleNumber#{self}")
      rescue
        BottleNumber
      end.new(self)
    end
  end
end

using BottleNumberFactory

class Bottles
  def song
    verses(99, 0)
  end

  def verses(upper, lower)
    upper.downto(lower).map { |i| verse(i) }.join("\n")
  end

  def verse(number)
    bottle_number      = number.to_bottle_number
    next_bottle_number = bottle_number.successor
    "#{bottle_number.amount.capitalize} #{bottle_number.container} of beer on the wall, " +
    "#{bottle_number.amount} #{bottle_number.container} of beer.\n" +
    "#{bottle_number.action}, " +
    "#{next_bottle_number.amount} #{next_bottle_number.container} of beer on the wall.\n"
  end

end

class BottleNumber
  attr_reader :number

  def initialize(number)
    @number = number
  end

  def container
    "bottles"
  end

  def pronoun
    "one"
  end

  def amount
    number.to_s
  end

  def action
    "Take #{pronoun} down and pass it around"
  end

  def successor
    (number - 1).to_bottle_number
  end
end

class BottleNumber0 < BottleNumber
  def amount
    "no more"
  end

  def action
    "Go to the store and buy some more"
  end

  def successor
    99.to_bottle_number
  end
end

class BottleNumber1 < BottleNumber
  def container
    "bottle"
  end

  def pronoun
    "it"
  end
end
