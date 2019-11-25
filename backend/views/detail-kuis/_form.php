<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model backend\models\DetailKuis */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="detail-kuis-form">

    <?php $form = ActiveForm::begin(); ?>

    <?= $form->field($model, 'pertanyaan')->textarea(['rows' => 6]) ?>

    <?= $form->field($model, 'jawaban_user')->textInput(['maxlength' => true]) ?>

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
