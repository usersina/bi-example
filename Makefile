#: ----------------------------------------- Variables -----------------------------------------
#: COMPOSE_FILE: The path to the compose file to use when running the commands
COMPOSE_FILE = docker-compose.yml

#: ----------------------------------------- Commands -----------------------------------------
help:		#: Show this help
	@sed -ne '/@sed/!s/#: //p' $(MAKEFILE_LIST)

up:		#: Start the services in the compose file
	$(VARS) docker compose -f ${COMPOSE_FILE} up -d

down:		#: Safely stop the services
	$(VARS) docker compose -f ${COMPOSE_FILE} down

delete:		#: Stop and delete all data volumes (cannot be reverted)
	$(VARS) docker compose -f ${COMPOSE_FILE} down --volumes
