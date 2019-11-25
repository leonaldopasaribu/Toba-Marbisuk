<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model backend\models\DetailLatihan */

$this->title = 'Create Detail Latihan';
$this->params['breadcrumbs'][] = ['label' => 'Detail Latihans', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="detail-latihan-create">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
