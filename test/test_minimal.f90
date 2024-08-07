program test_minimal

use netcdf, only : nf90_create, nf90_def_var, nf90_put_var, nf90_close, NF90_CLOBBER, NF90_NETCDF4, NF90_INT

implicit none (type, external)

integer :: i, file_id, varid
character(*), parameter :: filename='test/data/test_minimal.nc'

i = nf90_create(filename, ior(NF90_CLOBBER, NF90_NETCDF4), file_id)
if (i/=0) error stop 'minimal: could not create file'
print *, 'minimal: created '// filename

i = nf90_def_var(file_id, 'x', NF90_INT, varid=varid)
i = nf90_put_var(file_id, varid, 42)
if (i/=0) error stop 'minimal: could not create variable'
print *, 'minimal: created variable'

i = nf90_close(file_id)
if (i/=0) error stop 'minimal: could not close file'
print *, 'minimal: closed '// filename

! this is a Fortran-standard way to delete files
open(newunit=i, file=filename)
close(i, status='delete')

end program
