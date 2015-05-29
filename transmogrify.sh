#!/bin/sh

echo -e "\nRecursivly bind mounting /* to ${CNTR_ROOT}"
mount --bind / "${CNTR_ROOT}"

# Names relative to "${HOST_ROOT}"
cd "${HOST_ROOT}"
for DIR in $HOSTDIRS
do
    echo "Recursivly bind mounting "${HOST_ROOT}/$DIR" to /$DIR"
    mount --rbind "${HOST_ROOT}/$DIR" "/$DIR"
done

for THING in $GRAFTS
do
    echo "Bind mounting "${CNTR_ROOT}/$THING" to /$THING"
    mount --bind "${CNTR_ROOT}/$THING" "/$THING"
done

echo -e "Executing $@\n"
cd /
exec $@
