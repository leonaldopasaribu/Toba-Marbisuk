<?php

/* @var $this yii\web\View */
/* @var $form yii\bootstrap\ActiveForm */
/* @var $model \common\models\LoginForm */

use yii\helpers\Html;
use yii\bootstrap\ActiveForm;

$this->title = 'Login';
$this->params['breadcrumbs'][] = $this->title;
?>
<!-- <div class="site-login">
    <h1><?= Html::encode($this->title) ?></h1>  

    <p>Please fill out the following fields to login:</p>

    <div class="row">
        <div class="col-lg-5">
            <?php $form = ActiveForm::begin(['id' => 'login-form']); ?>

                <?= $form->field($model, 'username')->textInput(['autofocus' => true]) ?>

                <?= $form->field($model, 'password')->passwordInput() ?>

                <?= $form->field($model, 'rememberMe')->checkbox() ?>

                <div style="color:#999;margin:1em 0">
                    If you forgot your password you can <?= Html::a('reset it', ['site/request-password-reset']) ?>.
                </div>

                <div class="form-group">
                    <?= Html::submitButton('Login', ['class' => 'btn btn-primary', 'name' => 'login-button']) ?>
                </div>

            <?php ActiveForm::end(); ?>
        </div>
    </div>
</div>
 -->

<!-- Form Login -->
    <div class="limiter">
        <div class="container-login100">
            <div class="wrap-login100">
                    <span class="login100-form-title">
                        Silahkan Masuk 
                        <p>sebagai</p>
                        <div class="col-md-6 col-form">
                            <?= Html::a('Siswa', ['/site/login'], ['class'=>'form-student-btn-off']) ?>
                        </div>
                        <div class="col-md-6 col-form">
                            <?= Html::a('Guru', ['/site/login-teacher'], ['class'=>'form-teacher-btn-on']) ?>
                        </div>
                    </span>

                    <br><br>
                    <?php $form = ActiveForm::begin(['class' => 'login100-form validate-form']); ?>

                        <?= $form->field($model, 'username')->textInput(['autofocus' => true, 'class' => 'input100']) ?>

                        <?= $form->field($model, 'password')->passwordInput(['class' => 'input100']) ?>

                        <?= $form->field($model, 'rememberMe')->checkbox() ?>

                        <div class="form-group">
                            <?= Html::submitButton('Masuk', ['class' => 'login100-form-btn', 'name' => 'login-button']) ?>
                        </div>

                        <div class="text-center p-t-12">
                            <span class="txt1">
                                Lupa
                            </span>
                            <?= Html::a('Nama Pengguna / Kata Sandi?', ['/site/request-password-reset'], ['class'=>'txt2']) ?>
                        </div>

                        <div class="text-center p-t-30">
                            <a class="txt2" href="index.php?r=site%2Fsignup">
                                Daftarkan diri Anda sekarang juga
                                <i class="fa fa-long-arrow-right m-l-5" aria-hidden="true"></i>
                            </a>
                        </div>

                    <?php ActiveForm::end(); ?>
            </div>
        </div>
    </div>
<!-- End Form -->
<script >
    $('.js-tilt').tilt({
        scale: 1.1
    })
</script>

