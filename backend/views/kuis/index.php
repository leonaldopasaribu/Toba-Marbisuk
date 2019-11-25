<?php

use yii\helpers\Html;
use yii\grid\GridView;

/* @var $this yii\web\View */
/* @var $searchModel backend\models\search\KuisSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Materi';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="kuis-index">

    <h1><?= Html::encode($this->title) ?></h1>
    <?php // echo $this->render('_search', ['model' => $searchModel]); ?>

   <!--  <p>
        <?= Html::a('Create Kuis', ['create'], ['class' => 'btn btn-success']) ?>
    </p> -->
    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],

            // 'kuis_id',
            // 'mapel_id',
            // 'user_id',
            'kuis_name',
             // 'status',
            // 'sandi_kuis',
            // 'waktu_kuis',
            // 'score',
            // 'deskripsi:ntext',
            // 'penyelesaian_file',
            // 'penyelesaian_video',
            'materi_file',
            'materi_video',
            // 'created_at',
            // 'created_by',
            // 'updated_at',
            // 'updated_by',

            ['class' => 'yii\grid\ActionColumn'],
        ],
    ]); ?>
</div>
