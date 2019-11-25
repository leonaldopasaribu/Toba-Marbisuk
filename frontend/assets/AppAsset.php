<?php

namespace frontend\assets;

use yii\web\AssetBundle;

/**
 * Main frontend application asset bundle.
 */
class AppAsset extends AssetBundle
{
    public $basePath = '@webroot';
    public $baseUrl = '@web';
    public $css = [
        'host/css/bootstrap.min.css',
        'host/style.css',
        'host/css/colors.css',
        'host/css/versions.css',
        'host/css/responsive.css',
        'host/css/custom.css',
        'worthy/css/style.css',
        'worthy/css/custom.css',
        'worthy/css/animations.css',
    ];
    public $js = [
        'host/js/modernizer.js',
    ];
    public $depends = [
        'yii\web\YiiAsset',
        'yii\bootstrap\BootstrapAsset',
    ];
}
