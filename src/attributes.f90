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
  integer :: ier, xtype_, len_, attnum_
  character(len=80) :: attname_
  
  if (attrnum>0) then
    attnum_= attrnum
    ier = nf90_inq_attname(self%file_id, NF90_GLOBAL, attnum_, attname_)
    attname_ = trim(attname_)
    print *, "Global attribute info = ", attname_, attnum_
  else
    ier = nf90_inquire_attribute(self%file_id, NF90_GLOBAL, attrname, xtype_, len_, attnum_)
    if (attnum_==0) ier=0 
    ! create new attribute
    print *, "Global attribute info = ", attrname, xtype_, len_, attnum_
  endif

  if(ier == nf90_noerr) then
    select type(A)
    type is (character(*))
      ier = nf90_put_att(self%file_id, NF90_GLOBAL, attrname, A)
    type is (real(real32))
      ier = nf90_put_att(self%file_id, NF90_GLOBAL, attrname, A)
    type is (real(real64))
      ier = nf90_put_att(self%file_id, NF90_GLOBAL, attrname, A)
    type is (integer(int32))
      ier = nf90_put_att(self%file_id, NF90_GLOBAL, attrname, A)
    class default
      ier = NF90_EBADTYPE
    end select
  endif

  if (check_error(ier, grp_name)) error stop 'nc4fortran:attributes: failed to write ' // attrname
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
  integer :: ier, xtype_, len_, attnum_
  character(len=80) :: attname_

  if (attrnum>0) then
    attnum_ = attrnum
    ier = nf90_inq_attname(self%file_id, NF90_GLOBAL, attnum_, attname_)
    attname_ = trim(attname_)
    print *, "Global attribute info = ", attname_, attnum_
  else
    ier = nf90_inquire_attribute(self%file_id, NF90_GLOBAL, attrname, xtype_, len_, attnum_)
    print *, "Global attribute info = ", attrname, xtype_, len_, attnum_
  endif

  if(ier == nf90_noerr) then
    select type(A)
    type is (character(*))
      ier = nf90_get_att(self%file_id, NF90_GLOBAL, attrname, A)
    type is (real(real32))
      ier = nf90_get_att(self%file_id, NF90_GLOBAL, attrname, A)
    type is (real(real64))
      ier = nf90_get_att(self%file_id, NF90_GLOBAL, attrname, A)
    type is (integer(int32))
      ier = nf90_get_att(self%file_id, NF90_GLOBAL, attrname, A)
    class default
      ier = NF90_EBADTYPE
    end select
  endif

  if (check_error(ier, grp_name)) error stop 'nc4fortran:attributes: failed to read ' // attrname
end procedure nc_read_grp_attr    

end submodule attributes
