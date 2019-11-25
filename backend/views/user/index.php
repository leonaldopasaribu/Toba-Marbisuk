<?php

use yii\helpers\Html;
use yii\grid\GridView;

/* @var $this yii\web\View */
/* @var $searchModel backend\models\search\UserSearch */
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
            // 'nama_sekolah',
            'email:email',
            [
                    'attribute' => 'status_aktif',
                    'format' => 'raw',
                    'filter' =>[1 => 'Nonaktifkan', 2 => 'Aktifkan'],
                    'filterInputOptions' => ['class' => 'form-control', 'id' => null, 'prompt' => 'ALL'],
                    'value' => function($model){
                        if ($model->status_aktif == 1) {
                            return Html::a('Nonaktifkan', ['user/disable', 'id' => $model->id], ['class' => 'btn btn-succes']);
                        } else {
                            return Html::a('Aktifkan', ['user/aktif', 'id' => $model->id], ['class' => 'btn btn-succes']);
                        }
                    }
            ],
            // 'status',
            [
                    'attribute' => 'role',
                    'format' => 'raw',
                    'filter' =>[1 => 'Guru', 2 => 'Siswa', 3 => 'Admin'],
                    'filterInputOptions' => ['class' => 'form-control', 'id' => null, 'prompt' => 'ALL'],
                    'value' => function($model){
                        if ($model->role == 1) {
                            return ("Guru");
                        }elseif ($model->role == 2) {
                            return ("Siswa");
                        }elseif($model->role == 3){
                            return ("Admin");
                        }
                    }
            ],
            //'role',
            // 'created_at',
            // 'updated_at',

            ['class' => 'yii\grid\ActionColumn'],
        ],
    ]); ?>
</div>
