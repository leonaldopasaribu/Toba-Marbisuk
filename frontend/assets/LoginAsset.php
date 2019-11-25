<?php

namespace frontend\assets;

use yii\web\AssetBundle;

/**
 * Main frontend application asset bundle.
 */
class LoginAsset extends AssetBundle
{
    public $basePath = '@webroot';
    public $baseUrl = '@web';
    public $css = [
        'fonts/font-awesome-4.7.0/css/font-awesome.min.css',
        'vendor/animate/animate.css',
        'css/util.css',
        'css/main.css',
    ];
    public $js = [
        'vendor/jquery/jquery-3.2.1.min.js',
        'vendor/bootstrap/js/popper.js',
        'vendor/bootstrap/js/bootstrap.min.js',
        'vendor/select2/select2.min.js',
        'vendor/tilt/tilt.jquery.min.js',
        'js/main.js',
    ];
    public $depends = [
        'yii\web\YiiAsset',
        'yii\bootstrap\BootstrapAsset',
    ];
}
