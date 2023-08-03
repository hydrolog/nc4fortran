submodule (nc4fortran) attributes

implicit none (type, external)

contains

module procedure nc_write_var_attr
  integer :: varid, ier

  ier = nf90_inq_varid(self%file_id, dname, varid)
  print *, "Attribute varid = ", varid

  if(ier == nf90_noerr) then
    select type(A)
    type is (character(*))
      ier = nf90_put_att(self%file_id, varid, attrname, A)
    type is (real(real32))
      ier = nf90_put_att(self%file_id, varid, attrname, A)
    type is (real(real64))
      ier = nf90_put_att(self%file_id, varid, attrname, A)
    type is (integer(int32))
      ier = nf90_put_att(self%file_id, varid, attrname, A)
    class default
      ier = NF90_EBADTYPE
    end select
  endif

  if (check_error(ier, dname)) error stop 'nc4fortran:attributes: failed to write ' // attrname
end procedure nc_write_var_attr

module procedure nc_write_grp_attr
  integer :: ier, grpid_, len_, xtype_, len_, attnum_
  character(len=255) ::  grpname_, attname_

  grpname_ = trim(grpname)
  attname_ = trim(attrname)
  grpid_ = NF90_GLOBAL
  if (grpid>1) then
   grpid_ = grpid
   ier = nf90_inq_ncid(self%file_id, grpname_, grpid_)
  endif

  ier = nf90_inquire_attribute(self%file_id, grpid_, attname_, xtype_, len_, attnum_)
  print *, "Group attribute info = ", grpname_, grpid_, attname_, xtype_, len_, attnum_

  if(ier == nf90_noerr) then
    select type(A)
    type is (character(*))
      ier = nf90_put_att(self%file_id, grpid_, attname_, A)
    type is (real(real32))
      ier = nf90_put_att(self%file_id, grpid_, attname_, A)
    type is (real(real64))
      ier = nf90_put_att(self%file_id, grpid_, attname_, A)
    type is (integer(int32))
      ier = nf90_put_att(self%file_id, grpid_, attname_, A)
    class default
      ier = NF90_EBADTYPE
    end select
  endif

  if (check_error(ier, grpname_)) error stop 'nc4fortran:attributes: failed to write ' // attrname
end procedure nc_write_grp_attr

module procedure nc_read_var_attr
  integer :: varid, ier

  ier = nf90_inq_varid(self%file_id, dname, varid)
  print *, "Attribute varid = ", varid

  if(ier == nf90_noerr) then
    select type (A)
    type is (character(*))
      ier = nf90_get_att(self%file_id, varid, attrname, A)
    type is (real(real32))
      ier = nf90_get_att(self%file_id, varid, attrname, A)
    type is (real(real64))
      ier = nf90_get_att(self%file_id, varid, attrname, A)
    type is (integer(int32))
      ier = nf90_get_att(self%file_id, varid, attrname, A)
    class default
      ier = NF90_EBADTYPE
    end select
  endif

  if (check_error(ier, dname)) error stop 'nc4fortran:attributes: failed to read ' // attrname
end procedure nc_read_var_attr


module procedure nc_read_grp_attr
  integer :: ier, grpid_, len_, xtype_, len_, attnum_
  character(len=255) ::  grpname_, attname_

  grpname_ = trim(grpname)
  attname_ = trim(attrname)
  grpid_ = NF90_GLOBAL
  if (grpid>1) then
   grpid_ = grpid
   ier = nf90_inq_ncid(self%file_id, grpname_, grpid_)
  endif

  ier = nf90_inquire_attribute(self%file_id, grpid_, attname_, xtype_, len_, attnum_)
  print *, "Group attribute info = ", grpname_, grpid_, attname_, xtype_, len_, attnum_

  if(ier == nf90_noerr) then
    select type(A)
    type is (character(*))
      ier = nf90_get_att(self%file_id, grpid_, attname_, A)
    type is (real(real32))
      ier = nf90_get_att(self%file_id, grpid_, attname_, A)
    type is (real(real64))
      ier = nf90_get_att(self%file_id, grpid_, attname_, A)
    type is (integer(int32))
      ier = nf90_get_att(self%file_id, grpid_, attname_, A)
    class default
      ier = NF90_EBADTYPE
    end select
  endif

  if (check_error(ier, grpname_)) error stop 'nc4fortran:attributes: failed to read ' // attrname
end procedure nc_read_grp_attr

end submodule attributes
