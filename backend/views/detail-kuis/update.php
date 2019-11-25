<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model backend\models\DetailKuis */

$this->title = 'Update Detail Kuis: ' . $model->detail_kuis_id;
$this->params['breadcrumbs'][] = ['label' => 'Detail Kuis', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->detail_kuis_id, 'url' => ['view', 'id' => $model->detail_kuis_id]];
$this->params['breadcrumbs'][] = 'Update';
?>
<div class="detail-kuis-update">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
