eats(lion,goat).
eats(lion,deer).
eats(tiger,lamb).
eats(tiger,deer).
common(X,Y,Z):-eats(X,Z),eats(Y,Z).