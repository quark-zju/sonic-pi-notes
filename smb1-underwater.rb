use_bpm 216

main_parts = '''
  D E Fs     G A As          B/2 B/2 B B+E    B+F*2 G
  G+E5*3     Fs+Ds5*3        G+E5*3           r/2 G/2 A/2 B/2 C5/2 D5/2
  G+E5*3     Fs+Ds5*2 A+F5   G+E5*3           r*2 r/2 G/2
  F+D5*3     E+Cs5*3         F+D5*3           r/2 G/2 A/2 B/2 C5/2 Cs5/2
  F+D5*3     G+B3*2 A+F5     G+E5*3           r*2 r/2 G/2
  E5+G5*3    D5+G5*3         Db5+G5*3         G5 A5 r/2 G5/2
  D5+F5*3    Db5+F5*3        C5+F5*3          F5 G5 r/2 F5/2
  C+C5+E5*3  F+A G+B B+F5    B+E5/2 B+E5/2 B+E5*1.5 F+B/2 E+C5*3
  '''

lower_parts = '''
  D Cs C     B3 C Cs         D/2 D/2 D G3     G3*3
  C3 G3 C    B2 G3 B3        C3 G3 C          E3 G3 C
  C3 G3 C    B2 G3 B3        C3 G3 C          E3 G3 C
  D3 G3 B3   Cs3 Fs3 As3     D3 G3 B3         B2 G3 B3
  D3 G3 B3   B2 G3 B3        C3 G3 C          G2 G3 C
  C3 G3 E    B2 G3 D         Bb2 G3 Db        Db3 G3 E
  D3 A3 F    Db3 A3 F        C3 A3 F          B2 G3 F
  C2 G3 E    G2 G3 G3        F3/2 F3/2 F3*1.5 B2/2 C3*3
  '''

def play_notes(notes, offset: 0)
  notes.each do |s|
    div = mul = 1.0
    if s['/']
      s, div = s.split('/', 2)
      div = div.to_f
    end
    if s['*']
      s, mul = s.split('*', 2)
      mul = mul.to_f
    end
    time = 1.0 * mul / div
    s.split('+').each do |n|
      i = note(n.to_sym)
      play i + offset, release: 0, attack: 0, sustain: time
    end
    sleep time
  end
end

in_thread do
  use_synth :pulse
  play_notes main_parts.split.cycle
end

in_thread do
  use_synth :tri
  play_notes lower_parts.split.cycle
end
