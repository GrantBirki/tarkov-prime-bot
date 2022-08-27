run:
	@echo "\033[0;34m[#] Killing old docker processes\033[0m"
	docker-compose down -v -t 1

	@echo "\033[0;34m[#] Building docker container\033[0m"
	docker-compose up --build -d

	@echo "\e[32m[#] Container is now running!\e[0m"
