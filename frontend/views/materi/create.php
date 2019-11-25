<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model frontend\models\Materi */

$this->title = 'Tambah Materi Pelajaran';
$this->params['breadcrumbs'][] = ['label' => 'Materis', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="container top">

    <h2><?= Html::encode($this->title) ?></h2>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
