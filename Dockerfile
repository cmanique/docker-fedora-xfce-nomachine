FROM fedora:31

# get a slightly lighter version of xfce that actually works and some common tools for development and troubleshooting
# certainly can be made skinnier, in due time
RUN yum update -y && yum install -y \
    abrt-desktop \
    adwaita-gtk2-theme \
    adwaita-icon-theme \
    alsa-utils \
    firewall-config \
    gnome-keyring-pam \
    gtk-xfce-engine \
    gvfs \
    gvfs-archive \
    gvfs-mtp \
    initial-setup-gui \
    lightdm-gtk \
    openssh-askpass \
    thunar \
    thunar-archive-plugin \
    thunar-media-tags-plugin \
    thunar-volman \
    tumbler \
    xdg-user-dirs-gtk \
    xfce4-about \
    xfce4-appfinder \
    xfce4-datetime-plugin \
    xfce4-panel \
    xfce4-places-plugin \
    xfce4-power-manager \
    xfce4-pulseaudio-plugin \
    xfce4-screenshooter-plugin \
    xfce4-session \
    xfce4-settings \
    xfce4-taskmanager \
    xfce4-terminal \
    xfconf \
    xfdesktop \
    xfwm4 \
    xfwm4-themes \
    xscreensaver-base \
    wget \
    curl \
    tcpdump \
    vim-enhanced \
    net-tools \
    procps-ng \
    openssh-clients \
    geany \
    && yum clean all

# workaround the fact that not all distros generate a machine-id when running inside container
# prevent dbus failures for lack of /var/run/dbus
RUN mkdir -p /var/lib/dbus && dbus-uuidgen > /var/lib/dbus/machine-id && mkdir -p /var/run/dbus

# install nomachine
RUN curl -fSL "https://download.nomachine.com/download/6.9/Linux/nomachine_6.9.2_1_x86_64.rpm" -o nomachine.rpm && \
    rpm -i nomachine.rpm && \
    rm -rf nomachine.rpm

# add a user to access our desktop env
RUN groupadd -r nomachine -g 10001 && \
    useradd nomachine -u 10000 -g nomachine -d /home/nomachine -m -s /bin/bash && \
    echo 'nomachine:nomachine' | chpasswd

# add user to suduoers
RUN echo "nomachine ALL=(ALL) NOPASSWD: ALL" > "/etc/sudoers.d/nomachine" && \
    chmod 440 "/etc/sudoers.d/nomachine"

# make systemctl not go into graphical mode
RUN ln -s /lib/systemd/system/systemd-logind.service /etc/systemd/system/multi-user.target.wants/systemd-logind.service
RUN systemctl set-default multi-user.target

# TODO
# less hardcoding
# create a service for nomachine server
# how to achieve graceful shutdown with this configuration (prob sigterm)

ENTRYPOINT ["/sbin/init"]
