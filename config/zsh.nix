{ pkgs, config, ... }:

{
    programs.zsh = {
    enable = true;
    localVariables = {
        PROMPT = "%F{yellow} %~ %B%F{blue}%f%b ";
    };
    history = {
        save = 1000;
        size = 1000;
        path = "$HOME/.cache/.zsh_hist";
    };
    
    shellAliases = {
        h = "$EDITOR ~/.config/nixpkgs/home.nix";
        hs = "home-manager switch";
        m = "mkdir -p";
        fcd = "cd $(find -type d | fzf)";
        ls = "exa --icons";
        v = "nvim";
        g = "git";
        tree = "exa --tree --icons";
        rm = "rm -i";
        cp = "cp -i";
        mv = "mv -i";
    };

    plugins = [ 
        {
            name = "syntax-highlighting";
            src = pkgs.fetchFromGitHub {
                owner = "zsh-users";
                repo = "zsh-syntax-highlighting";
                rev = "c10808ad5f3ace0696f900b9c543172bc1f8e27c";
                sha256 = "0mn7nlsayh6l7vkyg62l78wzi63slh5q5g432yy36vl3xh9kvjin";
            };
        }
        {
            name = "autosuggestions";
            src = pkgs.fetchFromGitHub {
                owner = "zsh-users";
                repo = "zsh-autosuggestions";
                rev = "a411ef3e0992d4839f0732ebeb9823024afaaaa8";
                sha256 = "1g3pij5qn2j7v7jjac2a63lxd97mcsgw6xq6k5p7835q9fjiid98";
            };
        }
    ];
};
}
