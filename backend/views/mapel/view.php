<?php

use yii\helpers\Html;
use yii\widgets\DetailView;

/* @var $this yii\web\View */
/* @var $model backend\models\Mapel */

$this->title = $model->mapel_id;
$this->params['breadcrumbs'][] = ['label' => 'Mapels', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="mapel-view">

    <h1><?= Html::encode($this->title) ?></h1>

    <p>
        <?= Html::a('Update', ['update', 'id' => $model->mapel_id], ['class' => 'btn btn-primary']) ?>
        <?= Html::a('Delete', ['delete', 'id' => $model->mapel_id], [
            'class' => 'btn btn-danger',
            'data' => [
                'confirm' => 'Are you sure you want to delete this item?',
                'method' => 'post',
            ],
        ]) ?>
    </p>

    <?= DetailView::widget([
        'model' => $model,
        'attributes' => [
            // 'mapel_id',
            // 'user_id',
            'nama_mapel',
            'deskripsi:ntext',
        ],
    ]) ?>

</div>
