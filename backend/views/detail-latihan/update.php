<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model backend\models\DetailLatihan */

$this->title = 'Update Detail Latihan: ' . $model->latihan_id;
$this->params['breadcrumbs'][] = ['label' => 'Detail Latihans', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->latihan_id, 'url' => ['view', 'id' => $model->latihan_id]];
$this->params['breadcrumbs'][] = 'Update';
?>
<div class="detail-latihan-update">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
