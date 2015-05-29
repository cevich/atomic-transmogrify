Container with fine-grain control over filesystem layout
---------------------------------------------------------------------

This container is intended to run on Red Hat Enterprise Linux Atomic Host.
However, by chaning the FROM line in the Dockerfile, it should work with
nearly any other distribution.  It's purpose is to allow control over which
parts of the host and/or container filesystems are represented.  This is
useful in situations where you want some parts of the filesystem to stick
with the container and others to always come from the host.

#.  ``docker build -t transmogrify https://github.com/cevich/atomic-transmogrify.git``
#.  ``atomic run transmogrify``

Notes:

*  More info on the ``atomic`` command and Project Atomic can be found at
   https://github.com/projectatomic/atomic

*  Any changes to parts of the filesystem coming from ``HOSTDIRS`` which
   depend on ``GRAFTS`` could cause things to break on the host!
   **BE CAREFUL**, understand what your are doing/changing *before*
   you commit!

*  Instead of atomic, start the container with different
   options by hand.  For example, to modify ``GRAFTS`` or execute
   a different program:

        ``/usr/bin/docker run -t -i --rm``
        ``--privileged --net=host --ipc=host --pid=host``
        ``-e GRAFTS="etc tmp root" -v /:/.../host``
        ``transmogrify``
        ``/root/bin/utility.sh --command line --options here``
