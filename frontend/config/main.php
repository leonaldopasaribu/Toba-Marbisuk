<?php
$params = array_merge(
    require(__DIR__ . '/../../common/config/params.php'),
    require(__DIR__ . '/../../common/config/params-local.php'),
    require(__DIR__ . '/params.php'),
    require(__DIR__ . '/params-local.php')
);

return [
    'id' => 'app-frontend',
    'basePath' => dirname(__DIR__),
    'bootstrap' => ['log'],
    'homeUrl' => '/WebPKM2018',
    'controllerNamespace' => 'frontend\controllers',
    'components' => [
        'request' => [
            'csrfParam' => '_csrf-frontend',
            'baseUrl' => '/WebPKM2018',
        ],
        'user' => [
            'identityClass' => 'common\models\User',
            'enableAutoLogin' => true,
            'identityCookie' => ['name' => '_identity-frontend', 'httpOnly' => true],
        ],
        'session' => [
            // this is the name of the session cookie used for login on the frontend
            'name' => 'advanced-frontend',
        ],
        'log' => [
            'traceLevel' => YII_DEBUG ? 3 : 0,
            'targets' => [
                [
                    'class' => 'yii\log\FileTarget',
                    'levels' => ['error', 'warning'],
                ],
            ],
        ],
        'errorHandler' => [
            'errorAction' => 'site/error',
        ],
        // 'urlManager' => [
        // 'class' => 'yii\web\UrlManager',
        // 'enablePrettyUrl' => false,
        // 'showScriptName' => false,
        // 'enableStrictParsing' => true,
        // 'rules' => [
        //     '/' => 'site/index',
        //     'login' => 'site/login',
        //     'login-teacher' => 'site/login-teacher',
        //     'signup-student' => 'site/signup-student',
        //     'signup-teacher' => 'site/signup-teacher',
        //     'logout' => 'site/logout',
        //     'signup' => 'site/signup',
        //     'confirm' => 'site/confirm',
        //     'contact' => 'site/contact',
        //     'request-password-reset' => 'site/request-password-reset',
        //     'reset-password' => 'site/reset-password',
        //     ],
        // ],
        
        'urlManager' => [
            'baseUrl' => '/WebPKM2018',
            'enablePrettyUrl' => false,
            'showScriptName' => false,
            'rules' => [
            ],
        ],
        
    ],
    'params' => $params,
];
