ncgen test/example.cdl -o test/data/example.nc
fpm test --flag "`nf-config --fflags`"
