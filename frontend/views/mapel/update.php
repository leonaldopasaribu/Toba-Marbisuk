<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model frontend\models\Mapel */

$this->title = 'Update Mapel: ' . $model->mapel_id;
$this->params['breadcrumbs'][] = ['label' => 'Mapels', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->mapel_id, 'url' => ['view', 'id' => $model->mapel_id]];
$this->params['breadcrumbs'][] = 'Update';
?>
<div class="mapel-update">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
