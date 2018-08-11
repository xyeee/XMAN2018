import gmpy2
import random
from Crypto.Util.number import getPrime
from Crypto.PublicKey import RSA


def generate_public_key():
    part1 = 754000048691689305453579906499719865997162108647179376656384000000000000001232324121
    part1bits = part1.bit_length()
    lastbits = 512 - part1.bit_length()
    part1 = part1 << lastbits
    part2 = random.randrange(1, 2**lastbits)
    p = part1 + part2
    while not gmpy2.is_prime(p):
        p = part1 + random.randrange(1, 2**lastbits)
    q = getPrime(512)
    n = p * q
    print p
    print q
    e = 0x10001
    key = RSA.construct((long(n), long(e)))
    key = key.exportKey()
    with open('public.pem', 'w') as f:
        f.write(key)


def encrypt():
    flag = open('./flag.txt').read().strip('\n')
    flag = flag.encode('hex')
    flag = int(flag, 16)
    with open('./public.pem') as f:
        key = RSA.importKey(f)
        enc = gmpy2.powmod(flag, key.e, key.n)
    with open('flag.enc', 'w') as f:
        f.write(hex(enc)[2:])


generate_public_key()
encrypt()
