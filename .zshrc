
alias gotestfiles='go test -coverprofile=/tmp/coverage.out ./... && go tool cover -func=/tmp/coverage.out'
