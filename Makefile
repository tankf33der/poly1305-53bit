all:
	gcc -fPIC -c auth.c -o auth.o
	gcc -shared -Wl,-soname,libpoly53.so.0 -o libpoly53.so.0 auth.o -lc
	sudo cp -uf libpoly53.so.0 /usr/local/lib
	sudo ldconfig
clean:
	rm -rf *.o *.0
