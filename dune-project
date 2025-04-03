(lang dune 3.13)
(using coq 0.8)
(name rocq-test)
(source (github 4ever2/rocq-test))
(license MIT)
(authors "A")
(maintainers "A")

(package
 (name rocq-test)
 (synopsis "A")
 (description "A")
 (depends
   (ocaml (>= 4.10.0))
   (rocq-prover (>= "9.0~")))
   (allow_empty)
   )
