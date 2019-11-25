<?php

use yii\helpers\Html;
use yii\bootstrap\ActiveForm;

/* @var $this yii\web\View */
/* @var $model frontend\models\DetailLatihan */

$this->title = 'Tambah File Penyelesaian';
$this->params['breadcrumbs'][] = ['label' => 'Detail Latihans', 'url' => ['index']];
$this->params['breadcrumbs'][] = 'Update';
?>
<div class="all-title-box">
	<div class="container text-center">
		<h1><?= Html::encode($this->title) ?><span class="m_1"></span></h1>
	</div>
</div>
<div class="container-login100">
	<div class="wrap-bg200" style="margin-top: -60%; margin-bottom: -40%;">

	<div class="container top">
    <?php
	       $form = ActiveForm::begin([
	       		'action' => ['kuis/update-penyel', 'id'=>$model->kuis_id],
	       		'method' => 'post',
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


	    <?= $form->field($model, 'penyel')->fileInput(['class' => 'btn btn-info'])->label('File Penyelesaian') ?>


	    <div class="form-group">
	        <div class="col-md-1 col-md-offset-2">
	            <?= Html::submitButton('Simpan', ['class' => 'btn btn-primary']) ?>
	        </div>
	    </div>

	    <?php ActiveForm::end(); ?>
	</div>
	</div>
</div>
