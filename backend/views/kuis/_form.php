<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model backend\models\Kuis */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="kuis-form">

    <?php $form = ActiveForm::begin(); ?>

    <?= $form->field($model, 'kuis_name')->textInput(['maxlength' => true]) ?>

    <?= $form->field($model, 'sandi_kuis')->textInput(['maxlength' => true]) ?>

    <?= $form->field($model, 'waktu_kuis')->textInput() ?>

    <?= $form->field($model, 'deskripsi')->textarea(['rows' => 6]) ?>

    <?= $form->field($model, 'penyelesaian_file')->textInput(['maxlength' => true]) ?>

    <?= $form->field($model, 'penyelesaian_video')->textInput(['maxlength' => true]) ?>

    <?= $form->field($model, 'materi_file')->textInput(['maxlength' => true]) ?>

    <?= $form->field($model, 'materi_video')->textInput(['maxlength' => true]) ?>

    <div class="form-group">
        <?= Html::submitButton($model->isNewRecord ? 'Create' : 'Update', ['class' => $model->isNewRecord ? 'btn btn-success' : 'btn btn-primary']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
