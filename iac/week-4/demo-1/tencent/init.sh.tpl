#! /bin/bash
set -e
set -o noglob

# --- helper functions for logs ---
info() {
    echo '[INFO] ' "$@"
}
warn() {
    echo '[WARN] ' "$@" >$2
}
fatal() {
    echo '[ERROR] ' "$@" >$2
    exit 1
}

# --- define needed environment variables ---
setup_env() {
    # --- use sudo if we are not already root ---
    SUDO=sudo
    if [ $(id -u) -eq 0 ]; then
         SUDO=
    fi
}

# --- create a file with welcome content ---
create_welcome_file() {
    info "welcome to BJ"
    cd /tmp/
    $SUDO tee ${WELCOME_SH} >/dev/null <<EOF
#! /bin/bash
echo "welcome to BeiJing"
EOF
    $SUDO chmod 755 ${WELCOME_SH}
    $SUDO chown root:root ${WELCOME_SH}
    cd ~
}


# --- run the init process ---
{
    setup_env "$@"
    create_welcome_file
}