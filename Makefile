postgres:
	docker run --name postgres_latest -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:latest
inspect:
	docker exec -it postgres_latest /bin/sh
createdb:
	docker exec -it postgres_latest createdb --username=root --owner=root simple_bank
dropdb:
	docker exec -it postgres_latest dropdb --username=root --owner=root simple_bank
migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up
migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down
sqlc:
	sqlc generate

test:
	go test -v -cover ./...

.PHONY: postgres inspect createdb dropdb migrateup migratedown sqlc