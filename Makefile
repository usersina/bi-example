#: --------------------------------------------------------------------------------------------
#: This Makefile defines the recipes used for this projects, which are used to start and stop
#: the compose containers in an easy to manage way.
#: 
# ---------------------------------------- Variables -----------------------------------------
#: ----------------------------------------- Commands -----------------------------------------
help:		#: Show this help
	@sed -ne '/@sed/!s/#: //p' $(MAKEFILE_LIST)

up:		#: Start all compose services in the compose directory
	docker compose -f ./compose/mariadb-stack-compose.yml up -d
	docker compose -f ./compose/elastic-stack-compose.yml up -d

down:		#: Safely stop the running compose services
	-docker compose -f ./compose/mariadb-stack-compose.yml down
	docker compose -f ./compose/elastic-stack-compose.yml down

delete:		#: Stop and delete all data volumes (cannot be reverted)
	-docker compose -f ./compose/mariadb-stack-compose.yml down --volumes
	docker compose -f ./compose/elastic-stack-compose.yml down --volumes
