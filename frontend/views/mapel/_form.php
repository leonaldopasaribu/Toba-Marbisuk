<?php

use yii\helpers\Html;
use yii\bootstrap\ActiveForm;
use kartik\widgets\DateTimePicker;  
use yii\redactor\RedactorModule;
use kartik\alert\Alert;

/* @var $this yii\web\View */
/* @var $model frontend\models\Mapel */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="mapel-form">
	<div class="container">

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

    <?= $form->field($model, 'nama_mapel')->textInput(['maxlength' => true, 'placeholder' => 'Masukkan Nama Mata Pelajaran']) ?>

    <?= $form->field($model, 'deskripsi')->widget(\yii\redactor\widgets\Redactor::className(), [
        'clientOptions' => [
            'imageManagerJson' => ['/redactor/upload/image-json'],
            'imageUpload' => ['/redactor/upload/image'],
            'fileUpload' => ['/redactor/upload/file'],
            'lang' => 'zh_cn',
            'plugins' => ['clips', 'fontcolor','imagemanager'],
            'placeholder' => 'Masukkan Deskripsi Mata Pelajaran'
        ]
    ])?>
    
    <div class="form-group">
        <div class="col-md-1 col-md-offset-2">
            <?= Html::submitButton($model->isNewRecord ? 'Tambah Mata Pelajaran' : 'Edit', ['class' => $model->isNewRecord ? 'btn btn-success' : 'btn btn-primary']) ?>
        </div>
    </div>

    <?php ActiveForm::end(); ?>
	</div>
</div>
