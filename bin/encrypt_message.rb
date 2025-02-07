# frozen_string_literal: true

require_relative '../rsa_crypto'

message = ARGV[0]
exponent = ARGV[1].to_i
modulus = ARGV[2].to_i

encrypted = RSACrypto.encrypt(message, exponent, modulus)
puts '==='
puts "ENCRYPTED: [#{encrypted}]"
puts '==='
