# test against Monocypher on random input
`(== 64 64)
(seed (in "/dev/urandom" (rd 8)))
(de randL (N)
   (make (do N (link (rand 0 255)))) )
(de mono (M K)
   (let (ML (length M)  R)
      (native
         "libmonocypher.so"
         "crypto_poly1305"
         NIL
         '(R (16 B . 16))
         (ifn M 0 (cons NIL (cons ML) M))
         ML
         (cons NIL (32) K) )
      R ) )
(de poly53 (M K)
   (let (ML (length M)  R)
      (native
         "libpoly53.so.0"
         "crypto_onetimeauth_poly1305_53"
         NIL
         '(R (16 B . 16))
         (ifn M 0 (cons NIL (cons ML) M))
         ML
         (cons NIL (32) K) )
      R ) )
(for N (range 0 4096)
   (let (M (randL N)  K (randL 32))
      (test
         (mono M K)
         (poly53 M K) ) ) )
(msg 'ok)
(bye)
