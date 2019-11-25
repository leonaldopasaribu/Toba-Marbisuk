<?php

use yii\helpers\Html;
use yii\widgets\DetailView;

/* @var $this yii\web\View */
/* @var $model frontend\models\Kuis */

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
            'kuis_id',
            'user_id',
            'kuis_name',
            'created_at',
            'updated_at',
        ],
    ]) ?>

</div>
