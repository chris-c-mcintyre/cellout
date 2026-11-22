(module

  ;; module imports

  ;; module global flags

  ;; module global variables

  ;; module functions

  (func (export "tiber")

    ;; inputs
    (param $x_siz i32) ;; width
    (param $y_siz i32) ;; height
    (param $z_siz i32) ;; depth
    (param $l_siz i32) ;; number of steps to take
    (param $l_beg i32) ;; current global step

    ;; outputs
    (result i32)

    ;; variables
    (local $l_cur i32)
    (local $l_end i32)

    ;; function

    (local.set $l_end (i32.add (local.get $l_beg) (local.get $l_siz)))

    ;; open l_loop
    (local.set $l_cur (local.get $l_beg))
    (loop $l_loop

      (call $dim_tri_inp_tet_box
        (local.get $x_siz)
        (local.get $y_siz)
        (local.get $z_siz)
        (local.get $l_cur)
      )

      ;; close l_loop
      (local.set $l_cur
        (i32.add
          (local.get $l_cur)
          (i32.const 1)
        )
      )
      (i32.lt_u
        (local.get $l_cur)
        (local.get $l_end)
      )
      (br_if $l_loop)
    )

    (local.get $l_cur)
  )

)
