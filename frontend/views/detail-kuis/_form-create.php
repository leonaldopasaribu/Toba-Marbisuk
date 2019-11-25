<?php

use yii\helpers\Html;
use yii\bootstrap\ActiveForm;
use dosamigos\ckeditor\CKEditor;
use yii\redactor\RedactorModule;

/* @var $this yii\web\View */
/* @var $model frontend\models\DetailKuis */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="kuis-form">
  <br>
  <div class = "container">

    <?php
       $form = ActiveForm::begin([
          'layout' => 'horizontal',
          'fieldConfig' => [
              'template' => "{label}\n{beginWrapper}\n{input}\n{error}\n{endWrapper}\n{hint}",
              'horizontalCssClasses' => [
                 'label' => 'col-sm-2',
                 'wrapper' => 'col-sm-8',
                 'error' => '',
                 'hint' => '',
              ],
           ],
       ])
    ?>   

    <?= $form->field($model, 'pertanyaan')->widget(\yii\redactor\widgets\Redactor::className(), [
        'clientOptions' => [
            'imageManagerJson' => ['/redactor/upload/image-json'],
            'imageUpload' => ['/redactor/upload/image'],
            'fileUpload' => ['/redactor/upload/file'],
            'lang' => 'id',
            'plugins' => ['clips', 'fontcolor','imagemanager'],
            'placeholder' => 'Masukkan Deskripsi Materi'
        ]
    ])?>
    <?= $form->field($model, 'opsi_a')->textInput(['maxlength' => true, 'class' => 'input100', 'placeholder' => 'Masukkan Opsi A']) ?>

    <?= $form->field($model, 'opsi_b')->textInput(['maxlength' => true, 'class' => 'input100', 'placeholder' => 'Masukkan Opsi B']) ?>

    <?= $form->field($model, 'opsi_c')->textInput(['maxlength' => true, 'class' => 'input100', 'placeholder' => 'Masukkan Opsi C']) ?>

    <?= $form->field($model, 'opsi_d')->textInput(['maxlength' => true, 'class' => 'input100', 'placeholder' => 'Masukkan Opsi D']) ?>

    <?= $form->field($model, 'opsi_e')->textInput(['maxlength' => true, 'class' => 'input100', 'placeholder' => 'Masukkan Opsi E']) ?>

    <?= $form->field($model, 'jawaban_benar')->radioList([1 => 'A', 2 => 'B', 3 => 'C', 4 => 'D', 5 => 'E'])->label('Pilih Jawaban Benar'); ?>

    <div class="form-group">
        <div class="col-md-1 col-md-offset-6"></div>
        <?= Html::submitButton($model->isNewRecord ? 'Selanjutnya' : 'Edit', ['class' => $model->isNewRecord ? 'btn btn-info' : 'btn btn-info']) ?>
        <?= Html::a('Selesai', ['soal-teacher', 'id' => $kuis->kuis_id], ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>
    </div>
</div>
