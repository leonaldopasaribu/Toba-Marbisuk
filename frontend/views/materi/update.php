<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model frontend\models\Materi */

$this->title = 'Update Materi: ' . $model->materi_id;
$this->params['breadcrumbs'][] = ['label' => 'Materis', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->materi_id, 'url' => ['view', 'id' => $model->materi_id]];
$this->params['breadcrumbs'][] = 'Update';
?>
<div class="materi-update">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
