s() { cd ~/src/$1; }
_s() { _files -W ~/src/ -/; }
compdef _s s

h() { cd ~/$1; }
_h() { _files -W ~/ -/; }
compdef _h h

db() { cd ~/Dropbox/$1; }
_db() { _files -W ~/Dropbox/ -/; }
compdef _db db
