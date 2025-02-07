# frozen_string_literal: true

require 'prime'

class RSAKeygen
  def initialize(prime_p, prime_q)
    raise 'Both p and q must be prime' unless prime_p.prime? && prime_q.prime?

    @prime_p = prime_p
    @prime_q = prime_q
  end

  def private_key
    @private_key ||= [private_exponent_d, modulus_n]
  end

  def public_key
    @public_key ||= [public_exponent_e, modulus_n]
  end

  private

  attr_accessor :prime_p, :prime_q

  def modulus_n
    @modulus_n ||= prime_p * prime_q
  end

  def totient
    @totient ||= (prime_p - 1).lcm(prime_q - 1)
  end

  def public_exponent_e
    @public_exponent_e ||= 3.upto(totient).find do |attempt|
      attempt.prime? && totient % attempt != 0
    end
  end

  def modular_multiplicative_inverse(a, m)
    raise "#{a} and #{m} are not coprime" unless a.gcd(m) == 1
    return m if m == 1

    m0, inv, x0 = m, 1, 0
    while a > 1
      inv -= (a / m) * x0
      a, m = m, a % m
      inv, x0 = x0, inv
    end
    inv += m0 if inv < 0
    inv
  end

  def private_exponent_d
    @private_exponent_d ||= modular_multiplicative_inverse(public_exponent_e, totient)
  end
end
