(module

  ;; module imports

  ;; module global flags

  (global $globo_force_flags_tiber_grows (mut i32) (i32.const 1))
  (func (export "globo_get_force_flags_tiber_grows") (result i32) (global.get $globo_force_flags_tiber_grows))
  (func (export "globo_set_force_flags_tiber_grows") (param i32) (global.set $globo_force_flags_tiber_grows (local.get 0)))

  (global $globo_force_flags_tiber_spore (mut i32) (i32.const 1))
  (func (export "globo_get_force_flags_tiber_spore") (result i32) (global.get $globo_force_flags_tiber_spore))
  (func (export "globo_set_force_flags_tiber_spore") (param i32) (global.set $globo_force_flags_tiber_spore (local.get 0)))

  ;; module global variables

  ;; module functions

  (func $tiber_grows

    ;; inputs
    (param $val_gre i32)

    ;; outputs
    (result i32)

    ;; variables
    (local $ran i32)
    (local $gro i32)

    ;; function

    i32.const 191 ;; growth limiter; higher is slower
    local.set $gro

    local.get $val_gre
    i32.const 255
    i32.lt_u
    (if (result i32)
      (then
        (local.set $ran
          (call $rando_trixo)
        )

        i32.const 0x0000ff00
        local.get $ran
        i32.and
        i32.const 8
        i32.shr_u
        local.get $gro
        i32.ge_u
        (if (result i32)
          (then
            local.get $val_gre
            i32.const 0x000000ff
            local.get $ran
            i32.and
            i32.gt_u
            (if (result i32)
              (then
                local.get $val_gre
                i32.const 1
                i32.add
              )
              (else
                local.get $val_gre
              )
            )
          )
          (else
            local.get $val_gre
          )
        )
      )
      (else
        i32.const 255
      )
    )
  )

  (func $tiber_spore

    ;; inputs
    (param $val_gre i32)

    ;; outputs
    (result i32 i32)

    ;; variables
    (local $pus_tow_x_gre i32)
    (local $pus_tow_y_gre i32)
    (local $ran i32)
    (local $mid i32)

    ;; function

    (local.set $ran
      (call $rando_trixo)
    )

    local.get $val_gre
    i32.popcnt
    i32.const 1
    i32.ne
    (if
      (then

        i32.const 0x00ff0000
        local.get $ran
        i32.and
        i32.const 16
        i32.shr_u
        i32.const 1
        i32.and
        (if
          (then

            i32.const 0x000000ff
            local.get $ran
            i32.and
            local.set $mid

            local.get $val_gre
            local.get $mid
            i32.gt_u
            (if
              (then

                local.get $mid
                i32.const 4
                i32.div_u
                local.set $pus_tow_x_gre

              )
              (else

                i32.const 0
                local.set $pus_tow_x_gre

              )
            )

          )
          (else

            i32.const 0x0000ff00
            local.get $ran
            i32.and
            i32.const 8
            i32.shr_u
            local.set $mid

            local.get $val_gre
            local.get $mid
            i32.gt_u
            (if
              (then

                local.get $mid
                i32.const 4
                i32.div_u
                local.set $pus_tow_y_gre

              )
              (else

                i32.const 0
                local.set $pus_tow_y_gre

              )
            )

          )
        )
      )
      (else

        i32.const 0
        local.set $pus_tow_x_gre

        i32.const 0
        local.set $pus_tow_y_gre

      )
    )

    (local.get $pus_tow_x_gre)
    (local.get $pus_tow_y_gre)
  )

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

  (func $force_solve_pro_inc

    ;; inputs

    (param $mid_max i32)
    (param $mid_inc i32)
    (param $mid_inc_h i32)
    (param $mid_inc_v i32)

    ;; outputs

    (result i32 i32)

    ;; variables

    (local $mid_inc_spo i32)
    (local $mid_inc_sum i32)

    ;; function

    (i32.ge_u
      (local.tee $mid_inc_spo (i32.sub (local.get $mid_max) (local.get $mid_inc)))
      (local.tee $mid_inc_sum (i32.add (local.get $mid_inc_h) (local.get $mid_inc_v)))
    )
    (if (result i32 i32)
      (then

        (local.get $mid_inc_h)
        (local.get $mid_inc_v)
      )
      (else

        (local.get $mid_inc_sum)
        (if (result i32 i32)
          (then

            (i32.div_u
              (i32.mul
                (local.get $mid_inc_spo)
                (local.get $mid_inc_h)
              )
              (local.get $mid_inc_sum)
            )
            (i32.div_u
              (i32.mul
                (local.get $mid_inc_spo)
                (local.get $mid_inc_v)
              )
              (local.get $mid_inc_sum)
            )
          )
          (else

            (i32.const 0)
            (i32.const 0)
          )
        )
      )
    )
  )

  (func $force_solve_pro_out

    ;; inputs

    (param $mid_out i32)
    (param $mid_out_h i32)
    (param $mid_out_v i32)

    ;; outputs

    (result i32 i32)

    ;; variables

    (local $mid_out_sum i32)

    ;; function

    (i32.ge_u
      (local.get $mid_out)
      (local.tee $mid_out_sum (i32.add (local.get $mid_out_h) (local.get $mid_out_v)))
    )
    (if (result i32 i32)

      ;; corner gives out all requested particles to all adjacent cells in full
      (then

        (local.get $mid_out_h)
        (local.get $mid_out_v)
      )

      ;; corner gives out partial particles to adjacent cells proportionate to appropriate forces
      (else

        (local.get $mid_out_sum)
        (if (result i32 i32)
          (then

            (i32.div_u
              (i32.mul
                (local.get $mid_out)
                (local.get $mid_out_h)
              )
              (local.get $mid_out_sum)
            )
            (i32.div_u
              (i32.mul
                (local.get $mid_out)
                (local.get $mid_out_v)
              )
              (local.get $mid_out_sum)
            )
          )
          (else

            (i32.const 0)
            (i32.const 0)
          )
        )
      )
    )
  )

  (func $force_solve_sum_tot

    ;; inputs

    (param $mid_tot i32)
    (param $mid_out_h i32)
    (param $mid_out_v i32)
    (param $mid_inc_h i32)
    (param $mid_inc_v i32)

    ;; outputs

    (result i32)

    ;; variables

    (local $mid_out_sum i32)
    (local $mid_inc_sum i32)

    ;; function

    (local.set $mid_out_sum (i32.add (local.get $mid_out_h) (local.get $mid_out_v)))
    (local.set $mid_inc_sum (i32.add (local.get $mid_inc_h) (local.get $mid_inc_v)))

    (local.set $mid_tot (i32.add (local.get $mid_tot) (local.get $mid_inc_sum)))
    (local.set $mid_tot (i32.sub (local.get $mid_tot) (local.get $mid_out_sum)))

    local.get $mid_tot
  )

  (func $tense_solve_for_dim

    ;; inputs

    (param $a_pul_tow i32)
    (param $a_res_pul i32)

    (param $a_pus_awa i32)
    (param $a_res_pus i32)

    (param $b_pul_tow i32)
    (param $b_res_pul i32)

    (param $b_pus_awa i32)
    (param $b_res_pus i32)

    ;; outputs

    (result i32 i32)

    ;; variables

    (local $a_for_pul i32)
    (local $a_for_pus i32)

    (local $b_for_pul i32)
    (local $b_for_pus i32)

    (local $tow_a i32)
    (local $tow_b i32)
    (local $tow_m i32)

    ;; function

    (local.set $a_for_pul
      (i32.sub
        (call $i32_max_val_int
          (local.get $a_pul_tow)
          (local.get $b_res_pul)
        )
        (local.get $b_res_pul)
      )
    )

    (local.set $a_for_pus
      (i32.sub
        (call $i32_max_val_int
          (local.get $a_pus_awa)
          (local.get $b_res_pus)
        )
        (local.get $b_res_pus)
      )
    )

    (local.set $b_for_pul
      (i32.sub
        (call $i32_max_val_int
          (local.get $b_pul_tow)
          (local.get $a_res_pul)
        )
        (local.get $a_res_pul)
      )
    )

    (local.set $b_for_pus
      (i32.sub
        (call $i32_max_val_int
          (local.get $b_pus_awa)
          (local.get $a_res_pus)
        )
        (local.get $a_res_pus)
      )
    )

    (local.set $tow_b
      (i32.add
        (local.get $a_for_pus)
        (local.get $b_for_pul)
      )
    )

    (local.set $tow_a
      (i32.add
        (local.get $b_for_pus)
        (local.get $a_for_pul)
      )
    )

    (local.set $tow_m
      (call $i32_max_val_int
        (local.get $tow_a)
        (local.get $tow_b)
      )
    )

    (i32.sub
      (local.get $tow_m)
      (local.get $tow_a)
    )

    (i32.sub
      (local.get $tow_m)
      (local.get $tow_b)
    )
  )

  (func $tense_solve

    ;; inputs

    (param $cha_max i32)

    (param $ulc_pul_tow_x i32)
    (param $ulc_res_pul_x i32)
    (param $ulc_pus_awa_x i32)
    (param $ulc_res_pus_x i32)
    (param $ulc_pul_tow_y i32)
    (param $ulc_res_pul_y i32)
    (param $ulc_pus_awa_y i32)
    (param $ulc_res_pus_y i32)

    (param $urc_pul_tow_x i32)
    (param $urc_res_pul_x i32)
    (param $urc_pus_awa_x i32)
    (param $urc_res_pus_x i32)
    (param $urc_pul_tow_y i32)
    (param $urc_res_pul_y i32)
    (param $urc_pus_awa_y i32)
    (param $urc_res_pus_y i32)

    (param $dlc_pul_tow_x i32)
    (param $dlc_res_pul_x i32)
    (param $dlc_pus_awa_x i32)
    (param $dlc_res_pus_x i32)
    (param $dlc_pul_tow_y i32)
    (param $dlc_res_pul_y i32)
    (param $dlc_pus_awa_y i32)
    (param $dlc_res_pus_y i32)

    (param $drc_pul_tow_x i32)
    (param $drc_res_pul_x i32)
    (param $drc_pus_awa_x i32)
    (param $drc_res_pus_x i32)
    (param $drc_pul_tow_y i32)
    (param $drc_res_pul_y i32)
    (param $drc_pus_awa_y i32)
    (param $drc_res_pus_y i32)

    (param $upp_lef_val i32)
    (param $upp_rig_val i32)
    (param $dow_lef_val i32)
    (param $dow_rig_val i32)

    ;; outputs

    (result i32 i32 i32 i32)

    ;; variables

    (local $ulc_inc_v i32)
    (local $ulc_inc_h i32)
    (local $urc_inc_v i32)
    (local $urc_inc_h i32)
    (local $dlc_inc_v i32)
    (local $dlc_inc_h i32)
    (local $drc_inc_v i32)
    (local $drc_inc_h i32)
    (local $ulc_out_v i32)
    (local $ulc_out_h i32)
    (local $urc_out_v i32)
    (local $urc_out_h i32)
    (local $dlc_out_v i32)
    (local $dlc_out_h i32)
    (local $drc_out_v i32)
    (local $drc_out_h i32)

    (local $upp_lef_val_ret i32)
    (local $upp_rig_val_ret i32)
    (local $dow_lef_val_ret i32)
    (local $dow_rig_val_ret i32)

    ;; function

    ;; lef

    local.get $ulc_pul_tow_y
    local.get $ulc_res_pul_y
    local.get $ulc_pus_awa_y
    local.get $ulc_res_pus_y
    local.get $dlc_pul_tow_y
    local.get $dlc_res_pul_y
    local.get $dlc_pus_awa_y
    local.get $dlc_res_pus_y
    call $tense_solve_for_dim
    local.set $dlc_out_v
    local.set $ulc_out_v

    ;; rig

    local.get $urc_pul_tow_y
    local.get $urc_res_pul_y
    local.get $urc_pus_awa_y
    local.get $urc_res_pus_y
    local.get $drc_pul_tow_y
    local.get $drc_res_pul_y
    local.get $drc_pus_awa_y
    local.get $drc_res_pus_y
    call $tense_solve_for_dim
    local.set $drc_out_v
    local.set $urc_out_v

    ;; upp

    local.get $ulc_pul_tow_x
    local.get $ulc_res_pul_x
    local.get $ulc_pus_awa_x
    local.get $ulc_res_pus_x
    local.get $urc_pul_tow_x
    local.get $urc_res_pul_x
    local.get $urc_pus_awa_x
    local.get $urc_res_pus_x
    call $tense_solve_for_dim
    local.set $urc_out_h
    local.set $ulc_out_h

    ;; dow

    local.get $dlc_pul_tow_x
    local.get $dlc_res_pul_x
    local.get $dlc_pus_awa_x
    local.get $dlc_res_pus_x
    local.get $drc_pul_tow_x
    local.get $drc_res_pul_x
    local.get $drc_pus_awa_x
    local.get $drc_res_pus_x
    call $tense_solve_for_dim
    local.set $drc_out_h
    local.set $dlc_out_h

    (local.set $ulc_inc_v (local.get $dlc_out_v))
    (local.set $ulc_inc_h (local.get $urc_out_h))
    (local.set $urc_inc_v (local.get $drc_out_v))
    (local.set $urc_inc_h (local.get $ulc_out_h))
    (local.set $dlc_inc_v (local.get $ulc_out_v))
    (local.set $dlc_inc_h (local.get $drc_out_h))
    (local.set $drc_inc_v (local.get $urc_out_v))
    (local.set $drc_inc_h (local.get $dlc_out_h))

    local.get $cha_max
    local.get $upp_lef_val
    local.get $ulc_inc_h
    local.get $ulc_inc_v
    call $force_solve_pro_inc
    local.set $ulc_inc_v
    local.set $ulc_inc_h

    local.get $cha_max
    local.get $upp_rig_val
    local.get $urc_inc_h
    local.get $urc_inc_v
    call $force_solve_pro_inc
    local.set $urc_inc_v
    local.set $urc_inc_h

    local.get $cha_max
    local.get $dow_lef_val
    local.get $dlc_inc_h
    local.get $dlc_inc_v
    call $force_solve_pro_inc
    local.set $dlc_inc_v
    local.set $dlc_inc_h

    local.get $cha_max
    local.get $dow_rig_val
    local.get $drc_inc_h
    local.get $drc_inc_v
    call $force_solve_pro_inc
    local.set $drc_inc_v
    local.set $drc_inc_h

    (local.set $ulc_out_v (local.get $dlc_inc_v))
    (local.set $ulc_out_h (local.get $urc_inc_h))
    (local.set $urc_out_v (local.get $drc_inc_v))
    (local.set $urc_out_h (local.get $ulc_inc_h))
    (local.set $dlc_out_v (local.get $ulc_inc_v))
    (local.set $dlc_out_h (local.get $drc_inc_h))
    (local.set $drc_out_v (local.get $urc_inc_v))
    (local.set $drc_out_h (local.get $dlc_inc_h))

    local.get $upp_lef_val
    local.get $ulc_out_h
    local.get $ulc_out_v
    call $force_solve_pro_out
    local.set $ulc_out_v
    local.set $ulc_out_h

    local.get $upp_rig_val
    local.get $urc_out_h
    local.get $urc_out_v
    call $force_solve_pro_out
    local.set $urc_out_v
    local.set $urc_out_h

    local.get $dow_lef_val
    local.get $dlc_out_h
    local.get $dlc_out_v
    call $force_solve_pro_out
    local.set $dlc_out_v
    local.set $dlc_out_h

    local.get $dow_rig_val
    local.get $drc_out_h
    local.get $drc_out_v
    call $force_solve_pro_out
    local.set $drc_out_v
    local.set $drc_out_h

    (local.set $ulc_inc_v (local.get $dlc_out_v))
    (local.set $ulc_inc_h (local.get $urc_out_h))
    (local.set $urc_inc_v (local.get $drc_out_v))
    (local.set $urc_inc_h (local.get $ulc_out_h))
    (local.set $dlc_inc_v (local.get $ulc_out_v))
    (local.set $dlc_inc_h (local.get $drc_out_h))
    (local.set $drc_inc_v (local.get $urc_out_v))
    (local.set $drc_inc_h (local.get $dlc_out_h))

    local.get $upp_lef_val
    local.get $ulc_out_h
    local.get $ulc_out_v
    local.get $ulc_inc_h
    local.get $ulc_inc_v
    call $force_solve_sum_tot
    local.set $upp_lef_val_ret

    local.get $upp_rig_val
    local.get $urc_out_h
    local.get $urc_out_v
    local.get $urc_inc_h
    local.get $urc_inc_v
    call $force_solve_sum_tot
    local.set $upp_rig_val_ret

    local.get $dow_lef_val
    local.get $dlc_out_h
    local.get $dlc_out_v
    local.get $dlc_inc_h
    local.get $dlc_inc_v
    call $force_solve_sum_tot
    local.set $dow_lef_val_ret

    local.get $dow_rig_val
    local.get $drc_out_h
    local.get $drc_out_v
    local.get $drc_inc_h
    local.get $drc_inc_v
    call $force_solve_sum_tot
    local.set $dow_rig_val_ret

    local.get $upp_lef_val_ret
    local.get $upp_rig_val_ret
    local.get $dow_lef_val_ret
    local.get $dow_rig_val_ret
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

    ;; function : tiber

    ;; tiber_grows

    (global.get $globo_force_flags_tiber_grows)
    (if
      (then

        ;; upp_lef
        local.get $upp_lef_gre
        call $tiber_grows
        local.set $upp_lef_gre

        ;; upp_rig
        local.get $upp_rig_gre
        call $tiber_grows
        local.set $upp_rig_gre

        ;; dow_lef
        local.get $dow_lef_gre
        call $tiber_grows
        local.set $dow_lef_gre

        ;; dow_rig
        local.get $dow_rig_gre
        call $tiber_grows
        local.set $dow_rig_gre
      )
    )

    ;; tiber_spore

    (global.get $globo_force_flags_tiber_spore)
    (if
      (then

        (local.set $mid_ran
          (i32.rem_u
            (call $rando_trixo)
            (i32.const 4)
          )
        )

        local.get $mid_ran
        i32.const 0
        i32.eq
        (if
          (then

            ;; upp_lef

            local.get $upp_lef_gre

            call $tiber_spore

            local.get $upp_lef_gre_pus_awa_x
            i32.add
            local.set $upp_lef_gre_pus_awa_x

            local.get $upp_lef_gre_pus_awa_y
            i32.add
            local.set $upp_lef_gre_pus_awa_y
          )
        )

        local.get $mid_ran
        i32.const 1
        i32.eq
        (if
          (then

            ;; upp_rig

            local.get $upp_rig_gre

            call $tiber_spore

            local.get $upp_rig_gre_pus_awa_x
            i32.add
            local.set $upp_rig_gre_pus_awa_x

            local.get $upp_rig_gre_pus_awa_y
            i32.add
            local.set $upp_rig_gre_pus_awa_y
          )
        )

        local.get $mid_ran
        i32.const 2
        i32.eq
        (if
          (then

            ;; dow_lef

            local.get $dow_lef_gre

            call $tiber_spore

            local.get $dow_lef_gre_pus_awa_x
            i32.add
            local.set $dow_lef_gre_pus_awa_x

            local.get $dow_lef_gre_pus_awa_y
            i32.add
            local.set $dow_lef_gre_pus_awa_y
          )
        )

        local.get $mid_ran
        i32.const 3
        i32.eq
        (if
          (then

            ;; dow_rig

            local.get $dow_rig_gre

            call $tiber_spore

            local.get $dow_rig_gre_pus_awa_x
            i32.add
            local.set $dow_rig_gre_pus_awa_x

            local.get $dow_rig_gre_pus_awa_y
            i32.add
            local.set $dow_rig_gre_pus_awa_y
          )
        )
      )
    )

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
