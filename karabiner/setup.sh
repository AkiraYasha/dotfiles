#!/bin/sh

cli=/Applications/Karabiner.app/Contents/Library/bin/karabiner

$cli set remap.find_winstyle_no_term 1
/bin/echo -n .
$cli set repeat.initial_wait 300
/bin/echo -n .
$cli set remap.undo_winstyle_no_term 1
/bin/echo -n .
$cli set remap.redo_winstyle_no_term 1
/bin/echo -n .
$cli set repeat.wait 20
/bin/echo -n .
$cli set remap.new_winstyle_no_term 1
/bin/echo -n .
$cli set remap.pc_style_copy_paste 1
/bin/echo -n .
$cli set remap.pc_application2optionLspace 1
/bin/echo -n .
$cli set remap.select_all_winstyle_no_term 1
/bin/echo -n .
$cli set remap.save_winstyle_no_term 1
/bin/echo -n .
/bin/echo
