<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;
use yii\helpers\ArrayHelper;
use backend\models\User;

/* @var $this yii\web\View */
/* @var $model backend\models\User */
/* @var $form yii\widgets\ActiveForm */
?>

<div class="user-form">

    <?php $form = ActiveForm::begin(); ?>

     <?= $form->field($model, 'username')->textInput(['autofocus' => true, 'class' => 'input100']) ?>


    <?= $form->field($model, 'password')->textInput(['class' => 'input100']) ?>

    <?= $form->field($model, 'email')->textInput(['class' => 'input100']) ?>
    <?= $form->field($model, 'role')->dropDownList(['1' => 'Guru', '2' => 'Siswa',  '3' => 'Admin'],['prompt'=>'Pilih Role User']) ?>

    <div class="form-group">
        
         <?= Html::submitButton($model->isNewRecord ? 'Create' : 'Update', ['class' => $model->isNewRecord ? 'btn btn-success' : 'btn btn-primary']) ?>
    </div>

    <?php ActiveForm::end(); ?>

</div>
