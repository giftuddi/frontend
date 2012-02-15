ServerRoot "GXY_DEPLOY_ROOT/httpd"
DocumentRoot "GXY_DEPLOY_ROOT/httpd/htdocs"

Listen 8000
ServerAdmin root@example.com

<Directory />
    Options FollowSymLinks
    AllowOverride None
    Order deny,allow
    Deny from all
</Directory>

<Directory "GXY_DEPLOY_ROOT/httpd-2.2.22/htdocs">
    Options Indexes FollowSymLinks
    AllowOverride None
    Order allow,deny
    Allow from all
</Directory>

ErrorLog "logs/error_log"
LogLevel warn
LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined
LogFormat "%h %l %u %t \"%r\" %>s %b" common
CustomLog "logs/access_log" common

DefaultType text/plain
