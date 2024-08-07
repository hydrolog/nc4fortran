program test_shape
!! This program shows how netcdf dimension orders are distinct in different languages
use nc4fortran, only: netcdf_file, is_netcdf, NF90_MAX_NAME
use, intrinsic:: iso_fortran_env, only: real64, stdout=>output_unit, stderr=>error_unit

implicit none (type, external)

character(*), parameter :: fn = 'test/data/test_shape.nc'


call test_shape_write(fn)

call test_shape_read(fn)
print *, "OK: test_shape"


contains


subroutine test_shape_write(fn)

character(*), intent(in) :: fn

type(netcdf_file) :: h
integer :: d2(3,4), d7(2,1,3,4,7,6,5)

call h%open(fn, action='w')
call h%write('d2', d2)
call h%write('d7', d7, dims=['x','y','z', 'p','q','r','s'])
call h%close()

end subroutine test_shape_write


subroutine test_shape_read(fn)

character(*), intent(in) :: fn

type(netcdf_file) :: h
character(NF90_MAX_NAME), allocatable :: dimnames(:)
integer, allocatable :: dims(:)
integer :: d2(3,4), d7(2,1,3,4,7,6,5)

call h%open(fn, action='r')
call h%shape('d2', dims)
if (h%ndim('d2') /= size(dims)) error stop 'rank /= size(dims)'
if (any(dims /= shape(d2))) error stop '2-D: file shape not match variable shape'

call h%shape('d7', dims, dimnames)
if (h%ndim('d7') /= size(dims)) error stop 'rank /= size(dims)'
if (any(dims /= shape(d7))) error stop '7-D: file shape not match variable shape'

call h%close()

end subroutine test_shape_read

end program
