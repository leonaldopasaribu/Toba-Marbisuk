<?php

use yii\helpers\Html;
use yii\helpers\Url;
use yii\bootstrap\ActiveForm;
use yii\helpers\ArrayHelper;

/* @var $this yii\web\View */
/* @var $model frontend\models\Kuis */
/* @var $form yii\widgets\ActiveForm */
$this->title = 'Cari Kuis | Web';

?>
<div class="all-title-box">
  <div class="container text-center">
    <h1>CARI KUIS<span class="m_1">Temukan Kuis Favorit Kamu</span></h1>
  </div>
</div>

<div class="container">
<br><br><br>
    <?php
       $form = ActiveForm::begin([
          'layout' => 'horizontal',
          'action' => ['detail-kuis/latihan-teacher'],
          'method' => 'get',
          'fieldConfig' => [
              'template' => "{label}\n{beginWrapper}\n{input}\n{error}\n{endWrapper}\n{hint}",
              'horizontalCssClasses' => [
                 'label' => 'col-sm-3',
                 'wrapper' => 'col-sm-7',
                 'error' => '',
                 'hint' => '',
              ],
           ],
       ])
    ?>

    <h2 class="text-center">Latih kemampuan akademik kamu dengan menjawab kumpulan soal</h2>

    <br>

    <?= $form->field($model, 'kuis_id')->textInput(['required' => true])->dropdownlist(ArrayHelper::map($models, 'mapel_id', 'nama_mapel'),  ['prompt'=>'Pilih Mata Pelajaran','onchange' => '$.get( "'.Url::toRoute('get-kuis').'", { id: $(this).val() }).done(function(data){ $( "#'.Html::getInputId($model, 'kuis_name').'" ).html(data);  });',                
    ])->label('Mata Pelajaran')?>

    <?= $form->field($model, 'kuis_name',['horizontalCssClasses' => ['wrapper' => 'col-sm-7']])
        ->dropDownList([], ['prompt'=>'Pilih Topik Kuis'])->label('Nama Kuis')
    ?>

    <div class="form-group">
        <div class="col-md-1 col-md-offset-4"></div>
            <?= Html::submitButton('Cari <i class="fa fa-search"></i>', ['class' => 'btn btn-info']) ?>
            <?= Html::resetButton('Ulang <i class="fa fa-refresh"></i>', ['class' => 'btn btn-success']) ?>
    </div>

    <?php ActiveForm::end(); ?>
</div>
