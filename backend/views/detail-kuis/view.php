<?php

use yii\helpers\Html;
use yii\widgets\DetailView;

/* @var $this yii\web\View */
/* @var $model backend\models\DetailKuis */

$this->title = $model->detail_kuis_id;
$this->params['breadcrumbs'][] = ['label' => 'Detail Kuis', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="detail-kuis-view">

    <h1><?= Html::encode($this->title) ?></h1>

    <p>
        <?= Html::a('Update', ['update', 'id' => $model->detail_kuis_id], ['class' => 'btn btn-primary']) ?>
        <?= Html::a('Delete', ['delete', 'id' => $model->detail_kuis_id], [
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
            // 'detail_kuis_id',
            'kuis.kuis_name',
            'status',
            'pertanyaan:ntext',
            'jawaban_user',
            'jawaban_benar',
            'opsi_a',
            'opsi_b',
            'opsi_c',
            'opsi_d',
            'opsi_e',
            // 'created_at',
            // 'updated_at',
        ],
    ]) ?>

</div>
