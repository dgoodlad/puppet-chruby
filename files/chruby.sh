export CHRUBY_ROOT="${BOXEN_HOME}/chruby"

# chruby looks for rubies by default in $PREFIX/opt/rubies
PREFIX="${CHRUBY_ROOT}" source "${CHRUBY_ROOT}/share/chruby/chruby.sh"
