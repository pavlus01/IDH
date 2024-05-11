
up:
	docker build -t db-olimpics .
	docker run -p 1433:1433 -d db-olimpics