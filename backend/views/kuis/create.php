<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model backend\models\Kuis */

$this->title = 'Create Kuis';
$this->params['breadcrumbs'][] = ['label' => 'Kuis', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="kuis-create">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
