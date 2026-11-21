(module

  ;; args

  ;; 0 : l_beg : memory block start index
  ;; 1 : l_siz : memory block size in bytes
  ;; 2 : l_cha : number of bytes per cell (generally equivalent to number of colour channels per pixel)
  ;; 3 : l_val : value to be written

  ;; set-to-value in indicated cells

  (func (export "fills") (param $l_beg i32) (param $l_siz i32) (param $l_cha i32) (param $l_val i32) (result i32)

    ;; declares

    (local $l_cur i32)
    (local $l_end i32)

    ;; assigns

    ;; open l_loop
    (local.set $l_end
      (i32.add (local.get $l_beg) (local.get $l_siz))
    )
    (local.set $l_cur
      (local.get $l_beg)
    )
    (loop $l_loop

      (i32.store
        (local.get $l_cur)
        (local.get $l_val)
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

  ;; args for fills_--- functions

  ;; 0 : l_beg : memory block start index
  ;; 1 : l_siz : memory block size in bytes
  ;; 2 : l_cha : number of bytes per cell (generally equivalent to number of colour channels per pixel)
  ;; 3 : l_--- : internal index of element position to be altered
  ;; 4 : l_val : value to be written (will be reduced to max element value)

  ;; set-to-value bit position in indicated cells ;; [ this is a very silly function, included only for consistency across behaviours ]

  (func (export "fills_bit") (param $l_beg i32) (param $l_siz i32) (param $l_cha i32) (param $l_bit i32) (param $l_val i32) (result i32)

    ;; declares

    (local $l_cur i32)
    (local $l_end i32)
    (local $l_mid i32)
    (local $l_out i32)

    (local $l_mas_val i32)
    (local $l_mas_bla i32)

    ;; assigns

    ;; cap inp at max val
    (local.get $l_val)
    (if (then (local.set $l_val (i32.const 1))))

    ;; mask to write
    (local.set $l_mas_val
      (i32.shl (local.get $l_val) (local.get $l_bit))
    )

    ;; mask to blank
    (local.set $l_mas_bla
      (i32.xor
        (i32.shl (i32.const 1) (local.get $l_bit))
        (i32.const 0xffffffff)
      )
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
        (i32.or
          (i32.and
            (local.get $l_mid)
            (local.get $l_mas_bla)
          )
          (local.get $l_mas_val)
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

  ;; set-to-value hexadecimal position in indicated cells

  (func (export "fills_hex") (param $l_beg i32) (param $l_siz i32) (param $l_cha i32) (param $l_hex i32) (param $l_val i32) (result i32)

    ;; declares

    (local $l_cur i32)
    (local $l_end i32)
    (local $l_mid i32)
    (local $l_out i32)

    (local $l_mas_val i32)
    (local $l_mas_bla i32)

    ;; assigns

    ;; cap inp at max val
    (i32.gt_u
      (local.get $l_val)
      (i32.const 0x0000000f)
    )
    (if (then (local.set $l_val (i32.const 0x0000000f))))

    ;; mask to write
    (local.set $l_mas_val
      (i32.shl (local.get $l_val) (i32.mul (local.get $l_hex) (i32.const 4)))
    )

    ;; mask to blank
    (local.set $l_mas_bla
      (i32.xor
        (i32.shl (i32.const 0x0000000f) (i32.mul (local.get $l_hex) (i32.const 4)))
        (i32.const 0xffffffff)
      )
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
        (i32.or
          (i32.and
            (local.get $l_mid)
            (local.get $l_mas_bla)
          )
          (local.get $l_mas_val)
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

  ;; set-to-value colour channel position in indicated cells

  (func (export "fills_col") (param $l_beg i32) (param $l_siz i32) (param $l_cha i32) (param $l_col i32) (param $l_val i32) (result i32)

    ;; declares

    (local $l_cur i32)
    (local $l_end i32)
    (local $l_mid i32)
    (local $l_out i32)

    (local $l_mas_val i32)
    (local $l_mas_bla i32)

    ;; assigns

    ;; cap inp at max val
    (i32.gt_u
      (local.get $l_val)
      (i32.const 0x000000ff)
    )
    (if (then (local.set $l_val (i32.const 0x000000ff))))

    ;; mask to write
    (local.set $l_mas_val
      (i32.shl (local.get $l_val) (i32.mul (local.get $l_col) (i32.const 8)))
    )

    ;; mask to blank
    (local.set $l_mas_bla
      (i32.xor
        (i32.shl (i32.const 0x000000ff) (i32.mul (local.get $l_col) (i32.const 8)))
        (i32.const 0xffffffff)
      )
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
        (i32.or
          (i32.and
            (local.get $l_mid)
            (local.get $l_mas_bla)
          )
          (local.get $l_mas_val)
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
