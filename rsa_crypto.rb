# frozen_string_literal: true

class RSACrypto
  class << self
    def encrypt(message, exponent, modulus)
      message.bytes.map { |b| crypt_byte(b, exponent, modulus) }.join
    end

    def decrypt(message, exponent, modulus)
      message.chars.each_slice(modulus.to_s.size).map do |arr|
        # Equivalent to `(arr.join.to_i ** exponent) % modulus`, but WAY faster
        arr.join.to_i.pow(exponent, modulus)
      end.pack('c*')
    end

    private

    def crypt_byte(byte, exponent, modulus)
      # Equivalent to `crypted = ((byte.to_i ** exponent) % modulus).to_s`
      crypted = byte.to_i.pow(exponent, modulus).to_s
      missing_chars = modulus.to_s.size - crypted.size
      '0' * missing_chars + crypted
    end
  end
end
