<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model frontend\models\Mapel */

$this->title = 'Tambah Mata Pelajaran';
$this->params['breadcrumbs'][] = ['label' => 'Mapels', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="all-title-box">
	<div class="container text-center">
		<h1><?= Html::encode($this->title) ?><span class="m_1"></span></h1>
	</div>
</div>
<div class="container">
	<br>
    <!-- <h2><?= Html::encode($this->title) ?></h2> -->

    <?= $this->render('_form', [
        'model' => $model,
    ]) ?>

</div>
