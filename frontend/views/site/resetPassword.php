<?php

/* @var $this yii\web\View */
/* @var $form yii\bootstrap\ActiveForm */
/* @var $model \frontend\models\ResetPasswordForm */

use yii\helpers\Html;
use yii\bootstrap\ActiveForm;

$this->title = 'Reset Kata Sandi | Web';
$this->params['breadcrumbs'][] = $this->title;
?>

<div class="site-reset-password">
<!-- Form Login -->
    <div class="limiter">
        <div class="container-login100">
            <div class="wrap-login100">
                <!-- <form class="login100-form validate-form"> -->
                    <span class="login100-form-title">
                        Silahkan masukkan kata sandi Anda yang baru
                    </span>

                    <br><br>

                    <?php $form = ActiveForm::begin(['class' => 'login100-form validate-form', 'id' => 'reset-password-form']); ?>

                        <?= $form->field($model, 'password')->textInput(['autofocus' => true, 'class' => 'input100', 'placeholder' => 'Alamat Email'])->label('Kata Sandi Baru') ?>

                        <div class="form-group">
                            <?= Html::submitButton('Simpan', ['class' => 'login100-form-btn', 'name' => 'login-button']) ?>
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
