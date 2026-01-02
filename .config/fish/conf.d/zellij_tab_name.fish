function __update_zellij_tab_name
    if set -q ZELLIJ_SESSION_NAME
        and test "$ZELLIJ_SESSION_NAME" = zellij
        command nohup zellij action rename-tab (prompt_pwd) >/dev/null 2>&1
    end
end

function zellij_tab_name_update_pre --on-event fish_preexec
    __update_zellij_tab_name
end

function zellij_tab_name_update_post --on-event fish_postexec
    __update_zellij_tab_name
end
