install:
	pip3 install --upgrade pip &&\
		pip3 install -r requirements.txt

test:
	python3 -m pytest -vv --nbval -cov=mylib -cov=main test_*.py *.ipynb

format:	
	black *.py 

lint:
	ruff check *.py mylib/*.py test_*.py *.ipynb

container-lint:
	docker run --rm -i hadolint/hadolint < Dockerfile

refactor: format lint

deploy:
	#deploy goes here


generate:
	python main.py
	git config --local user.email "action@github.com"
	git config --local user.name "GitHub Action"
	git add .
	git commit -m "test"
	git push
all: install lint test format deploy
