require_relative 'bk'

SYNTH_PIANO = :piano
SYNTH_PULSE = :pulse

HARD_DRUM = :drum_bass_hard
SOFT_DRUM = :drum_bass_soft
HEAVY_KICK = :drum_heavy_kick

FX_REVERB = :reverb

RUN_N_RY = :run_n_ry
RUN_SAND0 = :run_sand0
RUN_N_DRUM0 = :run_n_drum0
RUN_HUM_CHIME = :run_hum_chime
RUN_F_RY = :run_f_ry
RUN_F_DRUM = :run_f_drum
RUN_SAND1 = :run_sand1
RUN_N_DRUM1 = :run_n_drum1
RUN_N_TAIL = :run_n_tail


M_A = [:e5, :e5, nil, :e5, nil, :c5, :e5, nil,
       :g5, nil, nil, nil, nil, nil, nil, nil]
NOTES_PB_A = 4 # notes per beat a
BEATS_A = 4 # beats count a

M_B0 = [:c5, nil, nil, :g4, nil, nil, :e4, nil,
        nil, :a4, nil, :b4, nil, :Bb4, :a4, nil]
M_B1 = [:g4, :e5, :g5]
M_B2 = [:a5, nil, :f5, :g5,
        nil, :e5, nil, :c5, :d5, :b4, nil, nil]
NOTES_PB_B0 = 4
NOTES_PB_B1 = 3
NOTES_PB_B2 = 4
BEATS_B = 8

M_C = [nil, nil, :g5, :fs5, :f5, :ds5, nil, :e5,
       nil, :gs4, :a4, :c5, nil, :a4, :c5, :d5,
       nil, nil, :g5, :fs5, :f5, :ds5, nil, :e5,
       nil, :c6, nil, :c6, :c6, nil, nil, nil,
       nil, nil, :g5, :fs5, :f5, :ds5, nil, :e5,
       nil, :gs4, :a4, :c5, nil, :a4, :c5, :d5,
       nil, nil, :ds5, nil, nil, :d5, nil, nil,
       :c5, nil, nil, nil, nil, nil, nil, nil]
NOTES_PB_C = 4
BEATS_C = 16

M_D = [:c5, :c5, nil, :c5, nil, :c5, :d5, nil,
       :e5, :c5, nil, :a4, :g4, nil, nil, nil,
       :c5, :c5, nil, :c5, nil, :c5, :d5, :e5,
       nil, nil, nil, nil, nil, nil, nil, nil,
       :c5, :c5, nil, :c5, nil, :c5, :d5, nil,
       :e5, :c5, nil, :a4, :g4, nil, nil, nil,
       :e5, :e5, nil, :e5, nil, :c5, :e5, nil,
       :g5, nil, nil, nil, nil, nil, nil, nil]
NOTES_PB_D = 4
BEATS_D = 16

M_E0 = [:e5, :c5, nil, :g4, nil, nil, :gs4, nil,
        :a4, :f5, nil, :f5, :a4, nil, nil, nil]
M_E1 = [:b4, :a5, :a5,
        :a5, :g5, :f5]
M_E2 = [:e5, :c5, nil, :a4, :g4, nil, nil, nil]
M_E3 = [:e5, :c5, nil, :g4, nil, nil, :gs4, nil,
        :a4, :f5, nil, :f5, :a4, nil, nil, nil,
        :b4, :f5, nil, :f5]
M_E4 = [:f5, :e5, :d5]
M_E5 = [:g5, :e5, nil, :e5, :c5, nil, nil, nil]
NOTES_PB_E0 = 4
NOTES_PB_E1 = 3
NOTES_PB_E2 = 4
NOTES_PB_E3 = 4
NOTES_PB_E4 = 3
NOTES_PB_E5 = 4
BEATS_E = 16


class SimpleNotes
  attr_reader :notes, :interval

  def initialize(notes, interval)
    @notes = notes
    @interval = interval
  end
end

def put_notes(ar, ns, ns_unit)
  ar << SimpleNotes.new(ns, 1.0 / ns_unit)
end

def ite_sns(sn_array)
  sn_array.each do |sn|
    sn.notes.each do |note|
      yield note if note
      sleep sn.interval
    end
  end
end

def fast_ite_sns(sn_array)
  sn_array.each do |sn|
    gap = sn.interval / 2.0
    sn.notes.each do |note|
      yield note if note
      sleep gap
    end
  end
end

class InterPan
  def initialize(pos)
    @pos = pos
  end

  def get
    @pos *= -1
  end
end

R_A = []
put_notes R_A, M_A, NOTES_PB_A

R_B = []
put_notes R_B, M_B0, NOTES_PB_B0
put_notes R_B, M_B1, NOTES_PB_B1
put_notes R_B, M_B2, NOTES_PB_B2

R_C = []
put_notes R_C, M_C, NOTES_PB_C

R_D = []
put_notes R_D, M_D, NOTES_PB_D

