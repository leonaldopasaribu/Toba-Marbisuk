<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model frontend\models\Komentar */
/* @var $form yii\widgets\ActiveForm */
?>
<br><br><br><br>
<div class="">
	<div class="komentar-form">

	    <?php $form = ActiveForm::begin(); ?>    

	    <?= $form->field($models, 'komentar')->textArea(['type' => 'textarea','rows'=> 3, 'maxlength' => true, 'placeholder' => 'Tulis Komentar Anda. . .']) ?>

	    <div class="form-group">
	        <?= Html::submitButton('Kirim',['download-teacher', 'id' => $models->kuis_id, 'class' => 'btn btn-primary']) ?>
	    </div>

	    <?php ActiveForm::end(); ?>

	</div>
</div>
