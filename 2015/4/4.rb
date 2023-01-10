require "digest"
I="ckczppom"
def c l
  (0..Float::INFINITY).find { Digest::MD5.hexdigest(I + _1.to_s).start_with?("0" * l) }
end
puts c 5
puts c 6
