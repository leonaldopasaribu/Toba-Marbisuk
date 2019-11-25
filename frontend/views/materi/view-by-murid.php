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
    <?= DetailView::widget([
        'model' => $model,
        'attributes' => [
            'judul',
            'deskripsi',
            [
                'attribute' => 'file materi',
                'format' => 'raw',
                'value' => function($model){
                    return Html::a('Download Materi', ['materi/download', 'id' => $model->materi_id], ['class' => 'btn btn-succes']);
                }
            ],
        ],
    ]) ?>

</div>
</div>
