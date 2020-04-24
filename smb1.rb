@bpm = 200

main_parts = [
  %w[
    C r r G3  r r E3 r   r A3 r B3   r Bb3 A3 r
    ! G3 E G  A r F G    r E r C     D B3 r r
  ] * 2,
  
  %w[
    r r G Gb  F Ds r E   r Gs3 A3 C  r A3 C D
    r r G Gb  F Ds r E   r C5 r C5   C5 r r r
    r r G Gb  F Ds r E   r Gs3 A3 C  r A3 C D
    r r Eb r  r D r r    C r r r     r r r r
  ],
  
  %w[
    C C r C   r C D r    E C r A3    G3 r r r
    C C r C   r C D E    r r r r     r r r r
    
    C C r C   r C D r    E C r A3    G3 r r r
    E E r E   r C E r    G r r r     G3 r r r
  ],
  
  %w[
    E C r G3  r r Gs3 r  A3 F r F    A3 r r r
    ! B3 A A  ! A G F    E C r A3    G3 r r r
    
    E C r G3  r r Gs3 r  A3 F r F    A3 r r r
    B3 F r F  ! F E D    C r r r     r r r r
  ]
]

lower_parts = [
  %w[
    G r r E    r r C r     r F r G   r Gb F r
    ! E C5 E5  F5 r D5 E5  r C5 r A  B G r r
  ] * 2,
  
  %w[
    C r r G    r r C5 r    F r r C5  C5 r F r
    C r r E    r r G C5    r r r r   r r G r
    
    C r r G    r r C5 r    F r r C5  C5 r F r
    C r Ab r   r Bb r r    C5 r r G  G r C r
  ],
  
  %w[
    Ab2 r r Eb  r r Ab r    G r r C   r r G2 r
    Ab2 r r Eb  r r Ab r    G r r C   r r G2 r
    
    Ab2 r r Eb  r r Ab r    G r r C   r r G2 r
    D D r D     r D D r     G4 r r r  G r r r
  ],
  
  %w[
    C4 r r Fs   G r C5 r    F r F r   C5 C5 F r
    D r r F     G r B r     G r G r   C5 C5 G r
    
    C4 r r Fs   G r C5 r    F r F r   C5 C5 F r
    G r r G     ! G A B     C5 r G r  C r r r
  ],
]

def play_notes(offset, notes)
  notes.each_slice(4) do |slice|
    bpm, slice = if slice[0] == '!'
      [@bpm * 3 / 4, slice[1..-1]]
    else
      [@bpm, slice]
    end
    with_bpm bpm do
      slice.each do |n|
        i = note(n.to_sym)
        play i + offset, release: 0, attack: 0, sustain: 0.5
        sleep 0.5
      end
    end
  end
end

[
  [:dpulse, main_parts, 12],
  [:dtri, lower_parts, -12],
].each do |synth_name, parts, offest|
  in_thread do
    with_synth synth_name do
      play_notes offest, parts[2][48..-1]
      play_notes offest, [
        *parts[0],
        *parts[1] * 2,
        *parts[2],
        *parts[0],
        *parts[3] * 2,
        *parts[2],
        *parts[3],
      ].cycle
    end
  end
end