max2(X,Y,X) :- X>Y.
max2(X,Y,Y) :- X=<Y.

# max1(X,Y,X) :- X>Y, !.
# max1(_X,Y,Y).