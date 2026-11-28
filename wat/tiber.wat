(module

  ;; module imports

  ;; module global flags

  ;; module global variables

  ;; module functions

  ;; red channel in 8 bits
  (func $mask_val_red (param $index i32) (result i32)
    (i32.and
      (local.get $index)
      (i32.const 0x000000ff)
    )
  )

  ;; green channel in 8 bits
  (func $mask_val_gre (param $index i32) (result i32)
    (i32.shr_u
      (i32.and
        (local.get $index)
        (i32.const 0x0000ff00)
      )
      (i32.const 8)
    )
  )

  ;; blue channel in 8 bits
  (func $mask_val_blu (param $index i32) (result i32)
    (i32.shr_u
      (i32.and
        (local.get $index)
        (i32.const 0x00ff0000)
      )
      (i32.const 16)
    )
  )

  ;; alpha channel in 8 bits
  (func $mask_val_alp (param $index i32) (result i32)
    (i32.shr_u
      (i32.and
        (local.get $index)
        (i32.const 0xff000000)
      )
      (i32.const 24)
    )
  )

  ;; combine 8-bit RGBA color channels into 32-bit integer
  (func $mask_rgba

    ;; inputs
    (param $r i32)
    (param $g i32)
    (param $b i32)
    (param $a i32)

    ;; outputs
    (result i32)

    ;; variables

    (local $c i32)

    ;; function

    (local.set $c
      (i32.or
        (i32.or
          (i32.or
            (i32.or
              (i32.const 0x000000)
              (local.get $r)
            )
            (i32.shl
              (local.get $g)
              (i32.const 8)
            )
          )
          (i32.shl
            (local.get $b)
            (i32.const 16)
          )
        )
        (i32.shl
          (local.get $a)
          (i32.const 24)
        )
      )
    )

    (local.get $c)
  )

  (func $tet_box

    ;; inputs
    (param $upp_lef_loc i32)
    (param $upp_rig_loc i32)
    (param $dow_lef_loc i32)
    (param $dow_rig_loc i32)
    (param $i i32)

    ;; variables

    (local $upp_lef_val i32)
    (local $upp_rig_val i32)
    (local $dow_lef_val i32)
    (local $dow_rig_val i32)

    (local $upp_lef_out i32)
    (local $upp_rig_out i32)
    (local $dow_lef_out i32)
    (local $dow_rig_out i32)

    ;; variables : color

    (local $upp_lef_red i32)
    (local $upp_lef_gre i32)
    (local $upp_lef_blu i32)
    (local $upp_lef_alp i32)

    (local $upp_rig_red i32)
    (local $upp_rig_gre i32)
    (local $upp_rig_blu i32)
    (local $upp_rig_alp i32)

    (local $dow_lef_red i32)
    (local $dow_lef_gre i32)
    (local $dow_lef_blu i32)
    (local $dow_lef_alp i32)

    (local $dow_rig_red i32)
    (local $dow_rig_gre i32)
    (local $dow_rig_blu i32)
    (local $dow_rig_alp i32)

    ;; variables : force

    (local $upp_lef_red_pul_tow_x i32)
    (local $upp_lef_red_pus_awa_x i32)
    (local $upp_lef_red_res_pul_x i32)
    (local $upp_lef_red_res_pus_x i32)

    (local $upp_lef_red_pul_tow_y i32)
    (local $upp_lef_red_pus_awa_y i32)
    (local $upp_lef_red_res_pul_y i32)
    (local $upp_lef_red_res_pus_y i32)

    (local $upp_rig_red_pul_tow_x i32)
    (local $upp_rig_red_pus_awa_x i32)
    (local $upp_rig_red_res_pul_x i32)
    (local $upp_rig_red_res_pus_x i32)

    (local $upp_rig_red_pul_tow_y i32)
    (local $upp_rig_red_pus_awa_y i32)
    (local $upp_rig_red_res_pul_y i32)
    (local $upp_rig_red_res_pus_y i32)

    (local $dow_lef_red_pul_tow_x i32)
    (local $dow_lef_red_pus_awa_x i32)
    (local $dow_lef_red_res_pul_x i32)
    (local $dow_lef_red_res_pus_x i32)

    (local $dow_lef_red_pul_tow_y i32)
    (local $dow_lef_red_pus_awa_y i32)
    (local $dow_lef_red_res_pul_y i32)
    (local $dow_lef_red_res_pus_y i32)

    (local $dow_rig_red_pul_tow_x i32)
    (local $dow_rig_red_pus_awa_x i32)
    (local $dow_rig_red_res_pul_x i32)
    (local $dow_rig_red_res_pus_x i32)

    (local $dow_rig_red_pul_tow_y i32)
    (local $dow_rig_red_pus_awa_y i32)
    (local $dow_rig_red_res_pul_y i32)
    (local $dow_rig_red_res_pus_y i32)

    (local $upp_lef_gre_pul_tow_x i32)
    (local $upp_lef_gre_pus_awa_x i32)
    (local $upp_lef_gre_res_pul_x i32)
    (local $upp_lef_gre_res_pus_x i32)

    (local $upp_lef_gre_pul_tow_y i32)
    (local $upp_lef_gre_pus_awa_y i32)
    (local $upp_lef_gre_res_pul_y i32)
    (local $upp_lef_gre_res_pus_y i32)

    (local $upp_rig_gre_pul_tow_x i32)
    (local $upp_rig_gre_pus_awa_x i32)
    (local $upp_rig_gre_res_pul_x i32)
    (local $upp_rig_gre_res_pus_x i32)

    (local $upp_rig_gre_pul_tow_y i32)
    (local $upp_rig_gre_pus_awa_y i32)
    (local $upp_rig_gre_res_pul_y i32)
    (local $upp_rig_gre_res_pus_y i32)

    (local $dow_lef_gre_pul_tow_x i32)
    (local $dow_lef_gre_pus_awa_x i32)
    (local $dow_lef_gre_res_pul_x i32)
    (local $dow_lef_gre_res_pus_x i32)

    (local $dow_lef_gre_pul_tow_y i32)
    (local $dow_lef_gre_pus_awa_y i32)
    (local $dow_lef_gre_res_pul_y i32)
    (local $dow_lef_gre_res_pus_y i32)

    (local $dow_rig_gre_pul_tow_x i32)
    (local $dow_rig_gre_pus_awa_x i32)
    (local $dow_rig_gre_res_pul_x i32)
    (local $dow_rig_gre_res_pus_x i32)

    (local $dow_rig_gre_pul_tow_y i32)
    (local $dow_rig_gre_pus_awa_y i32)
    (local $dow_rig_gre_res_pul_y i32)
    (local $dow_rig_gre_res_pus_y i32)

    (local $upp_lef_blu_pul_tow_x i32)
    (local $upp_lef_blu_pus_awa_x i32)
    (local $upp_lef_blu_res_pul_x i32)
    (local $upp_lef_blu_res_pus_x i32)

    (local $upp_lef_blu_pul_tow_y i32)
    (local $upp_lef_blu_pus_awa_y i32)
    (local $upp_lef_blu_res_pul_y i32)
    (local $upp_lef_blu_res_pus_y i32)

    (local $upp_rig_blu_pul_tow_x i32)
    (local $upp_rig_blu_pus_awa_x i32)
    (local $upp_rig_blu_res_pul_x i32)
    (local $upp_rig_blu_res_pus_x i32)

    (local $upp_rig_blu_pul_tow_y i32)
    (local $upp_rig_blu_pus_awa_y i32)
    (local $upp_rig_blu_res_pul_y i32)
    (local $upp_rig_blu_res_pus_y i32)

    (local $dow_lef_blu_pul_tow_x i32)
    (local $dow_lef_blu_pus_awa_x i32)
    (local $dow_lef_blu_res_pul_x i32)
    (local $dow_lef_blu_res_pus_x i32)

    (local $dow_lef_blu_pul_tow_y i32)
    (local $dow_lef_blu_pus_awa_y i32)
    (local $dow_lef_blu_res_pul_y i32)
    (local $dow_lef_blu_res_pus_y i32)

    (local $dow_rig_blu_pul_tow_x i32)
    (local $dow_rig_blu_pus_awa_x i32)
    (local $dow_rig_blu_res_pul_x i32)
    (local $dow_rig_blu_res_pus_x i32)

    (local $dow_rig_blu_pul_tow_y i32)
    (local $dow_rig_blu_pus_awa_y i32)
    (local $dow_rig_blu_res_pul_y i32)
    (local $dow_rig_blu_res_pus_y i32)

    (local $upp_lef_alp_pul_tow_x i32)
    (local $upp_lef_alp_pus_awa_x i32)
    (local $upp_lef_alp_res_pul_x i32)
    (local $upp_lef_alp_res_pus_x i32)

    (local $upp_lef_alp_pul_tow_y i32)
    (local $upp_lef_alp_pus_awa_y i32)
    (local $upp_lef_alp_res_pul_y i32)
    (local $upp_lef_alp_res_pus_y i32)

    (local $upp_rig_alp_pul_tow_x i32)
    (local $upp_rig_alp_pus_awa_x i32)
    (local $upp_rig_alp_res_pul_x i32)
    (local $upp_rig_alp_res_pus_x i32)

    (local $upp_rig_alp_pul_tow_y i32)
    (local $upp_rig_alp_pus_awa_y i32)
    (local $upp_rig_alp_res_pul_y i32)
    (local $upp_rig_alp_res_pus_y i32)

    (local $dow_lef_alp_pul_tow_x i32)
    (local $dow_lef_alp_pus_awa_x i32)
    (local $dow_lef_alp_res_pul_x i32)
    (local $dow_lef_alp_res_pus_x i32)

    (local $dow_lef_alp_pul_tow_y i32)
    (local $dow_lef_alp_pus_awa_y i32)
    (local $dow_lef_alp_res_pul_y i32)
    (local $dow_lef_alp_res_pus_y i32)

    (local $dow_rig_alp_pul_tow_x i32)
    (local $dow_rig_alp_pus_awa_x i32)
    (local $dow_rig_alp_res_pul_x i32)
    (local $dow_rig_alp_res_pus_x i32)

    (local $dow_rig_alp_pul_tow_y i32)
    (local $dow_rig_alp_pus_awa_y i32)
    (local $dow_rig_alp_res_pul_y i32)
    (local $dow_rig_alp_res_pus_y i32)

    ;; function

    ;; function : loads

    (local.set $upp_lef_val (i32.load (local.get $upp_lef_loc)))
    (local.set $upp_rig_val (i32.load (local.get $upp_rig_loc)))
    (local.set $dow_lef_val (i32.load (local.get $dow_lef_loc)))
    (local.set $dow_rig_val (i32.load (local.get $dow_rig_loc)))

    ;; function : color : extract

    (local.set $upp_lef_red (call $mask_val_red (local.get $upp_lef_val)))
    (local.set $upp_lef_gre (call $mask_val_gre (local.get $upp_lef_val)))
    (local.set $upp_lef_blu (call $mask_val_blu (local.get $upp_lef_val)))
    (local.set $upp_lef_alp (call $mask_val_alp (local.get $upp_lef_val)))

    (local.set $upp_rig_red (call $mask_val_red (local.get $upp_rig_val)))
    (local.set $upp_rig_gre (call $mask_val_gre (local.get $upp_rig_val)))
    (local.set $upp_rig_blu (call $mask_val_blu (local.get $upp_rig_val)))
    (local.set $upp_rig_alp (call $mask_val_alp (local.get $upp_rig_val)))

    (local.set $dow_lef_red (call $mask_val_red (local.get $dow_lef_val)))
    (local.set $dow_lef_gre (call $mask_val_gre (local.get $dow_lef_val)))
    (local.set $dow_lef_blu (call $mask_val_blu (local.get $dow_lef_val)))
    (local.set $dow_lef_alp (call $mask_val_alp (local.get $dow_lef_val)))

    (local.set $dow_rig_red (call $mask_val_red (local.get $dow_rig_val)))
    (local.set $dow_rig_gre (call $mask_val_gre (local.get $dow_rig_val)))
    (local.set $dow_rig_blu (call $mask_val_blu (local.get $dow_rig_val)))
    (local.set $dow_rig_alp (call $mask_val_alp (local.get $dow_rig_val)))

    ;; function : force : solve

    ;; alp

    i32.const 255

    local.get $upp_lef_alp_pul_tow_x
    local.get $upp_lef_alp_res_pul_x
    local.get $upp_lef_alp_pus_awa_x
    local.get $upp_lef_alp_res_pus_x
    local.get $upp_lef_alp_pul_tow_y
    local.get $upp_lef_alp_res_pul_y
    local.get $upp_lef_alp_pus_awa_y
    local.get $upp_lef_alp_res_pus_y
    local.get $upp_rig_alp_pul_tow_x
    local.get $upp_rig_alp_res_pul_x
    local.get $upp_rig_alp_pus_awa_x
    local.get $upp_rig_alp_res_pus_x
    local.get $upp_rig_alp_pul_tow_y
    local.get $upp_rig_alp_res_pul_y
    local.get $upp_rig_alp_pus_awa_y
    local.get $upp_rig_alp_res_pus_y
    local.get $dow_lef_alp_pul_tow_x
    local.get $dow_lef_alp_res_pul_x
    local.get $dow_lef_alp_pus_awa_x
    local.get $dow_lef_alp_res_pus_x
    local.get $dow_lef_alp_pul_tow_y
    local.get $dow_lef_alp_res_pul_y
    local.get $dow_lef_alp_pus_awa_y
    local.get $dow_lef_alp_res_pus_y
    local.get $dow_rig_alp_pul_tow_x
    local.get $dow_rig_alp_res_pul_x
    local.get $dow_rig_alp_pus_awa_x
    local.get $dow_rig_alp_res_pus_x
    local.get $dow_rig_alp_pul_tow_y
    local.get $dow_rig_alp_res_pul_y
    local.get $dow_rig_alp_pus_awa_y
    local.get $dow_rig_alp_res_pus_y

    local.get $upp_lef_alp
    local.get $upp_rig_alp
    local.get $dow_lef_alp
    local.get $dow_rig_alp

    call $tense_solve

    local.set $dow_rig_alp
    local.set $dow_lef_alp
    local.set $upp_rig_alp
    local.set $upp_lef_alp

    ;; blu

    i32.const 255

    local.get $upp_lef_blu_pul_tow_x
    local.get $upp_lef_blu_res_pul_x
    local.get $upp_lef_blu_pus_awa_x
    local.get $upp_lef_blu_res_pus_x
    local.get $upp_lef_blu_pul_tow_y
    local.get $upp_lef_blu_res_pul_y
    local.get $upp_lef_blu_pus_awa_y
    local.get $upp_lef_blu_res_pus_y
    local.get $upp_rig_blu_pul_tow_x
    local.get $upp_rig_blu_res_pul_x
    local.get $upp_rig_blu_pus_awa_x
    local.get $upp_rig_blu_res_pus_x
    local.get $upp_rig_blu_pul_tow_y
    local.get $upp_rig_blu_res_pul_y
    local.get $upp_rig_blu_pus_awa_y
    local.get $upp_rig_blu_res_pus_y
    local.get $dow_lef_blu_pul_tow_x
    local.get $dow_lef_blu_res_pul_x
    local.get $dow_lef_blu_pus_awa_x
    local.get $dow_lef_blu_res_pus_x
    local.get $dow_lef_blu_pul_tow_y
    local.get $dow_lef_blu_res_pul_y
    local.get $dow_lef_blu_pus_awa_y
    local.get $dow_lef_blu_res_pus_y
    local.get $dow_rig_blu_pul_tow_x
    local.get $dow_rig_blu_res_pul_x
    local.get $dow_rig_blu_pus_awa_x
    local.get $dow_rig_blu_res_pus_x
    local.get $dow_rig_blu_pul_tow_y
    local.get $dow_rig_blu_res_pul_y
    local.get $dow_rig_blu_pus_awa_y
    local.get $dow_rig_blu_res_pus_y

    local.get $upp_lef_blu
    local.get $upp_rig_blu
    local.get $dow_lef_blu
    local.get $dow_rig_blu

    call $tense_solve

    local.set $dow_rig_blu
    local.set $dow_lef_blu
    local.set $upp_rig_blu
    local.set $upp_lef_blu

    ;; gre

    i32.const 255

    local.get $upp_lef_gre_pul_tow_x
    local.get $upp_lef_gre_res_pul_x
    local.get $upp_lef_gre_pus_awa_x
    local.get $upp_lef_gre_res_pus_x
    local.get $upp_lef_gre_pul_tow_y
    local.get $upp_lef_gre_res_pul_y
    local.get $upp_lef_gre_pus_awa_y
    local.get $upp_lef_gre_res_pus_y
    local.get $upp_rig_gre_pul_tow_x
    local.get $upp_rig_gre_res_pul_x
    local.get $upp_rig_gre_pus_awa_x
    local.get $upp_rig_gre_res_pus_x
    local.get $upp_rig_gre_pul_tow_y
    local.get $upp_rig_gre_res_pul_y
    local.get $upp_rig_gre_pus_awa_y
    local.get $upp_rig_gre_res_pus_y
    local.get $dow_lef_gre_pul_tow_x
    local.get $dow_lef_gre_res_pul_x
    local.get $dow_lef_gre_pus_awa_x
    local.get $dow_lef_gre_res_pus_x
    local.get $dow_lef_gre_pul_tow_y
    local.get $dow_lef_gre_res_pul_y
    local.get $dow_lef_gre_pus_awa_y
    local.get $dow_lef_gre_res_pus_y
    local.get $dow_rig_gre_pul_tow_x
    local.get $dow_rig_gre_res_pul_x
    local.get $dow_rig_gre_pus_awa_x
    local.get $dow_rig_gre_res_pus_x
    local.get $dow_rig_gre_pul_tow_y
    local.get $dow_rig_gre_res_pul_y
    local.get $dow_rig_gre_pus_awa_y
    local.get $dow_rig_gre_res_pus_y

    local.get $upp_lef_gre
    local.get $upp_rig_gre
    local.get $dow_lef_gre
    local.get $dow_rig_gre

    call $tense_solve

    local.set $dow_rig_gre
    local.set $dow_lef_gre
    local.set $upp_rig_gre
    local.set $upp_lef_gre

    ;; red

    i32.const 255

    local.get $upp_lef_red_pul_tow_x
    local.get $upp_lef_red_res_pul_x
    local.get $upp_lef_red_pus_awa_x
    local.get $upp_lef_red_res_pus_x
    local.get $upp_lef_red_pul_tow_y
    local.get $upp_lef_red_res_pul_y
    local.get $upp_lef_red_pus_awa_y
    local.get $upp_lef_red_res_pus_y
    local.get $upp_rig_red_pul_tow_x
    local.get $upp_rig_red_res_pul_x
    local.get $upp_rig_red_pus_awa_x
    local.get $upp_rig_red_res_pus_x
    local.get $upp_rig_red_pul_tow_y
    local.get $upp_rig_red_res_pul_y
    local.get $upp_rig_red_pus_awa_y
    local.get $upp_rig_red_res_pus_y
    local.get $dow_lef_red_pul_tow_x
    local.get $dow_lef_red_res_pul_x
    local.get $dow_lef_red_pus_awa_x
    local.get $dow_lef_red_res_pus_x
    local.get $dow_lef_red_pul_tow_y
    local.get $dow_lef_red_res_pul_y
    local.get $dow_lef_red_pus_awa_y
    local.get $dow_lef_red_res_pus_y
    local.get $dow_rig_red_pul_tow_x
    local.get $dow_rig_red_res_pul_x
    local.get $dow_rig_red_pus_awa_x
    local.get $dow_rig_red_res_pus_x
    local.get $dow_rig_red_pul_tow_y
    local.get $dow_rig_red_res_pul_y
    local.get $dow_rig_red_pus_awa_y
    local.get $dow_rig_red_res_pus_y

    local.get $upp_lef_red
    local.get $upp_rig_red
    local.get $dow_lef_red
    local.get $dow_rig_red

    call $tense_solve

    local.set $dow_rig_red
    local.set $dow_lef_red
    local.set $upp_rig_red
    local.set $upp_lef_red

    ;; function : color : combine

    (local.set $upp_lef_out
      (call $mask_rgba
        (local.get $upp_lef_red) (local.get $upp_lef_gre) (local.get $upp_lef_blu) (local.get $upp_lef_alp)
      )
    )

    (local.set $upp_rig_out
      (call $mask_rgba
        (local.get $upp_rig_red) (local.get $upp_rig_gre) (local.get $upp_rig_blu) (local.get $upp_rig_alp)
      )
    )

    (local.set $dow_lef_out
      (call $mask_rgba
        (local.get $dow_lef_red) (local.get $dow_lef_gre) (local.get $dow_lef_blu) (local.get $dow_lef_alp)
      )
    )

    (local.set $dow_rig_out
      (call $mask_rgba
        (local.get $dow_rig_red) (local.get $dow_rig_gre) (local.get $dow_rig_blu) (local.get $dow_rig_alp)
      )
    )

    ;; function : stores

    (i32.store (local.get $upp_lef_loc) (local.get $upp_lef_out))
    (i32.store (local.get $upp_rig_loc) (local.get $upp_rig_out))
    (i32.store (local.get $dow_lef_loc) (local.get $dow_lef_out))
    (i32.store (local.get $dow_rig_loc) (local.get $dow_rig_out))
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
