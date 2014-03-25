threads 8,32
workers 3
preload_app!

pidfile "/tmp/puma/puma.pid"
state_path "/tmp/puma/puma.state"
bind "unix:///sites/indie88/sockets/puma.sock"
environment "production"
