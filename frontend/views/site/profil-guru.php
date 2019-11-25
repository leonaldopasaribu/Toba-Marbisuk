<?php

/* @var $this yii\web\View */
/* @var $form yii\bootstrap\ActiveForm */
/* @var $model \common\models\LoginForm */

use yii\helpers\Html;
use yii\bootstrap\ActiveForm;

$this->title = 'Profil | Web';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="site-profil top">
        <div class="container emp-profile">
                <div class="row">
                    <div class="col-md-4 ">
                        <h2><?php echo $user->nama_lengkap ?> </h2>
                        <div class="profile-img">
                            <?php $form = ActiveForm::begin(['class' => 'login100-form validate-form', 'options' => ['enctype'=>'multipart/form-data']]); ?>
                            <img src=<?php echo $user->file_foto; ?> alt=""/>
                            <!-- <div class="file btn btn-lg btn-primary">
                                Unggah Foto
                                <input type="file_foto" name="file"/>
                            </div> -->
                        </div>
                    </div>
                    <div class="col-md-8">
                        <h2>Lengkapi Profil Anda</h2>
                        <p>Informasi ini akan digunakan untuk keperluan akses ke fitur Web. Silahkan isi data Anda dengan benar dan lengkap</p>
                        <div class="tab-content profile-tab" id="myTabContent">
                            <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                                <?= $form->field($model, 'file')->fileInput(['class' => 'btn-info'])->label('Foto Profil'); ?>

                                <?= $form->field($model, 'nama_lengkap')->textInput(['autofocus' => true, 'class' => 'input100', 'placeholder' => 'Masukkan Nama Lengkap Anda']) ?>

                                <?= $form->field($model, 'email')->textInput(['autofocus' => true, 'class' => 'input100', 'placeholder' => 'Masukkan Email Anda']) ?>

                                <?= $form->field($model, 'no_hp')->textInput(['autofocus' => true, 'class' => 'input100', 'placeholder' => 'Masukkan Nomor Handphone Anda']) ?>

                                <?= $form->field($model, 'nama_sekolah')->textInput(['autofocus' => true, 'class' => 'input100', 'placeholder' => 'Masukkan Nama Sekolah Anda']) ?>

                                <?= $form->field($model, 'bidang')->textInput(['autofocus' => true, 'class' => 'input100', 'placeholder' => 'Masukkan Bidang Mata Pelajaran Anda']) ?>

                                <div class="form-group">
                                    <?= Html::submitButton('Simpan Perubahan', ['class' => 'profil100-form-btn', 'name' => 'login-button']) ?>
                                </div>

                            <?php ActiveForm::end(); ?>
                            </div>
                        </div>
                    </div>
                </div>         
        </div>
</div>