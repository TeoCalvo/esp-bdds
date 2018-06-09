from multiprocessing import Process

def f(name):
	print( "Ola " + name )

if __name__ == "__main__":
	p = Process(target = f, args=('bob filho',))
	
	f("Bob pai")

	p.start()
	p.join()