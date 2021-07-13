postgres:
	docker run --name NewPostgres -p 5432:5432 -e POSTGRES_USER=root  -e POSTGRES_PASSWORD=secret -d postgres

createdb:
	docker exec -it NewPostgres createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it NewPostgres dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedowm:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate
	
.PHONY:
	postgres createdb dropdb migrateup migratedowm sqlc