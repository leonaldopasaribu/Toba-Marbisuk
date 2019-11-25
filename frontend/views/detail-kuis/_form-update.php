<?php

use yii\helpers\Html;
use yii\bootstrap\ActiveForm;
use dosamigos\ckeditor\CKEditor;

/* @var $this yii\web\View */
/* @var $model frontend\models\DetailKuis */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="detail-kuis-form">
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

    <?=  $form->field($model, 'pertanyaan')->widget(CKEditor::className(), [
        'options' => ['rows' => 6],
        'preset' => 'full'
    ]);?>

    <?= $form->field($model, 'pertanyaan')->textArea(['rows' => 6, 'maxlength' => true, 'class' => 'input200', 'placeholder' => 'Masukkan Isi Pertanyaan']) ?>

    <?= $form->field($model, 'opsi_a')->textInput(['maxlength' => true, 'class' => 'input100', 'placeholder' => 'Masukkan Opsi A']) ?>

    <?= $form->field($model, 'opsi_b')->textInput(['maxlength' => true, 'class' => 'input100', 'placeholder' => 'Masukkan Opsi B']) ?>

    <?= $form->field($model, 'opsi_c')->textInput(['maxlength' => true, 'class' => 'input100', 'placeholder' => 'Masukkan Opsi C']) ?>

    <?= $form->field($model, 'opsi_d')->textInput(['maxlength' => true, 'class' => 'input100', 'placeholder' => 'Masukkan Opsi D']) ?>

    <?= $form->field($model, 'opsi_e')->textInput(['maxlength' => true, 'class' => 'input100', 'placeholder' => 'Masukkan Opsi E']) ?>

    <?= $form->field($model, 'jawaban_benar')->radioList([1 => 'A', 2 => 'B', 3 => 'C', 4 => 'D', 5 => 'E'])->label('Pilih Jawaban Benar'); ?>

    <div class="form-group">
        <div class="col-md-1 col-md-offset-6"></div>
        <?= Html::submitButton($model->isNewRecord ? 'Selanjutnya' : 'Edit', ['class' => $model->isNewRecord ? 'btn btn-info' : 'btn btn-info']) ?>
    </div>

    <?php ActiveForm::end(); ?>
    </div>

</div>
