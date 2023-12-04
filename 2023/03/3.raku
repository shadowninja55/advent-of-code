my @lines = "input.txt".IO.lines;
my %gears;

for @lines.kv -> $j, $line {
  for $line.comb(/<-[\d.]>/, :match) {
    %gears{.from + $j * i} = [];
  }
}

for @lines.kv -> $j, $line {
  for $line.comb(/\d+/, :match) {
    for (.from - 1)..(.to) -> $y {
      for ($j - 1)..($j + 1) -> $x {
        with %gears{$y + $x * i} -> $gear { $gear.append(+$_) };
      }
    }
  }
}

say %gears.values.map(*.Slip).sum;
say ($_[0] * $_[1] if .elems == 2 for %gears.values).sum;
