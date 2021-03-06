require 'set'

$val = {}
$h = STDIN.read.split("\n").each_with_index.map{|x, idx|
    i = x.split("/").map(&:to_i)
    $val[idx] = i
    i.zip([idx, idx])
}.reduce(&:+).group_by(&:first).map{|x,y|
    [x, Set.new(y.map{|z| z[1]})]
}.to_h

def best(cur, vis, depth)
    meb = $h[cur] - vis
    return 0 if meb.empty?
    meb.map{|x|
        nxt = if $val[x][0] == cur then $val[x][1] else $val[x][0] end
        (best(nxt, vis + [x], depth+1) + $val[x].sum) + depth*1000000000
    }.max
end

puts best(0, Set.new, 0) % 1000000000
