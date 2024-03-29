# import relevant configurations from relevant files if they exist
for file in $ZDOTDIR/.{zsh_prompt,zsh_profile,aliases,environment_vars}
do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done
unset file

# set PATH so it includes user's private ~/.local/bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# add cargo and other rust tools to path
PATH="$XDG_DATA_HOME/cargo/bin:$PATH"

# add pyenv to path
PATH="$PYENV_ROOT/bin:$PATH"

pokemon-colorscripts -r

eval "$(pyenv init -)"

PATH=$PATH:"$(go env GOPATH)/bin"
