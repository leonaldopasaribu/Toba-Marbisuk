<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model frontend\models\Komentar */

$this->title = 'Update Komentar: ' . $model->komentar_id;
$this->params['breadcrumbs'][] = ['label' => 'Komentars', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->komentar_id, 'url' => ['view', 'id' => $model->komentar_id]];
$this->params['breadcrumbs'][] = 'Update';
?>
<div class="komentar-update">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
