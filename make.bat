@echo off

SET ARG=%1

IF "%ARG%"=="windows" (
  CALL :Windows
  GOTO Done
)

IF "%ARG%"=="unwindows" (
  CALL :Unwindows
  GOTO Done
)

IF "%ARG%"=="update" (
  CALL :Update
  GOTO Done
)

IF "%ARG%"=="fmt" (
  CALL :Fmt
  GOTO Done
)

IF "%ARG%"=="lint" (
  CALL :Lint
  GOTO Done
)

IF "%ARG%"=="remod" (
  del go.mod
  del go.sum
  go mod init github.com/edoardottt/scilla
  go get
  GOTO Done
)

IF "%ARG%"=="test" (
  CALL :Test
  GOTO Done
)

GOTO Done

:Test
set GO111MODULE=on
set CGO_ENABLED=0
echo Testing ...
go test -v ./...
echo Done
EXIT /B 0

:Fmt
set GO111MODULE=on
echo Formatting ...
go fmt ./...
echo Done.
EXIT /B 0

:Lint
golangci-lint run
EXIT /B 0

:Update
set GO111MODULE=on
echo Updating ...
go get -u
go mod tidy -v
echo Done.
EXIT /B 0

:Windows
set GOOS=windows
set GOARCH=amd64
set GO111MODULE=on
set CGO_ENABLED=0
go build go build ./cmd/scilla
echo Create keys.yaml file and add your keys there if you need them.
echo See https://github.com/edoardottt/scilla/wiki/Installation
echo Done.
EXIT /B 0

:Unwindows
del /f scilla.exe
echo Done.
EXIT /B 0

:Done