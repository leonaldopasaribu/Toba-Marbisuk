<?php

use yii\helpers\Html;

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
	<div class="wrap-bg200">

    <?= $this->render('_form-unggah', [
        'model' => $model,
    ]) ?>
	</div>
</div>
