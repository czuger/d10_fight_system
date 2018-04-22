require_relative '../lib/creatures/character'

c1 = Character.generate
c2 = Character.generate

1.upto(100).each do
  c1.attack(c2)
end