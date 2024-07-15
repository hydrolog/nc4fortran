export FPM_FFLAGS="-I/usr/include/ -I/usr/include/hdf5/serial"
export FPM_LDFLAGS="-L/usr/lib/x86_64-linux-gnu/ -L/usr/lib/x86_64-linux-gnu/hdf5/serial"
fpm build --profile release

#--flag "`nf-config --fflags`"
