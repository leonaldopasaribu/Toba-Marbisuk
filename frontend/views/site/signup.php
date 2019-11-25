<?php

/* @var $this yii\web\View */
/* @var $form yii\bootstrap\ActiveForm */
/* @var $model \frontend\models\SignupForm */

use yii\helpers\Html;
use yii\helpers\Url;
use yii\bootstrap\ActiveForm;
use yii\bootstrap\Button;

$this->title = 'Signup';
$this->params['breadcrumbs'][] = $this->title;
?>
<!-- <div class="site-signup">
    <h1><?= Html::encode($this->title) ?></h1>

    <p>Please fill out the following fields to signup:</p>

    <div class="row">
        <div class="col-lg-5">
            <?php $form = ActiveForm::begin(['id' => 'form-signup']); ?>

                <?= $form->field($model, 'username')->textInput(['autofocus' => true]) ?>

                <?= $form->field($model, 'email') ?>

                <?= $form->field($model, 'password')->passwordInput() ?>

                <div class="form-group">
                    <?= Html::submitButton('Signup', ['class' => 'btn btn-primary', 'name' => 'signup-button']) ?>
                </div>

            <?php ActiveForm::end(); ?>
        </div>
    </div>
</div> -->


<!-- Form Login -->
    <div class="limiter">
        <div class="container-login100">
            <div class="wrap-login100">
                <form class="login100-form validate-form">
                    <span class="login100-form-title">
                        Daftarkan diri Anda sekarang juga
                        <p>sebagai</p>
                        <div class="col-md-6 col-form">
                            <?= Html::a('Siswa', ['/site/signup-student'], ['class'=>'form-teacher-btn']) ?>
                        </div>
                        <div class="col-md-6 col-form">
                            <?= Html::a('Guru', ['/site/signup-teacher'], ['class'=>'form-teacher-btn']) ?>
                        </div>
                    </span>
                    <div class="text-center p-t-12">
                        <?= Html::a('Sudah punya akun? Masuk disini <i class="fa fa-long-arrow-right m-l-5" aria-hidden="true"></i>', ['/site/login'], ['class'=>'txt2']) ?>
                    </div>
                </form>
            </div>
        </div>
    </div>
<!-- End Form -->
 
    <script src="vendor/jquery/jquery-3.2.1.min.js"></script>
    <script src="vendor/bootstrap/js/popper.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.min.js"></script>
    <script src="vendor/select2/select2.min.js"></script>
    <script src="vendor/tilt/tilt.jquery.min.js"></script>
    <script >
        $('.js-tilt').tilt({
            scale: 1.1
        })
    </script>
    <script src="js/main.js"></script>
