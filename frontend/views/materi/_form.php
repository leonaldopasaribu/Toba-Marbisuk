<?php

use yii\helpers\Html;
use yii\bootstrap\ActiveForm;

/* @var $this yii\web\View */
/* @var $model frontend\models\Materi */
/* @var $form yii\widgets\ActiveForm */
?>
<div class="materi-form">
	<div class="container">
	    <?php
	       $form = ActiveForm::begin([
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
	    <?= $form->field($model, 'judul')->textInput(['maxlength' => true]) ?>

	    <?= $form->field($model, 'deskripsi')->textarea(['maxlength' => true]) ?>

	    <?= $form->field($model, 'file')->fileInput() ?>

	    <div class="form-group">
	    	<div class="col-md-1 col-md-offset-2">
	        	<?= Html::submitButton($model->isNewRecord ? '<i class="fa fa-plus"></i> Tambah' : '<i class="fa fa-pencil"></i> Edit', ['class' => $model->isNewRecord ? 'btn btn-success' : 'btn btn-primary']) ?>
	    	</div>
	    </div>

	    <?php ActiveForm::end(); ?>

	</div>
</div>
