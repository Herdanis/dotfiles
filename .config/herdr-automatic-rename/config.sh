# ============================================
# herdr-automatic-rename
# ============================================
# Conflict fix: herdr.auto-title owns tab titles (it has no off switch for
# tabs) and writes its own position prefix. This plugin keeps workspace
# naming + numbering, drops tab naming/numbering so the two stop fighting.
# Sourced by automatic-rename.sh before naming.sh.

NAME_TABS=0
AUTO_INDEX_TABS=0
