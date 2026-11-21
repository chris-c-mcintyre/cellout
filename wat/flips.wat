(module

  ;; args

  ;; 0 : l_beg : memory block start index
  ;; 1 : l_siz : memory block size in bytes
  ;; 2 : l_cha : number of bytes per cell (generally equivalent to number of colour channels per pixel)

  ;; invert value in indicated cells

  (func (export "flips") (param $l_beg i32) (param $l_siz i32) (param $l_cha i32) (result i32)

    ;; declares

    (local $l_cur i32)
    (local $l_end i32)
    (local $l_mid i32)
    (local $l_out i32)

    ;; assigns

    ;; open l_loop
    (local.set $l_end
      (i32.add (local.get $l_beg) (local.get $l_siz))
    )
    (local.set $l_cur
      (local.get $l_beg)
    )
    (loop $l_loop

      (local.set $l_mid (i32.load (local.get $l_cur)))

      (local.set $l_out
        (i32.xor
          (local.get $l_mid)
          (i32.const 0xffffffff)
        )
      )

      (i32.store
        (local.get $l_cur)
        (local.get $l_out)
      )

      ;; close l_loop
      (local.set $l_cur
        (i32.add
          (local.get $l_cur)
          (local.get $l_cha)
        )
      )
      (i32.lt_u
        (local.get $l_cur)
        (local.get $l_end)
      )
      (br_if $l_loop)
    )

    ;; returns

    (i32.const 0)
  )

  ;; args for flips_--- functions

  ;; 0 : l_beg : memory block start index
  ;; 1 : l_siz : memory block size in bytes
  ;; 2 : l_cha : number of bytes per cell (generally equivalent to number of colour channels per pixel)
  ;; 3 : l_--- : internal index of element position to be altered

  ;; invert bit position in indicated cells

  (func (export "flips_bit") (param $l_beg i32) (param $l_siz i32) (param $l_cha i32) (param $l_bit i32) (result i32)

    ;; declares

    (local $l_cur i32)
    (local $l_end i32)
    (local $l_mid i32)
    (local $l_out i32)

    (local $l_mas i32)

    ;; assigns

    (local.set $l_mas
      (i32.shl (i32.const 1) (local.get $l_bit))
    )

    ;; open l_loop
    (local.set $l_end
      (i32.add (local.get $l_beg) (local.get $l_siz))
    )
    (local.set $l_cur
      (local.get $l_beg)
    )
    (loop $l_loop

      (local.set $l_mid (i32.load (local.get $l_cur)))

      (local.set $l_out
        (i32.xor
          (local.get $l_mid)
          (local.get $l_mas)
        )
      )

      (i32.store
        (local.get $l_cur)
        (local.get $l_out)
      )

      ;; close l_loop
      (local.set $l_cur
        (i32.add
          (local.get $l_cur)
          (local.get $l_cha)
        )
      )
      (i32.lt_u
        (local.get $l_cur)
        (local.get $l_end)
      )
      (br_if $l_loop)
    )

    ;; returns

    (i32.const 0)
  )

  ;; invert hexadecimal position in indicated cells

  (func (export "flips_hex") (param $l_beg i32) (param $l_siz i32) (param $l_cha i32) (param $l_hex i32) (result i32)

    ;; declares

    (local $l_cur i32)
    (local $l_end i32)
    (local $l_mid i32)
    (local $l_out i32)

    (local $l_mas i32)

    ;; assigns

    (local.set $l_mas
      (i32.shl (i32.const 0x0000000f) (i32.mul (local.get $l_hex) (i32.const 4)))
    )

    ;; open l_loop
    (local.set $l_end
      (i32.add (local.get $l_beg) (local.get $l_siz))
    )
    (local.set $l_cur
      (local.get $l_beg)
    )
    (loop $l_loop

      (local.set $l_mid (i32.load (local.get $l_cur)))

      (local.set $l_out
        (i32.xor
          (local.get $l_mid)
          (local.get $l_mas)
        )
      )

      (i32.store
        (local.get $l_cur)
        (local.get $l_out)
      )

      ;; close l_loop
      (local.set $l_cur
        (i32.add
          (local.get $l_cur)
          (local.get $l_cha)
        )
      )
      (i32.lt_u
        (local.get $l_cur)
        (local.get $l_end)
      )
      (br_if $l_loop)
    )

    ;; returns

    (i32.const 0)
  )

  ;; invert colour channel in indicated cells

  (func (export "flips_col") (param $l_beg i32) (param $l_siz i32) (param $l_cha i32) (param $l_col i32) (result i32)

    ;; declares

    (local $l_cur i32)
    (local $l_end i32)
    (local $l_mid i32)
    (local $l_out i32)

    (local $l_mas i32)

    ;; assigns

    (local.set $l_mas
      (i32.shl (i32.const 0x000000ff) (i32.mul (local.get $l_col) (i32.const 8)))
    )

    ;; open l_loop
    (local.set $l_end
      (i32.add (local.get $l_beg) (local.get $l_siz))
    )
    (local.set $l_cur
      (local.get $l_beg)
    )
    (loop $l_loop

      (local.set $l_mid (i32.load (local.get $l_cur)))

      (local.set $l_out
        (i32.xor
          (local.get $l_mid)
          (local.get $l_mas)
        )
      )

      (i32.store
        (local.get $l_cur)
        (local.get $l_out)
      )

      ;; close l_loop
      (local.set $l_cur
        (i32.add
          (local.get $l_cur)
          (local.get $l_cha)
        )
      )
      (i32.lt_u
        (local.get $l_cur)
        (local.get $l_end)
      )
      (br_if $l_loop)
    )

    ;; returns

    (i32.const 0)
  )
)
