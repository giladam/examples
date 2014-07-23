
# Tails a log, but pipes the output to perl to replace ERROR lines with color coded versions of them.

tail -f /opt/example/log/application.log | perl -pe 's/.*ERROR.*/\e[1;31m$&\e[0m/g'