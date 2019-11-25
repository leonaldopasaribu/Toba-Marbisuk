<?php

/* @var $this yii\web\View */
/* @var $form yii\bootstrap\ActiveForm */
/* @var $model \frontend\models\SignupForm */

use yii\helpers\Html;
use yii\bootstrap\ActiveForm;

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
                <?php $form = ActiveForm::begin(['class' => 'login100-form validate-form']); ?>
                    <span class="login100-form-title">
                        Daftar Sebagai Guru 
                        <br><br>
                        <p>Isi data kamu dengan lengkap</p>
                    </span>

                        <?= $form->field($model, 'username')->textInput(['autofocus' => true, 'class' => 'input100']) ?>

                        <?= $form->field($model, 'email')->textInput(['class' => 'input100']) ?>

                        <?= $form->field($model, 'no_hp')->textInput(['class' => 'input100']) ?>

                        <?= $form->field($model, 'password')->passwordInput(['class' => 'input100']) ?>

                        <div class="form-group">
                            <?= Html::submitButton('Daftar', ['class' => 'login100-form-btn', 'name' => 'signup-button']) ?>
                        </div>

                        <div class="text-center p-t-12">
                            <div class="text-center p-t-12">
                            <?= Html::a('Sudah punya akun? Masuk disini <i class="fa fa-long-arrow-right m-l-5" aria-hidden="true"></i>', ['/site/login'], ['class'=>'txt2']) ?>
                        </div>
                        </div>

                    <?php ActiveForm::end(); ?>

                    <!-- <p>Nama Lengkap</p>
                    <div class="wrap-input100 validate-input" data-validate = "Masukkan Nama Pengguna">

                        <input class="input100" type="text" name="text" placeholder="">
                        <span class="focus-input100"></span>
                        <span class="symbol-input100">
                            <i class="fa fa-user" aria-hidden="true"></i>
                        </span>
                    </div>

                    <p>Email</p>
                    <div class="wrap-input100 validate-input" data-validate = "Contoh : siswa@app.com">

                        <input class="input100" type="email" name="text" placeholder="">
                        <span class="focus-input100"></span>
                        <span class="symbol-input100">
                            <i class="fa fa-envelope" aria-hidden="true"></i>
                        </span>
                    </div>

                    <p>Nomor Handphone</p>
                    <div class="wrap-input100 validate-input" data-validate = "Masukkan Nomor Handphone">

                        <input class="input100" type="text" name="text" placeholder="Contoh : 6283456788923">
                        <span class="focus-input100"></span>
                        <span class="symbol-input100">
                            <i class="fa fa-mobile" aria-hidden="true"></i>
                        </span>
                    </div>

                    <p>Kata Sandi</p>
                    <div class="wrap-input100 validate-input" data-validate = "Masukkan Kata Sandi">
                        <input class="input100" type="password" name="pass" placeholder="">
                        <span class="focus-input100"></span>
                        <span class="symbol-input100">
                            <i class="fa fa-lock" aria-hidden="true"></i>
                        </span>
                    </div>
                    
                    <div class="container-login100-form-btn">
                        <button class="login100-form-btn">
                            Masuk
                        </button>
                    </div>

                    <div class="text-center p-t-12">
                        <div class="text-center p-t-12">
                        <?= Html::a('Sudah punya akun? Masuk disini <i class="fa fa-long-arrow-right m-l-5" aria-hidden="true"></i>', ['/site/login'], ['class'=>'txt2']) ?>
                    </div>
                    </div>
                </form> -->
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
