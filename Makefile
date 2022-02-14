.PHONY: all test run setup

run:
	@mix run -e "DRR.run()"

setup:
	@asdf 2>/dev/null|| echo "Please install asdf first: https://asdf-vm.com/" && exit 1
	asdf install
	mix local.hex --if-missing
	mix local.rebar --if-missing
	mix deps.get
	MIX_ENV=dev mix compile
	MIX_ENV=test mix compile

test:
	@mix test