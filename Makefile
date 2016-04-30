cmd:
	ghc cmd.hs feature.hs

example:
	ghc example.hs feature.hs

clean:
	rm .*.swp *.hi *.o example cmd
