<?php

use yii\helpers\Html;
use yii\widgets\DetailView;
?>
<br><br><br><br>    
<?php
$this->title = $model->judul;
$this->params['breadcrumbs'][] = ['label' => 'Materis', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="container">
<div class="materi-view">

    <h1><?= Html::encode($this->title) ?></h1>
<!-- 
    <p>
        <?= Html::a('Update', ['update', 'id' => $model->materi_id], ['class' => 'btn btn-primary']) ?>
        <?= Html::a('Delete', ['delete', 'id' => $model->materi_id], [
            'class' => 'btn btn-danger',
            'data' => [
                'confirm' => 'Are you sure you want to delete this item?',
                'method' => 'post',
            ],
        ]) ?>
    </p> -->

    <?= DetailView::widget([
        'model' => $model,
        'attributes' => [
            'judul',
            'deskripsi',
            [
                'attribute' => 'file materi',
                'format' => 'raw',
                'value' => function($model){
                    return Html::a('Download Materi', ['kuis/download-kuis', 'id' => $model->materi_id], ['class' => 'btn btn-succes']);
                }
            ],
        ],
    ]) ?>

</div>
</div>
