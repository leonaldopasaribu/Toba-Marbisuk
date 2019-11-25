<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model frontend\models\search\KomentarSearch */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="komentar-search">

    <?php $form = ActiveForm::begin([
        'action' => ['index'],
        'method' => 'get',
    ]); ?>

    <?= $form->field($model, 'komentar_id') ?>

    <?= $form->field($model, 'kuis_id') ?>

    <?= $form->field($model, 'komentar') ?>

    <?= $form->field($model, 'username') ?>

    <?= $form->field($model, 'gambar') ?>

    <div class="form-group">
        <?= Html::submitButton('Search', ['class' => 'btn btn-primary']) ?>
        <?= Html::resetButton('Reset', ['class' => 'btn btn-default']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
