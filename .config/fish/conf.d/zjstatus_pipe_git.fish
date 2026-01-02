function __zjstatus_pipe_git
    if not set -q ZELLIJ
        return
    end

    set -l git_root (git rev-parse --show-toplevel 2>/dev/null)
    if test -n "$git_root"
        set -l repo (basename $git_root)
        zellij pipe "zjstatus::pipe::pipe_git_repo::$repo"
    else
        zellij pipe "zjstatus::pipe::pipe_git_repo::"
    end

    set -l branch (git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if test -n "$branch"
        zellij pipe "zjstatus::pipe::pipe_git_branch::$branch"
    else
        zellij pipe "zjstatus::pipe::pipe_git_branch::"
    end

    set -l dirty (git status --porcelain 2>/dev/null | count)
    if test "$dirty" -gt 0
        zellij pipe "zjstatus::pipe::pipe_git_status::~$dirty"
    else
        zellij pipe "zjstatus::pipe::pipe_git_status::"
    end
end

function __zjstatus_pipe_git_on_pwd --on-variable PWD
    __zjstatus_pipe_git
end

function __zjstatus_pipe_git_postexec --on-event fish_postexec
    __zjstatus_pipe_git
end

function __zjstatus_pipe_git_on_prompt --on-event fish_prompt
    __zjstatus_pipe_git
end
