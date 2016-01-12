s() { cd ~/src/$1; }
_s() { _files -W ~/src/ -/; }
compdef _s s

h() { cd ~/$1; }
_h() { _files -W ~/ -/; }
compdef _h h

db() { cd ~/Dropbox/$1; }
_db() { _files -W ~/Dropbox/ -/; }
compdef _db db

spectrum_ls() {
    txt="The quick brown fox jumps over the lazy dog"
    if (( $# > 0)); then
        txt=$1
    fi
    for code in {000..255}; do
        print -P -- "$code: %F{$code}$txt%f"
    done
}
