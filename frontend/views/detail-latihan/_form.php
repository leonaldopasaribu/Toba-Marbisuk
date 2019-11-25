<?php

use yii\helpers\Html;
use yii\bootstrap\ActiveForm;

/* @var $this yii\web\View */
/* @var $model frontend\models\DetailLatihan */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="container top">

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

    <?= $form->field($model, 'pertanyaan')->textArea(['rows' => 6, 'maxlength' => true, 'class' => 'input200', 'placeholder' => 'Masukkan Isi Pertanyaan']) ?>

    <?= $form->field($model, 'opsi_a')->textInput(['maxlength' => true, 'class' => 'input100', 'placeholder' => 'Masukkan Opsi A']) ?>

    <?= $form->field($model, 'opsi_b')->textInput(['maxlength' => true, 'class' => 'input100', 'placeholder' => 'Masukkan Opsi B']) ?>

    <?= $form->field($model, 'opsi_c')->textInput(['maxlength' => true, 'class' => 'input100', 'placeholder' => 'Masukkan Opsi C']) ?>

    <?= $form->field($model, 'opsi_d')->textInput(['maxlength' => true, 'class' => 'input100', 'placeholder' => 'Masukkan Opsi D']) ?>

    <?= $form->field($model, 'opsi_e')->textInput(['maxlength' => true, 'class' => 'input100', 'placeholder' => 'Masukkan Opsi E']) ?>

    <div class="form-group">
        <div class="col-md-1 col-md-offset-2">
            <?= Html::submitButton($model->isNewRecord ? 'Tambah Soal Latihan' : 'Edit Soal Latihan', ['class' => $model->isNewRecord ? 'btn btn-success' : 'btn btn-primary']) ?>
        </div>
    </div>

    <?php ActiveForm::end(); ?>

</div>
