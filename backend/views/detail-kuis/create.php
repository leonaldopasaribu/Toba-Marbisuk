<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model backend\models\DetailKuis */

$this->title = 'Create Detail Kuis';
$this->params['breadcrumbs'][] = ['label' => 'Detail Kuis', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="detail-kuis-create">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
