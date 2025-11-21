function conda
    # 1. Set the path to your actual Conda installation
    # Based on your 'which conda' output: /home/user/.cache/conda/condabin/conda
    if test -d $HOME/.cache/conda
        set -g ANACONDA_ROOT $HOME/.cache/conda
    else if test -d $HOME/anaconda3
        set -g ANACONDA_ROOT $HOME/anaconda3
    else if test -d $HOME/miniconda3
        set -g ANACONDA_ROOT $HOME/miniconda3
    else
        echo "Error: Could not find conda installation in .cache/conda, anaconda3, or miniconda3"
        return 1
    end

    # 2. Check if Conda is already initialized
    if not functions -q conda_activate
        # Initialize Conda using the binary found at the path
        eval "$ANACONDA_ROOT/condabin/conda" "shell.fish" hook | source
    end

    # 3. Execute the command
    if functions -q conda
        # If the hook created a new function (the real conda), call it
        eval conda $argv
    else
        # Fallback to the binary if the function wasn't created
        command conda $argv
    end
end
