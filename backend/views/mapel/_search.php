<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model backend\models\search\MapelSearch */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="mapel-search">

    <?php $form = ActiveForm::begin([
        'action' => ['index'],
        'method' => 'get',
    ]); ?>

    <?= $form->field($model, 'mapel_id') ?>

    <?= $form->field($model, 'user_id') ?>

    <?= $form->field($model, 'nama_mapel') ?>

    <?= $form->field($model, 'deskripsi') ?>

    <div class="form-group">
        <?= Html::submitButton('Search', ['class' => 'btn btn-primary']) ?>
        <?= Html::resetButton('Reset', ['class' => 'btn btn-default']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
