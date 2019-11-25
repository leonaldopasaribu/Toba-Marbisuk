<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model backend\models\search\DetailLatihanSearch */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="detail-latihan-search">

    <?php $form = ActiveForm::begin([
        'action' => ['index'],
        'method' => 'get',
    ]); ?>

    <?= $form->field($model, 'latihan_id') ?>

    <?= $form->field($model, 'kuis_id') ?>

    <?= $form->field($model, 'pertanyaan') ?>

    <?= $form->field($model, 'jawaban_benar') ?>

    <?= $form->field($model, 'opsi_a') ?>

    <?php // echo $form->field($model, 'opsi_b') ?>

    <?php // echo $form->field($model, 'opsi_c') ?>

    <?php // echo $form->field($model, 'opsi_d') ?>

    <?php // echo $form->field($model, 'opsi_e') ?>

    <?php // echo $form->field($model, 'file_penyelesaian') ?>

    <?php // echo $form->field($model, 'created_at') ?>

    <?php // echo $form->field($model, 'updated_at') ?>

    <div class="form-group">
        <?= Html::submitButton('Search', ['class' => 'btn btn-primary']) ?>
        <?= Html::resetButton('Reset', ['class' => 'btn btn-default']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