R_E = []
put_notes R_E, M_E0, NOTES_PB_E0
put_notes R_E, M_E1, NOTES_PB_E1
put_notes R_E, M_E2, NOTES_PB_E2
put_notes R_E, M_E3, NOTES_PB_E3
put_notes R_E, M_E4, NOTES_PB_E4
put_notes R_E, M_E5, NOTES_PB_E5


BEATS_BCD = BEATS_B + BEATS_C + BEATS_D
BEATS_CD = BEATS_C + BEATS_D

BEATS_N_INTRO = BEATS_A
BEATS_N_MIDDLE = BEATS_BCD << 1
BEATS_SLEEP_0 = 4
BEATS_F = (BEATS_BCD >> 1) * 3
BEATS_F_TAIL = BEATS_A >> 1
BEATS_SLEEP_1 = 4
BEATS_N_TAIL = BEATS_E << 1
BEATS_SAND0 = BEATS_BCD << 1
BEATS_SAND1 = (BEATS_BCD >> 1) + BEATS_F_TAIL + BEATS_SLEEP_1 + BEATS_N_TAIL
BEATS_N_DRUM0 = BEATS_CD << 1
BEATS_N_DRUM1 = BEATS_N_TAIL


def f_drum
  with_synth :fm do
    2.times do
      sleep 2
      (((BEATS_BCD >> 1) - 2) << 1).times do
        sample HARD_DRUM, pan: -0.3
        sleep 0.25
        play :e2, release: 0.2, pan: -0.2
        sample :elec_cymbal, rate: 12, amp: 0.7, pan: -0.5
        sleep 0.25
      end
    end
  end
end

def play_intro
  with_synth SYNTH_PIANO do
    ite_sns R_A do |note|
      play note
    end
  end
end

def hum_chime
  with_fx FX_REVERB, room: 1 do
    sleep 2
    sample :guit_harmonics, rate: -2, amp: 4, pan: 0.3
    sleep 2
    ((BEATS_BCD >> 1) >> 2).times do
      sample :elec_chime, amp: 2, pan: 0.4
      sleep 2
      sample :bd_boom, amp: 4, pan: -0.3
      sleep 2
    end
  end
end

def fast_flinger(rev)
  ipan = InterPan.new(0.5)
  3.times do
    control rev, mix: rrand(0.1, 0.3)
    with_fx :slicer, phase: 0.125 do
      sample :ambi_lunar_land, sustain: 0, release: 8, amp: 3, pan: ipan.get
    end

    control rev, mix: rrand(0.1, 0.6)
    r = rrand(0.1, 0.3)
    with_synth SYNTH_PULSE do
      fast_ite_sns R_B do |note|
        play note, release: r, cutoff: rrand(80, 130)
      end
    end

    control rev, mix: rrand(0.1, 0.6)
    r = rrand(0.1, 0.3)
    with_synth :prophet do
      fast_ite_sns R_C do |note|
        play note, release: r, cutoff: rrand(80, 130), amp: 2
      end
    end

    control rev, mix: rrand(0.1, 0.6)
    r = rrand(0.1, 0.3)
    fast_ite_sns R_D do |note|
      with_synth(:tb303) {play note, release: r, cutoff: rrand(80, 130), cmp: 0.8}
      with_synth(SYNTH_PULSE) {play note, release: 0.1, cmp: 0.7, pan: ipan.get}
    end
  end

  control rev, mix: 0.4
  with_fx :echo, phase: 0.25, decay: 8 do
    with_synth :tb303 do
      fast_ite_sns R_A do |note|
        play note, release: 0.05, cutoff: rrand(60, 120), amp: 0.7
      end
    end
  end
end

def inter_play_sns(sns)
  ipan = InterPan.new(0.6)
  ite_sns sns do |note|
    with_synth(SYNTH_PIANO) {play note}
    with_synth(SYNTH_PULSE) {play note, amp: 0.7, release: 0.1, pan: ipan.get}
  end
  ite_sns sns do |note|
    with_synth(SYNTH_PULSE) {play note, amp: 0.7, release: 0.1, pan: ipan.get}
  end
end

def sand(beats)
  (beats << 1).times do
    sample :elec_cymbal, amp: 0.7, pan: 0.6, rate: 12
    sleep 0.5
  end
end

def cue_sync
  cue RUN_N_RY
  sleep BEATS_N_INTRO
  cue RUN_SAND0
  beats_tmp = BEATS_B << 1
  sleep beats_tmp
  cue RUN_N_DRUM0
  sleep BEATS_N_MIDDLE - beats_tmp

  cue RUN_HUM_CHIME

  sleep BEATS_SLEEP_0

  cue RUN_F_RY
  beats_tmp = BEATS_BCD >> 1
  sleep beats_tmp
  cue RUN_F_DRUM
  sleep beats_tmp
  cue RUN_SAND1
  sleep beats_tmp + BEATS_F_TAIL + BEATS_SLEEP_1

  cue RUN_N_DRUM1
  cue RUN_N_TAIL
  sleep BEATS_N_TAIL
end
