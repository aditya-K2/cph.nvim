# scratch script for installing dependencies
deps=(cqueues luaossl basexx lpeg lpeg_patterns binaryheap fifo compat53 http)
for i in "${deps[@]}"
do
	echo "sudo luarocks install $i --lua-version=5.1" &&
		sudo luarocks install "$i" --lua-version=5.1
done
