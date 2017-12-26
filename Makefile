.PHONY: dist docs

dist:
	rm -rf dist
	mkdir dist
	make dist_source
	make dist_docs
	make dist_examples

clean:
	rm -f ./examples/*.fbd
	rm -f ./examples/*.inp
	rm -f ./examples/*.geo
	rm -f ./examples/*.msh
	rm -f ./examples/*.frd
	rm -f ./examples/*.dat
	rm -f ./examples/*.png
	rm -f ./examples/*.cvg
	rm -f ./examples/*.sta
	rm -f ./examples/*.out
	rm -f *.fbd
	rm -f *.inp
	rm -f *.geo
	rm -f *.msh
	rm -f *.frd
	rm -f *.dat
	rm -f *.png
	rm -f *.cvg
	rm -f *.sta
	rm -f *.out

dist_examples:
	make clean_examples
	zip -r examples.zip examples
	mv examples.zip dist/

dist_docs:
	rm -rf docs
	rm -rf documentation
	sphinx-apidoc -F -A "Justin Black" -o docs pycalculix
	echo 'from pycalculix.version import __version__' >> docs/conf.py
	echo 'version = __version__' >> docs/conf.py
	echo 'release = version' >> docs/conf.py
	echo "extensions = ['sphinx.ext.autodoc'," >> docs/conf.py
	echo "    'sphinx.ext.napoleon'," >> docs/conf.py
	echo "    'sphinx.ext.todo'," >> docs/conf.py
	echo "    'sphinx.ext.viewcode']" >> docs/conf.py
	sphinx-build -b html docs documentation
	rm -R -f documentation/.doctrees
	zip -r documentation.zip documentation
	mv documentation.zip dist/
	rm -rf docs
	rm -rf documentation
	rm -rf build

dist_source:
	python3 setup.py sdist --formats=zip
	rm -rf *.egg-info

develop:
	python3 setup.py develop

install:
	python3 setup.py install

uninstall:
	pip3 uninstall pycalculix
