<?php
/**
 * General Configuration
 *
 * All of your system's general configuration settings go in here. You can see a
 * list of the available settings in vendor/craftcms/cms/src/config/GeneralConfig.php.
 *
 * @see \craft\config\GeneralConfig
 */

// More info: https://docs.craftcms.com/v3/config/config-settings.html

return [
    // Global settings
    '*' => [
        // Env
        'siteUrl' => getenv('SITE_URL'),
        'devMode' => (bool)getenv('DEV_MODE'),
        'securityKey' => getenv('SECURITY_KEY'),
        'allowUpdates' => (bool)getenv('ALLOW_UPDATES'),
        'backupOnUpdate' => (bool)getenv('BACKUP_ON_UPDATE'),
        'allowAdminChanges' => (bool)getenv('ALLOW_ADMIN_CHANGES'),
        'enableTemplateCaching' => (bool)getenv('ENABLE_TEMPLATE_CACHING'),

        // Constants
        'cpTrigger' => 'admin',
        'defaultWeekStartDay' => 1,
        'omitScriptNameInUrls' => true,
        'useProjectConfigFile' => false,
    ],

    // Dev environment settings
    'dev' => [],

    // Staging environment settings
    'staging' => [],

    // Production environment settings
    'production' => [],
];
