<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model backend\models\DetailLatihan */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="detail-latihan-form">

    <?php $form = ActiveForm::begin(); ?>

    <?= $form->field($model, 'kuis_id')->textInput() ?>

    <?= $form->field($model, 'pertanyaan')->textInput(['maxlength' => true]) ?>

    <?= $form->field($model, 'jawaban_benar')->textInput(['maxlength' => true]) ?>

    <?= $form->field($model, 'opsi_a')->textInput(['maxlength' => true]) ?>

    <?= $form->field($model, 'opsi_b')->textInput(['maxlength' => true]) ?>

    <?= $form->field($model, 'opsi_c')->textInput(['maxlength' => true]) ?>

    <?= $form->field($model, 'opsi_d')->textInput(['maxlength' => true]) ?>

    <?= $form->field($model, 'opsi_e')->textInput(['maxlength' => true]) ?>


    <div class="form-group">
        <?= Html::submitButton($model->isNewRecord ? 'Create' : 'Update', ['class' => $model->isNewRecord ? 'btn btn-success' : 'btn btn-primary']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
