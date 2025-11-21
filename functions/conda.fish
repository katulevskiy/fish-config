function conda
    # Initialize variable
    set -l CONDA_BIN ""

    # 1. DYNAMIC SEARCH: Find where the executable actually lives.
    # We check the binary specifically to avoid empty folder errors.
    if test -f $HOME/.cache/conda/condabin/conda
        set CONDA_BIN "$HOME/.cache/conda/condabin/conda"
    else if test -f $HOME/anaconda3/condabin/conda
        set CONDA_BIN "$HOME/anaconda3/condabin/conda"
    else if test -f $HOME/miniconda3/condabin/conda
        set CONDA_BIN "$HOME/miniconda3/condabin/conda"
    else
        echo "Error: Could not find conda binary in standard locations."
        return 1
    end

    # 2. INITIALIZE: Check if 'conda_activate' is defined.
    if not functions -q conda_activate
        eval "$CONDA_BIN" "shell.fish" hook | source
    end

    # 3. EXECUTE: Run the binary directly using the absolute path.
    # We do NOT use 'command conda' here because if PATH is missing,
    # it triggers this function again (infinite loop).
    eval "$CONDA_BIN" $argv
end
