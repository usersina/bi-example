#: ----------------------------------------- Commands -----------------------------------------
help:		#: Show this help
	@sed -ne '/@sed/!s/#: //p' $(MAKEFILE_LIST)

up:		#: Start the services in the compose file
	$(VARS) docker compose up -d

down:		#: Safely stop the services
	$(VARS) docker compose down

delete:		#: Stop and delete all data volumes (cannot be reverted)
	$(VARS) docker compose down --volumes
