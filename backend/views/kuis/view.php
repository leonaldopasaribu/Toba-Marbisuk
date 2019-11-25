<?php

use yii\helpers\Html;
use yii\widgets\DetailView;

/* @var $this yii\web\View */
/* @var $model backend\models\Kuis */

$this->title = $model->kuis_id;
$this->params['breadcrumbs'][] = ['label' => 'Kuis', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="kuis-view">

    <h1><?= Html::encode($this->title) ?></h1>

    <p>
        <?= Html::a('Update', ['update', 'id' => $model->kuis_id], ['class' => 'btn btn-primary']) ?>
        <?= Html::a('Delete', ['delete', 'id' => $model->kuis_id], [
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
            // 'kuis_id',
            // 'mapel_id',
            // 'user_id',
            'kuis_name',
            // 'status',
            'sandi_kuis',
            'waktu_kuis',
            // 'score',
            'deskripsi:ntext',
            'penyelesaian_file',
            'penyelesaian_video',
            'materi_file',
            'materi_video',
            // 'created_at',
            // 'created_by',
            // 'updated_at',
            // 'updated_by',
        ],
    ]) ?>

</div>
