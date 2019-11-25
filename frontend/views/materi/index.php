<?php

use yii\helpers\Html;
use yii\grid\GridView;

/* @var $this yii\web\View */
/* @var $searchModel frontend\models\search\MateriSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */


$this->title = 'Materis';
$this->params['breadcrumbs'][] = $this->title;
?>
<br><br><br><br><br>
<div class="materi-index">

    <h1><?= Html::encode($this->title) ?></h1>
    <?php // echo $this->render('_search', ['model' => $searchModel]); ?>

    <p>
        <?= Html::a('Create Materi', ['create'], ['class' => 'btn btn-success']) ?>
    </p>
    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],

            'judul',
            'deskripsi',
            [
                'attribute' => 'file materi',
                'format' => 'raw',
                'value' => function($model){
                    return Html::a('Download Materi', ['materi/download', 'id' => $model->materi_id], ['class' => 'btn btn-succes']);
                }
            ],

            ['class' => 'yii\grid\ActionColumn'],
        ],
    ]); ?>
</div>
