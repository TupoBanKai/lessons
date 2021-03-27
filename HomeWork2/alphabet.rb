alphabet = 'a b c d e f g h i j k l m n o p q r s t u v w x y z'.split(' ')
vowls = 'a e i o u y'.split(' ')
hash = {}
vowls.each do |value|
  hash[value] = alphabet.find_index(value) + 1
end
print hash