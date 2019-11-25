<?php

/* @var $this \yii\web\View */
/* @var $content string */

use yii\helpers\Html;
use yii\bootstrap\Nav;
use yii\bootstrap\NavBar;
use yii\widgets\Breadcrumbs;
use frontend\assets\AppAsset;
use frontend\assets\LoginAsset;
use common\widgets\Alert;

AppAsset::register($this);
LoginAsset::register($this);

?>
<?php $this->beginPage() ?>
<!DOCTYPE html>
<html lang="<?= Yii::$app->language ?>">
<head>
    <meta charset="<?= Yii::$app->charset ?>">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <?= Html::csrfMetaTags() ?>
    <title><?= Html::encode($this->title) ?></title>
    <link rel="icon" href="img/tm.png" type="image/png">
    <?php $this->head() ?> 
</head>
<body>
<?php $this->beginBody() ?>
<div class="wrap">
    <header class="header header_style_01">
        <?php
        NavBar::begin([
            'brandLabel' => '<img src="img/toba marbisuk.png"; class="img-responsive"; width="210px">',
            'brandUrl' => Yii::$app->homeUrl,
            'options' => [
                'class' => 'megamenu navbar navbar-default',
            ],
        ]);
        $menuItems = [
            ['label' => 'Beranda', 'url' => ['/site/index']],
            ['label' => 'Materi', 'url' => ['/materi/index-by-student']],
            ['label' => 'Latihan', 'url' => ['/site/index']],
            ['label' => 'Tentang', 'url' => ['/site/tentang']],
        ];

        $menuItemsRight = [
            // ['label' => 'Masuk', 'url' => ['/site/login']],
            // ['label' => 'Daftar', 'url' => ['/site/signup']],
        ];

        if (Yii::$app->user->isGuest) {
            $menuItemsRight[] = ['label' => 'Masuk', 'url' => ['/site/login']];
            $menuItemsRight[] = ['label' => 'Daftar', 'url' => ['/site/signup']];
        } else if(Yii::$app->user->identity->role == 2){
            $menuItems = [
                ['label' => 'Beranda', 'url' => ['/site/index']],
                ['label' => 'Materi', 'url' => ['/materi/index-by-student']],
                ['label' => 'Latihan', 'url' => ['/kuis/index-by-student']],
                ['label' => 'Kuis', 'url' => ['/kuis/latihan-by-student']],
            ];
            
            $user_id = Yii::$app->user->identity->id;
            $menuItemsRight[] = [
                    'label' => Yii::$app->user->identity->username,
                    'items' => [
                        ['label' => 'Profil', 'url' => ['/site/profil-siswa', 'id' => $user_id]],
                         '<li class="divider"></li>',
                        ['label' => 'Keluar (' . Yii::$app->user->identity->nama_lengkap . ')',
                        'url' => ['/site/logout'],
                        'linkOptions' => ['data-method' => 'post']]
                         // '<li class="dropdown-header">Dropdown Header</li>',
                    ],  
                ];

        } else if(Yii::$app->user->identity->role == 1){
            $menuItems = [
                ['label' => 'Beranda', 'url' => ['/site/index']],
                ['label' => 'Materi', 'url' => ['/materi/index-by-teacher']],
                ['label' => 'Latihan', 'url' => ['/kuis/index-by-teacher']],
            ];
            $user_id = Yii::$app->user->identity->id;
            $menuItemsRight[] = [
                    'label' => Yii::$app->user->identity->username,
                    'items' => [
                        ['label' => 'Profil', 'url' => ['/site/profil-guru', 'id' => $user_id]],
                         '<li class="divider"></li>',
                        ['label' => 'Keluar (' . Yii::$app->user->identity->nama_lengkap . ')',
                        'url' => ['/site/logout'],
                        'linkOptions' => ['data-method' => 'post']]
                         // '<li class="dropdown-header">Dropdown Header</li>',
                    ],  
                ];
        }
        // else {
        //     $menuItemsRight[] = '<li>'
        //         . Html::beginForm(['/site/logout'], 'post')
        //         . Html::submitButton(
        //             'Keluar (' . Yii::$app->user->identity->username . ')',
        //             ['class' => 'btn btn-link logout']
        //         )
        //         . Html::endForm()
        //         . '</li>';
        // }
        echo Nav::widget([
            'options' => ['class' => 'navbar-nav navbar-left'],
            'items' => $menuItems,
        ]);

        echo Nav::widget([
            'options' => ['class' => 'navbar-nav navbar-right'],
            'items' => $menuItemsRight,
        ]);

        NavBar::end();
        ?>
    </header>

    <div class="row">
        
        <?php require_once('alert.php'); ?>
        <?= $content ?>
    </div>
