<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model frontend\models\DetailLatihan */

$this->title = 'Update Detail Latihan: ' . $model->kuis_id;
$this->params['breadcrumbs'][] = ['label' => 'Detail Latihans', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->kuis_id, 'url' => ['view', 'id' => $model->kuis_id]];
$this->params['breadcrumbs'][] = 'Update';
?>
<div class="container-login100">
	<div class="wrap-bg200">

    <?= $this->render('_form-video', [
        'model' => $model,
    ]) ?>
	</div>
</div>
