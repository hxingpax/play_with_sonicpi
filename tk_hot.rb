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

use_bpm 100

A = [:c6, :c6, :c6, :c6, :c6, :c6, :c6, :b5, nil, :b5, :c6, nil, :g5, :g5, :a5, nil,
     :c6, :c6, :c6, :c6, :c6, :c6, :c6, :b5, nil, :b5, :c6, nil, :g5, :g5, :a5, nil,
     :c6, :c6, :c6, :c6, :c6, :c6, :c6, :b5, nil, :b5, :c6, nil, :g5, :g5, :a5, nil]

B = [:a5, :a5, :a5, :a5, :a5, :a5, :a5, :a5, nil, :a5, :a5, nil, :e5, :e5, :g5, nil,
     :a5, :a5, :a5, :a5, :a5, :a5, :a5, :a5, nil, :a5, :a5, nil, :e5, :e5, :g5, nil,
     :a5, :a5, :a5, :a5, :a5, :a5, :a5, :a5, nil, :a5, :a5, nil, :e5, :e5, :g5, nil]

C = [:g5, :g5, :g5, :g5, :g5, :g5, :g5, :g5, nil, :g5, :g5, nil, :d5, :d5, :e5, nil,
     :g5, :g5, :g5, :g5, :g5, :g5, :g5, :g5, nil, :g5, :g5, nil, :d5, :d5, :e5, nil,
     :g5, :g5, :g5, :g5, :g5, :g5, :g5, :g5, nil, :g5, :g5, nil, :d5, :d5, :e5, nil]

D = [:e5, :e5, :e5, :e5, :e5, :e5, :e5, :e5, nil, :e5, :e5, nil, :b4, :b4, :c5, nil,
     :e5, :e5, :e5, :e5, :e5, :e5, :e5, :e5, nil, :e5, :e5, nil, :b4, :b4, :c5, nil,
     :f5, :f5, :f5, :f5, :f5, :f5, :f5, :f5, nil, :f5, :f5, nil, :c5, :c5, :c5, nil,
     :d5, :f5, :a5, :c6, :d6, :c6, :a5, :f5, :e5, :g5, :b5, :d6, :e6, :d6, :b5, :g5]

E = [:a2, nil, :a3, nil, :a2, nil, :a3, nil, :a2, nil, :a3, nil, :a2, nil, :a3, nil,
     :a2, nil, :a3, nil, :a2, nil, :a3, nil, :a2, nil, :a3, nil, :a2, nil, :a3, nil,
     :f2, nil, :f3, nil, :f2, nil, :f3, nil, :f2, nil, :f3, nil, :f2, nil, :f3, nil,
     :d3, nil, :d4, nil, :d3, nil, :d4, nil, :e3, nil, :e4, nil, :e3, nil, :e4, nil]

notes_a = MyNotes.new(A, 4)
notes_b = MyNotes.new(B, 4)
notes_c = MyNotes.new(C, 4)
notes_d = MyNotes.new(D, 4)
notes_e = MyNotes.new(E, 4)

raise '!' unless notes_a.n_beats == notes_b.n_beats &&
    notes_a.n_beats == notes_c.n_beats &&
    notes_a.n_beats == notes_d.n_beats &&
    notes_a.n_beats == notes_e.n_beats

live_loop :director do
  sleep notes_a.n_beats
end

live_loop :a do
  sync :director
  notes_a.go
end

live_loop :b do
  sync :director
  notes_b.go
end

live_loop :c do
  sync :director
  notes_c.go
end

live_loop :d do
  sync :director
  notes_d.go
end

live_loop :e do
  sync :director
  notes_e.go
end
