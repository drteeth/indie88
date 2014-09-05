threads 8,32
workers 3
preload_app!

pidfile "/sites/indie88.monkeyhouse.ca/shared/tmp/puma/puma.pid"
state_path "/sites/indie88.monkeyhouse.ca/shared/tmp/puma/puma.state"
bind "unix:///sites/indie88.monkeyhouse.ca/shared/sockets/puma.sock"
environment "production"
