#My excursion into the IO Monad

I haven't had any real reason to do extensive input and output in Haskell,
so I decided to implement a command line applet with various file processing
capabilities. I spent a lot of time how I could structure it best so that I
could have a small piece of code backing a simple introduction process for
new features to it, so I made the Feature module. Basically, to add a feature,
you go into cmd.hs and create a function of type [String] -> IO (). This is a
function which takes command line inputs and does some IO action which returns
the empty type.
