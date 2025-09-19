function phpswitch
    if test (count $argv) -eq 0
        echo "Usage: phpswitch <version> (e.g. 8.2, 8.3)"
        return 1
    end

    set php_version $argv[1]
    set php_path "/usr/bin/php$php_version"

    if not test -x "$php_path"
        echo "❌ PHP version $php_version not found at $php_path"
        return 1
    end

    # Prepend the selected PHP version to the PATH
    set -x PATH "/usr/bin/php$php_version/bin" $PATH
    echo "✅ Switched to PHP $php_version"
    php -v
end