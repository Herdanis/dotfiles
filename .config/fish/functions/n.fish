function n --description "Open Neovim; cd into directory first if arg is a dir"
    if test (count $argv) -gt 0; and test -d $argv[1]
        builtin cd $argv[1]; and command nvim
    else
        command nvim $argv
    end
end
