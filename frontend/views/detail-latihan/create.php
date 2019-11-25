<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model frontend\models\DetailLatihan */

$this->title = 'Tambah Soal Latihan';
$this->params['breadcrumbs'][] = ['label' => 'Detail Latihans', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="all-title-box">
	<div class="container text-center">
		<h1><?= Html::encode($this->title) ?><span class="m_1"></span></h1>
	</div>
</div>
<div class="container-login100">
	<div class="wrap-bg200">

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
