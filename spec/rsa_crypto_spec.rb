# frozen_string_literal: true

require_relative '../rsa_keygen'
require_relative '../rsa_crypto'

describe RSACrypto do
  test_messages = [
    '0',
    'TEST_MESSAGE',
    'MY NAME IS FRED',
    '23iorfanv84809293nioafnkl'
  ]

  shared_examples :encrypts_decrypts_messages do
    test_messages.each do |message|
      it "private-encrypts and public-decrypts '#{message}'" do
        encrypted = RSACrypto.encrypt(message, private_key_exponent, shared_modulus)
        expect(encrypted).not_to eq(message)

        decrypted = RSACrypto.decrypt(encrypted, public_key_exponent, shared_modulus)
        expect(decrypted).to eq(message)
      end

      it "public-encrypts and private-decrypts '#{message}'" do
        encrypted = RSACrypto.encrypt(message, public_key_exponent, shared_modulus)
        expect(encrypted).not_to eq(message)

        decrypted = RSACrypto.decrypt(encrypted, private_key_exponent, shared_modulus)
        expect(decrypted).to eq(message)
      end
    end
  end

  context 'with a known good RSA key pair' do
    let(:shared_modulus) { 25777 }
    let(:private_key_exponent) { 3 }
    let(:public_key_exponent) { 16971 }

    include_examples :encrypts_decrypts_messages
  end

  context 'with generated key pairs' do
    primes = [757, 1033, 1609, 2243, 2383, 3209, 5867, 7121, 7877]

    primes.permutation(2).each do |arr|
      context "with primes [#{arr[0]}, #{arr[1]}]" do
        let!(:keys) { RSAKeygen.new(arr[0], arr[1]) }
        let(:shared_modulus) { keys.public_key[1] }
        let(:private_key_exponent) { keys.private_key[0] }
        let(:public_key_exponent) { keys.public_key[0] }

        include_examples :encrypts_decrypts_messages
      end
    end
  end
end
