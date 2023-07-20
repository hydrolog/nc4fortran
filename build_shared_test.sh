fpm build --flag "`nf-config --fflags` -Wall -Wextra -Wimplicit-interface -fPIC -fmax-errors=1 -g -fcheck=bounds -fcheck=array-temps -fbacktrace -shared" 
gfortran build/gfortran_3DE9BC4DD362A46B/nc4fortran/src_*.f90.o -L/home/nilocj/mambaforge/envs/f90/lib/python3.11/config-3.11-x86_64-linux-gnu -L/home/nilocj/mambaforge/envs/f90/lib -Wall -Wextra -Wimplicit-interface -shared -fPIC -fmax-errors=1 -g -fcheck=bounds -fcheck=array-temps -fbacktrace -lpython3.11 -lpthread -ldl -lutil -lrt -lm -shared -o build/libnc4fortran.so
cp build/gfortran_3DE9BC4DD362A46B/*.mod build/.
cp $CONDA_PREFIX/include/netcdf*.mod build/.
