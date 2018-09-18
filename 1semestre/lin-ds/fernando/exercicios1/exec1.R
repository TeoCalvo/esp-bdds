# 1)

uni1 = runif( 30, 0, 1 )
uni2 = runif( 30, -5, 5 )
uni3 = runif(30, 10, 500)

print(uni1)
print(uni2)
print(uni3)

# 2)

?"+"

# 3.

soma = function(x,y){
	return(x+y)
}
print(soma(10,100))

# 4)

dado = function( n_faces=6 ){
	return( sample( 1:n_faces ) )
}

# 5)

dados = function(n_faces1, n_faces2){
	d1 = sample( 1:n_faces1, 1 )
	d2 = sample( 1:n_faces2, 1 )
	return(c(d1,d2))
}