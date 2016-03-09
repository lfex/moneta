PROJECT = mnesia-tutorial

compile:
	rebar3 compile

check:
	@rebar3 eunit

repl: compile
	@lfe

shell:
	@rebar3 shell

clean:
	@rebar3 clean
	@rebar3 lfe clean
