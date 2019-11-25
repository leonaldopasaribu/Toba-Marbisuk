<?php

use yii\helpers\Html;
use yii\helpers\Url;
use yii\bootstrap\ActiveForm;
use yii\helpers\ArrayHelper;
use yii\redactor\RedactorModule;


/* @var $this yii\web\View */
/* @var $model frontend\models\Kuis */
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

    <?= $form->field($model, 'kuis_name')->textInput(['maxlength' => true, 'class' => 'input100', 'placeholder' => 'Masukkan Nama Materi']) ?>    

    <?= $form->field($model, 'deskripsi')->widget(\yii\redactor\widgets\Redactor::className(), [
        'clientOptions' => [
            'imageManagerJson' => ['/redactor/upload/image-json'],
            'imageUpload' => ['/redactor/upload/image'],
            'fileUpload' => ['/redactor/upload/file'],
            'lang' => 'id',
            'plugins' => ['clips', 'fontcolor','imagemanager'],
            'placeholder' => 'Masukkan Deskripsi Materi'
        ]
    ])?>

    <?= $form->field($model, 'file')->fileInput(['class' => 'btn btn-info'])->label("File Materi") ?>    

    <?= $form->field($model, 'materi_video')->textInput(['maxlength' => true, 'class' => 'input100', 'placeholder' => 'Masukkan Link Video Materi'])->label("Link Video") ?>       

    <div class="form-group">
        <div class="col-md-1 col-md-offset-2">
            <?= Html::submitButton($model->isNewRecord ? 'Tambah Topik Pelajaran' : 'Edit Topik Pelajaran', ['class' => $model->isNewRecord ? 'btn btn-success' : 'btn btn-success']) ?>
        </div>
    </div>

    <?php ActiveForm::end(); ?>
	</div>

</div>
