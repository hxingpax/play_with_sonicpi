require_relative 'req'

live_loop :director do
  cue_sync
  sleep 8
end


live_loop :sand0 do
  sync RUN_SAND0
  sand BEATS_SAND0
end

live_loop :sand1 do
  sync RUN_SAND1
  sand BEATS_SAND1
end

def n_drum(bts)
  (bts >> 1).times do
    sample HARD_DRUM, pan: -0.3
    sleep 0.25
    sample SOFT_DRUM, pan: -0.3
    sleep 0.25
    sample SOFT_DRUM, pan: -0.3
    sleep 0.25
    sample HEAVY_KICK, pan: -0.3
    sleep 0.25
    sample SOFT_DRUM, pan: -0.3
    sleep 0.5
    sample HARD_DRUM, pan: -0.3
    sleep 0.5
  end
end

live_loop :n_drum0 do
  sync RUN_N_DRUM0
  n_drum BEATS_N_DRUM0
end

live_loop :n_drum1 do
  sync RUN_N_DRUM1
  n_drum BEATS_N_DRUM1
end

live_loop :f_drum do
  sync RUN_F_DRUM
  f_drum
end

live_loop :n_ry do
  sync RUN_N_RY
  play_intro
  [R_B, R_C, R_D].each do |r|
    inter_play_sns r
  end
end

live_loop :f_ry do
  sync RUN_F_RY
  with_fx FX_REVERB do |rev|
    fast_flinger rev
  end
end

live_loop :n_tail do
  sync RUN_N_TAIL
  inter_play_sns R_E
end

live_loop :hum_chime do
  sync RUN_HUM_CHIME
  hum_chime
end
