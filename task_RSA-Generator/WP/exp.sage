#!/usr/bin/env sage -python
# -*- coding: utf-8 -*- 
from sage.all import *
import binascii
n = 0x639386F4941D1511D89A9D19DC4731188D3F4D2D04623FB26F5A85BB3A54747BCBADCDBD8E4A75747DB4072A90F62DCA08F11AC276D7588042BEFA504DCD87CD3B0810F1CB28168A53F9196CDAF9FD1D12DCD4C375EB68B67A8EFCCEC605C57C736943170FEF177175F696A0F6123B993E56FFBF1B62435F728A0BAC018D0113


cipher = 0x56c5afbc956157241f2d4ea90fd24ad58d788ca1fa2fddb9084197cfc526386d223f88be38ec2e1820c419cb3dad133c158d4b004ae0943b790f0719b40e58007ba730346943884ddc36467e876ca7a3afb0e5a10127d18e3080edc18f9fbe590457352dca398b61eff93eec745c0e49de20bba1dd77df6de86052ffff41247d
e2 = 0x10001
pbits = 512
for i in range(0,4095):
  p4 = 0x635c3782d43a73d70465979599f65622c7b4242a2d623459337100000000004973c619000
  p4=p4+int(hex(i),16)
  print hex(p4)
  kbits = pbits - p4.nbits()  #未知需要爆破的比特位数
  print p4.nbits()
  p4 = p4 << kbits
  PR.<x> = PolynomialRing(Zmod(n))
  f = x + p4
  roots = f.small_roots(X=2^kbits, beta=0.4) #进行爆破
  #rint roots
  if roots:        #爆破成功，求根
    p = p4+int(roots[0])
    print "p: ", hex(int(p))
    assert n % p == 0
    q = n/int(p)
    print "q: ", hex(int(q))
    print gcd(p,q)
    phin = (p-1)*(q-1)
    print gcd(e2,phin)
    d = inverse_mod(e2,phin)
    flag = pow(cipher,d,n)
    flag = hex(int(flag))[2:-1]
    print binascii.unhexlify(flag)
