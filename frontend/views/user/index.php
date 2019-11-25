<?php

use yii\helpers\Html;
use yii\grid\GridView;

/* @var $this yii\web\View */
/* @var $searchModel frontend\models\search\UserSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Users';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="user-index">

    <h1><?= Html::encode($this->title) ?></h1>
    <?php // echo $this->render('_search', ['model' => $searchModel]); ?>

    <p>
        <?= Html::a('Create User', ['create'], ['class' => 'btn btn-success']) ?>
    </p>
    <?= GridView::widget([
        'dataProvider' => $dataProvider,
        'filterModel' => $searchModel,
        'columns' => [
            ['class' => 'yii\grid\SerialColumn'],

            // 'id',
            'username',
            // 'auth_key',
            // 'password_hash',
            // 'password_reset_token',
            // 'nama_lengkap',
            // 'file_foto',
            'nama_sekolah',
            [
                    'attribute' => 'file materi',
                    'format' => 'raw',
                    'value' => function($model){
                        if ($model->status_aktif == 1) {
                            return Html::a('Disable', ['user/disable', 'id' => $model->id], ['class' => 'btn btn-succes']);
                        } else {
                            return Html::a('No Aktif', ['user/aktif', 'id' => $model->id], ['class' => 'btn btn-succes']);
                        }
                    }
                ],
            // 'email:email',
            // 'status_aktif',
            // 'status',
            // 'role',
            // 'no_hp',
            // 'created_at',
            // 'updated_at',

            ['class' => 'yii\grid\ActionColumn'],
        ],
    ]); ?>
</div>
