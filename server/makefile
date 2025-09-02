PRISMA = npx prisma

g-mns:
ifeq ($(name),)
	@echo "use name as params"
else
	nest g module $(name)
	nest g controller $(name)
	nest g service $(name)
endif
#Prisma
#make migrate
migrate:
	$(PRISMA) migrate dev

#make reset
reset:
	$(PRISMA) migrate reset

#make seed
seed:
	$(PRISMA) db seed

rns:
	make reset && make seed

#make gen
gen:
	$(PRISMA) generate

mgs:
	make migrate && make seed

dev:
	npm run start:dev
