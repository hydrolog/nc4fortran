export LIBNAME=libnc4fortran
export STATIC=${LIBNAME}.a

export FPM_FFLAGS="-I/usr/include/ -I/usr/include/hdf5/serial"
export FPM_LDFLAGS="-L/usr/lib/x86_64-linux-gnu/ -L/usr/lib/x86_64-linux-gnu/hdf5/serial"
fpm install --prefix ./. --profile release

cd lib && gfortran -shared -o ${LIBNAME}.so -Wl,--whole-archive ${STATIC} -Wl,--no-whole-archive

#--flag "`nf-config --fflags`"
