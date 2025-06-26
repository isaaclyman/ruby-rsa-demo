# frozen_string_literal: true

require_relative '../rsa_crypto'

def prompt(*args)
  print(*args)
  gets
end

exponent = ARGV[0].to_i
modulus = ARGV[1].to_i

puts "To do a key exchange, you'll need a friend to run this same script with you."
puts "You shouldn't be able to see each other's screens."
puts ''

puts 'Before you begin, you and your friend should choose two prime numbers.'
puts "You'll both use this same pair of numbers."
puts ''

p = prompt('Enter the first prime number: ').to_i
puts 'This is "p".'
puts ''

g = prompt('Enter the second prime number: ').to_i
puts 'This is "g".'
puts ''

secret_a = prompt('Choose a secret number which your friend does not know: ').to_i
puts 'This is "a". Do not share this value.'
puts ''

public_A = (g ** secret_a) % p

puts '==='
puts 'Calculating your public key "A"...'
puts "A = (g ** a) % p = #{public_A}"
puts "Share this value (#{public_A}) with the other party."
puts '==='
puts ''

public_B = prompt('Enter the public key your friend just shared with you: ').to_i
puts 'This is "B".'
puts ''

shared_key = (public_B ** secret_a) % p

puts '==='
puts 'Calculating your shared key...'
puts "(B ** a) % p = #{shared_key}"
puts "Your friend should have received the same key (#{shared_key})."
puts '==='
puts ''

puts 'Now you can use your shared key to encrypt and decrypt messages.'
puts "This key was never shared in public, and a third party who knows p, g, and both of your public A values won't easily be able to calculate it."
puts ''

puts "The end."