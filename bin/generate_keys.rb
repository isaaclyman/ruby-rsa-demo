# frozen_string_literal: true

require_relative '../rsa_keygen'

# https://en.wikipedia.org/wiki/List_of_prime_numbers
prime1 = ARGV[0].to_i
prime2 = ARGV[1].to_i

keys = RSAKeygen.new(prime1, prime2)
puts '==='
puts "PRIVATE: #{keys.private_key}"
puts '==='
puts "PUBLIC: #{keys.public_key}"
puts '==='
