<?php

use yii\helpers\Html;


/* @var $this yii\web\View */
/* @var $model frontend\models\DetailKuis */

$this->title = 'Tambah Soal Kuis';
$this->params['breadcrumbs'][] = ['label' => 'Detail Kuis', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="all-title-box">
	<div class="container text-center">
		<h1><?= Html::encode($this->title) ?><span class="m_1"></span></h1>
	</div>
</div>
<div class="container topik">

    <?= $this->render('_form-create', [
        'model' => $model,
        'kuis' => $kuis,
    ]) ?>

</div>
