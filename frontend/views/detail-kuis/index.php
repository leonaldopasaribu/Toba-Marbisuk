<?php

use yii\helpers\Html;
use yii\grid\GridView;

/* @var $this yii\web\View */
/* @var $searchModel frontend\models\search\DetailKuisSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Detail Kuis';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="detail-kuis-index">

    <h1><?= Html::encode($this->title) ?></h1>
    <?php // echo $this->render('_search', ['model' => $searchModel]); ?>

    <p>
        <?= Html::a('Create Detail Kuis', ['create'], ['class' => 'btn btn-success']) ?>
    </p>
    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],

            'detail_kuis_id',
            'kuis_id',
            'no_soal',
            'pertanyaan',
            'jawaban_benar',
            // 'opsi_a',
            // 'opsi_b',
            // 'opsi_c',
            // 'opsi_d',
            // 'opsi_e',
            // 'penyelesaian_file',
            // 'penyelesaian_video',
            // 'created_at',
            // 'updated_at',

            ['class' => 'yii\grid\ActionColumn'],
        ],
    ]); ?>
</div>
