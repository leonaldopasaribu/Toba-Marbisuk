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
          'options' => ['enctype'=>'multipart/form-data'],
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

    <?= $form->field($model, 'penyel')->fileInput(['class' => 'btn btn-info'])->label('File Penyelesaian') ?>

    <div class="form-group">
        <div class="col-md-1 col-md-offset-2">
            <?= Html::submitButton($model->isNewRecord ? 'Tambah' : 'Tambah File', ['class' => $model->isNewRecord ? 'btn btn-success' : 'btn btn-primary']) ?>
        </div>
    </div>

    <?php ActiveForm::end(); ?>

</div>
