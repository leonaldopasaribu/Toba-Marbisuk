<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model frontend\models\DetailLatihan */

$this->title = 'Update Detail Latihan: ' . $model->latihan_id;
$this->params['breadcrumbs'][] = ['label' => 'Detail Latihans', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->latihan_id, 'url' => ['view', 'id' => $model->latihan_id]];
$this->params['breadcrumbs'][] = 'Update';
?>
<div class="container-login100">
	<div class="wrap-bg200">

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>
	
	</div>
</div>
