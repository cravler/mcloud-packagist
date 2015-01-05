FROM cravler/packagist
MAINTAINER Sergei Vizel <http://github.com/cravler>

# Allow ssh-git
ADD ssh/id_rsa /.ssh/id_rsa
RUN echo "    IdentityFile /.ssh/id_rsa" >> /etc/ssh/ssh_config && \
    echo "    StrictHostKeyChecking no" >> /etc/ssh/ssh_config && \
    echo "    UserKnownHostsFile=/dev/null" >> /etc/ssh/ssh_config && \
    chmod go-rwx -R /.ssh