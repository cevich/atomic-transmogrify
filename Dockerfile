FROM registry.access.redhat.com/rhel7:latest
MAINTAINER cevich@redhat.com
# transmogrify.sh ignores hidden files under /
ENV HOST_ROOT="/.../host" \
    CNTR_ROOT="/.../cntr"
VOLUME ["${HOST_ROOT}", "${CNTR_ROOT}"]
ADD /transmogrify.sh /usr/sbin/
RUN chmod +x /usr/sbin/transmogrify.sh
WORKDIR /
# Command-line from docker run is exec'd at end of script
ENTRYPOINT ["/usr/sbin/transmogrify.sh"]
LABEL RUN="/usr/bin/docker\
       run -t -i --rm --privileged -v /:/.../host --net=host\
       --ipc=host --pid=host -e NAME=NAME -e IMAGE=IMAGE\
       IMAGE /.../cntr/usr/bin/bash"

ENV \
    # Relative paths from host's / to recursivly bind to containers /
    # Space separated
    HOSTDIRS="media run bin lib opt root \
              proc mnt sys usr dev var tmp home \
              sbin lib64 srv" \
    \
    # Relative paths from container's /, of files and/or directories
    # to be bind-mounted to / in container _after_ bind mounting
    # host directories (above).  Space separated.
    GRAFTS="etc usr/local"
