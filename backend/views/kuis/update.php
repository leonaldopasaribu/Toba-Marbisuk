<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model backend\models\Kuis */

$this->title = 'Update Kuis: ' . $model->kuis_id;
$this->params['breadcrumbs'][] = ['label' => 'Kuis', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->kuis_id, 'url' => ['view', 'id' => $model->kuis_id]];
$this->params['breadcrumbs'][] = 'Update';
?>
<div class="kuis-update">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