</div>
<br>
<footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-md-4 col-sm-4 col-xs-12">
                    <div class="widget clearfix">
                        <div class="widget-title">
                            <img src="images/logos/logo-hosting-light.png" alt="">
                            <small>Toba Marbisuk</small>
                        </div>
                        <p> Toba Marbisuk merupakan sebuah website dengan tujuan untuk memberikan pendidikan terbaik melalui media online.</p>
                        <p> Dengan mengumpulkan materi dan tutorial terbaik dari seluruh guru di Indonesia.</p>
                    </div><!-- end clearfix -->
                </div><!-- end col -->

               <!-- end col -->
                
                <div class="col-md-4 col-sm-3 col-xs-12">
                    <div class="widget clearfix">
                        <div class="widget-title">
                            <h3>Contact Us</h3>
                        </div>

                        <ul class="footer-links">
                            <li>Institut Teknologi Del</li>
                            <li>Jl. Sisingamangaraja, Sitoluama
                                Laguboti, Toba Samosir
                                Sumatera Utara, Indonesia
                            </li>
                            <li>Kode Pos: 22381</li>
                            <li>Telp: +62 632 331234</li>
                        </ul><!-- end links -->
                    </div><!-- end clearfix -->
                </div><!-- end col -->

                <div class="col-md-4 col-sm-2 col-xs-12">
                    <div class="widget clearfix">
                        <div class="widget-title">
                            <h3>Social Media</h3>
                        </div>
                        <ul class="footer-links">
                            <li><a href="http://facebook.com/"><i class="fa fa-facebook"></i> Toba Marbisuk</a></li>
                            <li><a href="http://twitter.com/"><i class="fa fa-twitter"></i> Toba Marbisuk</a></li>
                            <li><a href="https://www.instagram.com/tobamarbisuk01/?hl=id"><i class="fa fa-instagram"></i> tobamarbisuk01</a></li>
                            <li><a href="https://mail.google.com/"><i class="fa fa-google"></i> tobamarbisuk01@gmail.com</a></li>
                            
                        </ul><!-- end links -->
                    </div><!-- end clearfix -->
                </div><!-- end col -->
            </div><!-- end row -->
        </div><!-- end container -->
    </footer><!-- end footer -->
<div class="copyrights">
        <div class="container">
            <div class="footer-distributed">
                <div class="footer-left">                   
                    <p class="footer-company-name">&copy; <?= date('Y') ?> BaseCampGen. All Rights Reserved. </p> 
                </div>

                <div class="footer-right">

                </div>
            </div>
        </div><!-- end container -->
    </div><!-- end copyrights -->

<?php $this->endBody() ?>
    <script src="host/js/all.js"></script>
    <script src="host/js/custom.js"></script>
    <script type="text/javascript" src="plugins/jquery.min.js"></script>
    <script type="text/javascript" src="worthy/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="worthy/plugins/modernizr.js"></script>
    <script type="text/javascript" src="worthy/plugins/isotope/isotope.pkgd.min.js"></script>
    <script type="text/javascript" src="worthy/plugins/jquery.backstretch.min.js"></script>
    <script type="text/javascript" src="worthy/plugins/jquery.appear.js"></script>
    <script type="text/javascript" src="worthy/js/template.js"></script>
    <script type="text/javascript" src="worthy/js/custom.js"></script>
</body>
</html>
<?php $this->endPage() ?>
