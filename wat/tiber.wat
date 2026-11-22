(module

  ;; module imports

  ;; module global flags

  ;; module global variables

  ;; module functions

  (func $tet_box

    ;; inputs
    (param $upp_lef_loc i32)
    (param $upp_rig_loc i32)
    (param $dow_lef_loc i32)
    (param $dow_rig_loc i32)
    (param $i i32)

    ;; variables

    ;; function
  )

  (func $dim_duo_inp_tet_box

    ;;  m_mod ==         ;;  m_mod ==
    ;;  i_mod xor x_mod  ;;  i_mod xor x_mod

    ;;  i_mod == 0       ;;  i_mod == 1

    ;;  x_mod == 0       ;;  x_mod == 0
    ;;  y_mod == 0       ;;  y_mod == 0
    ;;  m_mod == 0       ;;  m_mod == 1

    ;;  [*] [ ]|[*] [ ]  ;;  [x]|[x] [x]|[x]
    ;;         |         ;;  ---|-------|---
    ;;  [ ] [ ]|[ ] [ ]  ;;  [x]|[*] [ ]|[x]
    ;;  -------|-------  ;;     |       |
    ;;  [*] [ ]|[*] [ ]  ;;  [x]|[ ] [ ]|[x]
    ;;         |         ;;  ---|-------|---
    ;;  [ ] [ ]|[ ] [ ]  ;;  [x]|[x] [x]|[x]

    ;;  x_mod == 0       ;;  x_mod == 0
    ;;  y_mod == 1       ;;  y_mod == 1
    ;;  m_mod == 0       ;;  m_mod == 1

    ;;  [*] [ ]|[*] [ ]  ;;  [x]|[x] [x]|[x]
    ;;         |         ;;  ---|-------|---
    ;;  [ ] [ ]|[ ] [ ]  ;;  [x]|[*] [ ]|[x]
    ;;  -------|-------  ;;     |       |
    ;;  [x]|[x]|[x]|[x]  ;;  [x]|[ ] [ ]|[x]

    ;;  x_mod == 1       ;;  x_mod == 1
    ;;  y_mod == 0       ;;  y_mod == 0
    ;;  m_mod == 1       ;;  m_mod == 0

    ;;  [*] [ ]|[x]      ;;  [x]|[x] [x]
    ;;         |         ;;  ---|-------
    ;;  [ ] [ ]|[x]      ;;  [x]|[*] [ ]
    ;;  -------|---      ;;     |
    ;;  [*] [ ]|[x]      ;;  [x]|[ ] [ ]
    ;;         |         ;;  ---|-------
    ;;  [ ] [ ]|[x]      ;;  [x]|[x] [x]

    ;;  x_mod == 1       ;;  x_mod == 1
    ;;  y_mod == 1       ;;  y_mod == 1
    ;;  m_mod == 1       ;;  m_mod == 0

    ;;  [*] [ ]|[x]      ;;  [x]|[x] [x]
    ;;         |         ;;  ---|-------
    ;;  [ ] [ ]|[x]      ;;  [x]|[*] [ ]
    ;;  -------|---      ;;     |
    ;;  [x] [x]|[x]      ;;  [x]|[ ] [ ]

    ;; inputs
    (param $point i32)
    (param $row_num i32)
    (param $row_siz i32)
    (param $i_mod i32)
    (param $x_mod i32)
    (param $y_mod i32)
    (param $i i32)

    ;; variables

    (local $m_mod i32)
    (local $stops i32)

    ;; function

    (local.set $m_mod (i32.xor (local.get $i_mod) (local.get $x_mod)))
    (local.set $stops (i32.add (local.get $point) (local.get $row_siz)))

    (local.get $i_mod)
    (if
      (then

        ;; cut lef col
        (local.set $point (i32.add (local.get $point) (i32.const 4)))

        ;; cut top row
        (local.set $point (i32.add (local.get $point) (local.get $row_siz)))
        (local.set $stops (i32.add (local.get $stops) (local.get $row_siz)))
        (local.set $row_num (i32.sub (local.get $row_num) (i32.const 1)))

        (local.get $x_mod)
        (if
          (then
            nop
          )
          (else
            ;; cut rig col
            (local.set $stops (i32.sub (local.get $stops) (i32.const 4)))
          )
        )

        (local.get $y_mod)
        (if
          (then
            nop
          )
          (else
            ;; cut bot row
            (local.set $row_num (i32.sub (local.get $row_num) (i32.const 1)))
          )
        )
      )
      (else

        (local.get $x_mod)
        (if
          (then
            ;; cut rig col
            (local.set $stops (i32.sub (local.get $stops) (i32.const 4)))
          )
          (else
            nop
          )
        )

        (local.get $y_mod)
        (if
          (then
            ;; cut bot row
            (local.set $row_num (i32.sub (local.get $row_num) (i32.const 1)))
          )
          (else
            nop
          )
        )

      )
    )

    ;; y_loop opens
    (loop $y_loop

      ;; x_loop opens
      (loop $x_loop

        (call $tet_box
          (local.get $point)
          (i32.add (local.get $point) (i32.const 4))
          (i32.add (local.get $point) (local.get $row_siz))
          (i32.add (i32.add (local.get $point) (local.get $row_siz)) (i32.const 4))
          (local.get $i)
        )

        ;; x_loop close

        (i32.lt_u
          (local.tee $point (i32.add (local.get $point) (i32.const 8)))
          (local.get $stops)
        )
        (br_if $x_loop)
      )

      ;; nex box row
      (local.set $point (i32.add (local.get $point) (local.get $row_siz)))
      (local.set $stops (i32.add (local.get $stops) (i32.mul (local.get $row_siz) (i32.const 2))))

      ;; cut lef col
      (local.set $point (i32.add (local.get $point) (i32.mul (i32.const 4) (local.get $i_mod))))

      ;; cut rig col
      (local.set $point (i32.add (local.get $point) (i32.mul (i32.const 4) (local.get $m_mod))))

      ;; y_loop close

      (i32.gt_u
        (local.tee $row_num (i32.sub (local.get $row_num) (i32.const 2)))
        (i32.const 0)
      )
      (br_if $y_loop)
    )
  )

  (func $dim_tri_inp_tet_box

    ;; inputs
    (param $x i32)
    (param $y i32)
    (param $z i32)
    (param $i i32)

    ;; variables

    (local $point i32)

    (local $curz i32)

    (local $modi i32)
    (local $modx i32)
    (local $mody i32)

    (local $sizx i32)
    (local $sizp i32)

    ;; function

    (local.set $modi
      (i32.rem_u
        (local.get $i)
        (i32.const 2)
      )
    )

    (local.set $modx
      (i32.rem_u
        (local.get $x)
        (i32.const 2)
      )
    )

    (local.set $mody
      (i32.rem_u
        (local.get $y)
        (i32.const 2)
      )
    )

    (local.set $sizx
      (i32.mul
        (local.get $x)
        (i32.const 4)
      )
    )

    (local.set $sizp
      (i32.mul
        (local.get $y)
        (local.get $sizx)
      )
    )

    (local.set $point (i32.const 0))

    ;; open z_loop
    (local.set $curz (i32.const 0))
    (loop $z_loop

      (call $dim_duo_inp_tet_box
        (local.get $point) ;; point
        (local.get $y)     ;; row_num
        (local.get $sizx)  ;; row_siz
        (local.get $modi)  ;; i_mod
        (local.get $modx)  ;; x_mod
        (local.get $mody)  ;; y_mod
        (local.get $i)     ;; i
      )

      (local.set $point (i32.add (local.get $point) (local.get $sizp)))

      ;; close z_loop
      (local.set $curz
        (i32.add
          (local.get $curz)
          (i32.const 1)
        )
      )
      (i32.lt_u
        (local.get $curz)
        (local.get $z)
      )
      (br_if $z_loop)
    )

  )

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
