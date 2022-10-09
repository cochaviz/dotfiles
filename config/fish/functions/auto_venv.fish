function auto_venv --description 'automatically activate venv (non-virtualfish)' --on-variable PWD

status --is-command-substitution; and return

    functions -q deactivate; and deactivate

    test -f .venv/bin/activate.fish; and source .venv/bin/activate.fish

end
