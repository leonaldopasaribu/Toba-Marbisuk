<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model backend\models\search\KuisSearch */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="kuis-search">

    <?php $form = ActiveForm::begin([
        'action' => ['index'],
        'method' => 'get',
    ]); ?>

    <?= $form->field($model, 'kuis_id') ?>

    <?= $form->field($model, 'mapel_id') ?>

    <?= $form->field($model, 'user_id') ?>

    <?= $form->field($model, 'kuis_name') ?>

    <?= $form->field($model, 'status') ?>

    <?php // echo $form->field($model, 'sandi_kuis') ?>

    <?php // echo $form->field($model, 'waktu_kuis') ?>

    <?php // echo $form->field($model, 'score') ?>

    <?php // echo $form->field($model, 'deskripsi') ?>

    <?php // echo $form->field($model, 'penyelesaian_file') ?>

    <?php // echo $form->field($model, 'penyelesaian_video') ?>

    <?php // echo $form->field($model, 'materi_file') ?>

    <?php // echo $form->field($model, 'materi_video') ?>

    <?php // echo $form->field($model, 'created_at') ?>

    <?php // echo $form->field($model, 'created_by') ?>

    <?php // echo $form->field($model, 'updated_at') ?>

    <?php // echo $form->field($model, 'updated_by') ?>

    <div class="form-group">
        <?= Html::submitButton('Search', ['class' => 'btn btn-primary']) ?>
        <?= Html::resetButton('Reset', ['class' => 'btn btn-default']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
