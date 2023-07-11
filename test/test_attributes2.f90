program test_attr2

use, intrinsic:: iso_fortran_env, only: int64, int32, real32, real64, stderr=>error_unit
use nc4fortran, only : netcdf_file

implicit none (type, external)

character(*), parameter :: filename = 'test/data/example.nc'

call test_read_attributes(filename)
print *,'PASSED: read attributes'

call test_write_attributes(filename)
print *,'PASSED: write attributes'

contains

subroutine test_read_attributes(path)

    type(netcdf_file) :: h
    character(*), intent(in) :: path
    character(len=80) :: attr_str
    
    call h%open(path, action='r')
    print *, h%filename
    
    call h%read_attribute('P', 'long_name', attr_str)
    print *, attr_str
    if (len_trim(attr_str) /= 24) error stop 'read_attribute   P:long_name' 
    
    call h%read_attribute('/','title', attr_str, -1)
    print *, attr_str
    if (len_trim(attr_str) /= 48) error stop 'read_global_attribute title'
    print *, attr_str
    
    call h%close()
    
end subroutine test_read_attributes
    
subroutine test_write_attributes(path)

type(netcdf_file) :: h
character(*), intent(in) :: path
character(len=80) :: attr_str

call h%open(path, action='rw')
call h%write_attribute('P', 'long_name', "pressure at max. wind")
call h%write_attribute('/', 'title', "NMC Global Product Set: Pressure at max. wind", 2 )
call h%close()

call h%open(path, action='rw')
print *, h%filename
call h%read_attribute('P', 'long_name', attr_str)
print *, attr_str
if (len_trim(attr_str) /= 21) error stop 'read/write var. attribute:  P:long_name' 
call h%read_attribute('/','title',  attr_str, 2)
print *, attr_str

if ( len_trim(attr_str) /= 45) error stop 'read/write global attribute :title'
print *, attr_str

call h%close()

call h%open(path, action='rw')
call h%write_attribute('P', 'long_name', "pressure at maximum wind")
call h%write_attribute('/', 'title', "NMC Global Product Set: Pressure at Maximun Wind", 2 )
call h%close()

end subroutine test_write_attributes

end program
