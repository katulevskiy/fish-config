# ~/.config/fish/functions/conda.fish
# This function handles on-demand Conda initialization for Fish shell.

function conda
    # Path to your anaconda3 installation directory (parent of condabin)
    # This MUST be correct.
    set -l ANACONDA_ROOT /home/user/anaconda3

    # Check if Conda's main 'activate' function is already available.
    # If not, it means Conda hasn't been fully initialized in this session yet.
    if not functions -q conda_activate
        # Source the Conda shell hook to properly initialize Conda's functions,
        # including `conda_activate` and prompt modifications.
        # It's crucial to use the correct path to the 'shell.fish' hook.
        status --is-interactive; and "$ANACONDA_ROOT/condabin/conda" "shell.fish" hook | source

        # After sourcing, Conda's functions should be available.
        # Now, re-execute the *original* 'conda' command with all its arguments.
        # 'exec' replaces the current shell process, ensuring environment changes take effect.
        # This is a common pattern for on-demand sourcing.
        exec command conda $argv
    else
        # If Conda is already initialized (conda_activate exists),
        # just execute the original 'conda' command directly.
        command conda $argv
    end
end
