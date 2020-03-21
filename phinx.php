<?php
// Setup autoloading
include __DIR__ . '/vendor/autoload.php';

$adapter = new \Laminas\Db\Adapter\Adapter([
    'driver' => 'Pdo_Mysql',
    'database' => env('MYSQL_DATABASE'),
    'username' => env('MYSQL_USER'),
    'password' => env('MYSQL_PASSWORD'),
    'hostname' => env('MYSQL_HOSTNAME'),
    'port' => env('MYSQL_PORT'),
    'charset' => 'utf8'
]);


return [
    'paths' => [
        'migrations' => __DIR__ . '/db/migrations',
        'seeds' => __DIR__ . 'db/seeds',
    ],
    'environments' => [
        'default_database' => 'default',
        'default' => [
            'name' => $adapter->getCurrentSchema(),
            'connection' => $adapter->getDriver()->getConnection()->getResource(),
        ],
    ]
];

