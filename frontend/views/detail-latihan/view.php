<?php

use yii\helpers\Html;
use yii\widgets\DetailView;

/* @var $this yii\web\View */
/* @var $model frontend\models\DetailLatihan */

$this->title = $model->latihan_id;
$this->params['breadcrumbs'][] = ['label' => 'Detail Latihans', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="detail-latihan-view">

    <h1><?= Html::encode($this->title) ?></h1>

    <p>
        <?= Html::a('Update', ['update', 'id' => $model->latihan_id], ['class' => 'btn btn-primary']) ?>
        <?= Html::a('Delete', ['delete', 'id' => $model->latihan_id], [
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
            'latihan_id',
            'kuis_id',
            'pertanyaan',
            'jawaban_benar',
            'opsi_a',
            'opsi_b',
            'opsi_c',
            'opsi_d',
            'opsi_e',
            'file_penyelesaian',
            'created_at',
            'updated_at',
        ],
    ]) ?>

</div>
