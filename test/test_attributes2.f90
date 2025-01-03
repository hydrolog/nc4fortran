program test_attr2

use, intrinsic:: iso_fortran_env, only: int64, int32, real32, real64, stderr=>error_unit
use nc4fortran, only : netcdf_file

implicit none (type, external)

character(*), parameter :: filename = 'test/data/example.nc'

call test_read_attributes(filename)
print *,'PASSED: read attributes 2'

call test_write_attributes(filename)
print *,'PASSED: write attributes 2'


contains

subroutine test_read_attributes(path)

    type(netcdf_file) :: h
    character(*), intent(in) :: path
    character(len=255) :: attr_str
    integer :: id_group
    
    id_group = 1
    call h%open(path, action='r')
    print *, h%filename
    
    call h%read_attribute('P', 'long_name', attr_str)
    print *, trim(attr_str)
    if (len_trim(attr_str) /= 24) error stop 'read_attribute   P:long_name' 
    
    call h%read_attribute('/','title', attr_str, id_group)
    print *, trim(attr_str)
    if (len_trim(attr_str) /= 48) error stop 'read_grp_attribute2 title'
    print *, len_trim(attr_str)
    if(id_group /= 1) error stop 'read_grp_attribute2 id_group'
    
    call h%close()
    
end subroutine test_read_attributes
    
subroutine test_write_attributes(path)

type(netcdf_file) :: h
character(*), intent(in) :: path
character(len=255) :: attr_str
integer :: id_group

id_group = 1

call h%open(path, action='rw')
call h%write_attribute('P', 'long_name', "pressure at max. wind")
call h%write_attribute('/', 'title', "NMC Global Product Set: Pressure at max. wind", id_group)
call h%close()

call h%open(path, action='rw')
print *, h%filename
call h%read_attribute('P', 'long_name', attr_str)
print *, trim(attr_str)
if (len_trim(attr_str) /= 21) error stop 'read/write var. attribute2:  P:long_name' 

call h%read_attribute('/', 'title', attr_str, id_group)
print *, trim(attr_str)
if ( len_trim(attr_str) /= 45) error stop 'read/write global attribute :title'

call h%close()

call h%open(path, action='rw')
call h%write_attribute('P', 'long_name', "pressure at maximum wind")
call h%write_attribute('/', 'title', "NMC Global Product Set: Pressure at Maximum Wind", id_group)
call h%close()

end subroutine test_write_attributes

end program
