fname = File.open("temporary/1_104.txt","w")
$stderr = fname
$stdout = fname
puts "this"
fname.close
