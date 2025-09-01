.PHONY: gen-module gen-controller gen-service dev

gen-module:
	@read -p "Enter module name: " name; \
	nest g module $$name

gen-controller:
	@read -p "Enter controller name: " name; \
	nest g controller $$name

gen-service:
	@read -p "Enter service name: " name; \
	nest g service $$name

dev:
	npm run start:dev
