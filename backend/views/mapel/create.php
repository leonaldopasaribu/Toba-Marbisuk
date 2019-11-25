<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model backend\models\Mapel */

$this->title = 'Create Mapel';
$this->params['breadcrumbs'][] = ['label' => 'Mapels', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="mapel-create">

    <h1><?= Html::encode($this->title) ?></h1>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
