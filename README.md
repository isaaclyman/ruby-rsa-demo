# ruby-rsa-demo

This repo is a lightweight demonstration of RSA cryptography principles in pure Ruby. It should never be used in production, as it's not intended to be complete or correct.

## Setup

Run `bundle` to install `prime` and `rspec`.

## Usage

### Generation

To generate an RSA key pair from any two prime numbers:

`ruby bin/generate_keys.rb 1669 563`

The output is two keys (one private, one public) in the format `[exponent, modulus]`.

- Any message encrypted by the public key can be decrypted by the private key.
- Any message encrypted by the private key can be decrypted by the public key.
- A message encrypted by either key _cannot_ be decrypted by the same key.
- Someone who only has the public key _cannot_ calculate the private key (at least, not in a reasonable amount of time).

That's the magic of asymmetric encryption.

### Encryption

To encrypt a message, the arguments are `message exponent modulus`:

`ruby bin/encrypt_message.rb "my secret message" 281225 939647`

The output is numeric. Each byte is represented by a block with the same string length as the modulus, padded on the left side with `0`.

### Decryption

To decrypt a message, the arguments are `encrypted exponent modulus`:

`ruby bin/decrypt_message.rb 683538910191000002376671677984490957519094677984670731000002683538677984376671376671142734173253677984 5 939647`

The output should be the original message.

## Tests

Run `rspec` to run the test suite.