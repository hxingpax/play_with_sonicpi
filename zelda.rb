comment do
  require_relative 'bk.rb'
end

class MyNotes
  attr_reader :n_beats

  def initialize(notes, note_group_len)
    @notes = notes
    @interval = 1.0 / note_group_len
    @n_beats = notes.length / note_group_len
  end

  def ite(times_speed_up = 1)
    gap = @interval / times_speed_up
    @notes.each do |note|
      yield note if note
      sleep gap
    end
  end

  def go
    ite {|note| play note}
  end
end

use_bpm 120

Z_MEL = [:g4, :g4, :g4, nil, :c5, nil, nil, nil, :b4, :c5, :d5, nil, :c5, nil, :b4, :a4,
         :g4, :g4, :g4, nil, :c5, nil, nil, nil, :b4, :c5, :d5, :e5, :f5, nil, :e5, :d5,
         :c5, :b4, :a4, :g4, :f4, :e4, :f4, :g4, :c5, :b4, :a4, :g4, :a4, :g4, :f4, :e4,
         :d5, :d5, :d5, nil, :g5, nil, nil, nil, :f5, :e5, :d5, :c5, :b4, nil, nil, nil]

Z_BASS = [:c2, nil, :c3, nil, :c2, nil, :c3, nil, :f2, nil, :f3, nil, :f2, nil, :f3, nil,
          :c2, nil, :c3, nil, :c2, nil, :c3, nil, :g2, nil, :g3, nil, :g2, nil, :g3, nil,
          :f2, nil, :f3, nil, :f2, nil, :f3, nil, :c2, nil, :c3, nil, :c2, nil, :c3, nil,
          :g2, nil, :g3, nil, :g2, nil, :g3, nil, :c2, nil, :c3, nil, :c2, nil, :c3, nil]

notes = {
  mel: MyNotes.new(Z_MEL, 4),
  bass: MyNotes.new(Z_BASS, 4)
}

n_beats_values = notes.values.map(&:n_beats)
raise '!' unless n_beats_values.uniq.size == 1

live_loop :director do
  sleep notes[:mel].n_beats
end

notes.each do |name, notes_obj|
  live_loop name do
    sync :director
    notes_obj.go
  end
end
