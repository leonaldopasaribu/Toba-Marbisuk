<?php

use yii\helpers\Html;
use yii\grid\GridView;

/* @var $this yii\web\View */
/* @var $searchModel frontend\models\search\KomentarSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Komentars';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="komentar-index">

    <h1><?= Html::encode($this->title) ?></h1>
    <?php // echo $this->render('_search', ['model' => $searchModel]); ?>

    <p>
        <?= Html::a('Create Komentar', ['create'], ['class' => 'btn btn-success']) ?>
    </p>
    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],

            'komentar_id',
            'kuis_id',
            'komentar',
            'username',
            'gambar',

            ['class' => 'yii\grid\ActionColumn'],
        ],
    ]); ?>
</div>
