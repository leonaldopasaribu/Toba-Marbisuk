<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;
use yii\grid\GridView;

/* @var $this yii\web\View */
/* @var $searchModel frontend\models\search\DetailLatihanSearch */
/* @var $dataProvider yii\data\ActiveDataProvider */

$this->title = 'Soal Latihan | Web';
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="all-title-box">
  <div class="container text-center">
    <h1>Soal Latihan<span class="m_1"></span></h1>
  </div>
</div>
<div class="container">
    <br>
    <div class="row">
      <?= Html::a('Tambah Soal Latihan <br><i class="fa fa-plus-circle fa-3x"></i>', ['create', 'id' => $id], ['class' => 'btn btn-create']) ?>
    <div class="pull-right">
        <?= Html::a('Unggah File Penyelesaian <br> <i class="fa fa-upload fa-3x"></i>', ['kuis/update-penyel', 'id' => $id], ['class' => 'btn btn-create-in']) ?>
        <?= Html::a('Tambah Video Penyelesaian <br> <i class="fa fa-film fa-3x"></i>', ['video', 'id' => $id], ['class' => 'btn btn-create-in']) ?>
    </div>

    <br><br>
                                  
    <?php
    $urut = 0;
    foreach ($models as $data) { ?>
            <div class="panel panel-info">
              <div class="panel-heading">
                Pertanyaan <?php echo $urut=$urut+1; 
                $no_pertanyaan = $urut=$urut; ?>
              </div>
              <div class="panel-body">
                <div class="hidden">
                    <?= $data->latihan_id?>
                </div>
                                    
                <h4><?php echo $data->pertanyaan; ?></h4>
                <h6>A. <?= $data->opsi_a;?></h6>
                <h6>B. <?= $data->opsi_b;?></h6>
                <h6>C. <?= $data->opsi_c;?></h6>
                <h6>D. <?= $data->opsi_d;?></h6>
                <h6>E. <?= $data->opsi_e;?></h6>
                   
              </div>
              <!-- /panel-body -->
              <div class="panel-footer">
                <!-- <p>Pembahasan</p> -->
                <?= Html::a('<i class="fa fa-pencil"></i> Edit Soal', ['update', 'id' => $data->latihan_id], ['class' => 'btn btn-info']) ?>
                <?= Html::a('<i class="fa fa-trash"></i> Hapus Soal', ['delete', 'id' => $data->latihan_id], [
                    'class' => 'btn btn-danger',
                    'data' => [
                        'confirm' => 'Apakah Anda ingin menghapus soal ini?',
                        'method' => 'post',
                    ],
                ]) ?>
                
              </div>
              <!-- panel footer -->
             </div> 
    <?php } ?>
    </div>
</div><br><br><br>
