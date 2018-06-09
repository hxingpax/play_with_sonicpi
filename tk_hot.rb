comment do require_relative 'bk.rb' end

use_bpm 100

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

BEATS = E.length / 4

RA = []
put_notes RA, A, 4

RB = []
put_notes RB, B, 4

RC = []
put_notes RC, C, 4

RD = []
put_notes RD, D, 4

RE = []
put_notes RE, E, 4


live_loop :director do
  sleep BEATS
end

live_loop :a do
  sync :director
  ite_sns RA do |note|
      play note
  end
end

live_loop :b do
  sync :director
  ite_sns RB do |note|
      play note
  end
end

live_loop :c do
  sync :director
  ite_sns RC do |note|
      play note
  end
end

live_loop :d do
  sync :director
  ite_sns RD do |note|
      play note
  end
end

live_loop :e do
  sync :director
  ite_sns RE do |note|
      play note
  end
end
