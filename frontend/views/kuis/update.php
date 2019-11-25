<?php

use yii\helpers\Html;

/* @var $this yii\web\View */
/* @var $model frontend\models\Kuis */

$this->title = 'Edit Materi';
$this->params['breadcrumbs'][] = ['label' => 'Kuis', 'url' => ['index']];
$this->params['breadcrumbs'][] = ['label' => $model->kuis_id, 'url' => ['view', 'id' => $model->kuis_id]];
$this->params['breadcrumbs'][] = 'Update';
?>
<div class="all-title-box">
	<div class="container text-center">
		<h1><?= Html::encode($this->title) ?><span class="m_1"></span></h1>
	</div>
</div>
<div class="container">
	<br>

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
