<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;
use frontend\models\DetailKuis;	

/* @var $this yii\web\View */
/* @var $model frontend\models\DetailKuis */
/* @var $form yii\widgets\ActiveForm */
$this->title = 'Soal Kuis | Web';
$this->params['breadcrumbs'][] = ['label' => 'Detail Kuis', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;

$detailKuis = DetailKuis::find()->where(['kuis_id' => $id])->count();
?>
<div class="all-title-box" style="margin-top: 5px;">
	<div class="container text-center">
		<h1>Tambah Kuis<span class="m_1"></span></h1>
	</div>
</div>
<div class = "container">
	<br>
	<p>
	    <?= Html::a('<i class="fa fa-plus-circle fa-4x"></i> Tambah Pertanyaan', ['/detail-kuis/create', 'id' => $test], ['class' => 'btn btn-create']) ?>
	</p>
	<br>
	<?php $form = ActiveForm::begin(); ?>			    					    
	<?php
		$urut = 0;
		foreach ($models as $data) { ?>
				<div class="panel panel-primary">
		          <div class="panel-heading">
		            Pertanyaan <?php echo $urut=$urut+1; 
		            $no_pertanyaan = $urut=$urut; ?>
		          </div>
		          <div class="panel-body">
		            <div class="hidden">
				    	<?= $form->field($data, 'id[]')->textInput(['value' => $data->detail_kuis_id]) ?>
				    </div>
				    				  	
					<h4><?php echo $data->pertanyaan; ?></h4>
					<h6>
						
					    <?= $form->field($data, 'pilihan['.$data->detail_kuis_id.']')->radio(['disabled'=> 'disabled', 'class'=> 'option-input radio','label' => $data->opsi_a, 'value' => 1, 'uncheck' => null])->label('A.') ?>
						<?= $form->field($data, 'pilihan['.$data->detail_kuis_id.']')->radio(['disabled'=> 'disabled', 'class'=> 'option-input radio','label' => $data->opsi_b, 'value' => 2, 'uncheck' => null])->label('B.') ?>
						<?= $form->field($data, 'pilihan['.$data->detail_kuis_id.']')->radio(['disabled'=> 'disabled', 'class'=> 'option-input radio','label' => $data->opsi_c, 'value' => 3, 'uncheck' => null])->label('C.') ?>
						<?= $form->field($data, 'pilihan['.$data->detail_kuis_id.']')->radio(['disabled'=> 'disabled', 'class'=> 'option-input radio','label' => $data->opsi_d, 'value' => 4, 'uncheck' => null])->label('D.') ?>
						<?= $form->field($data, 'pilihan['.$data->detail_kuis_id.']')->radio(['disabled'=> 'disabled', 'class'=> 'option-input radio','label' => $data->opsi_e, 'value' => 5, 'uncheck' => null])->label('E.') ?>
					</h6>	
		          </div>
		          <!-- /panel-body -->
		          <div class="panel-footer">
		            <p>Pertanyaan <?php echo $no_pertanyaan;?> dari <?php echo $detailKuis;?></p>
			        <?= Html::a('<i class="fa fa-pencil"></i> Edit Soal', ['update', 'id' => $data->detail_kuis_id], ['class' => 'btn btn-info']) ?>
	                <?= Html::a('<i class="fa fa-trash"></i> Hapus Soal', ['delete', 'id' => $data->detail_kuis_id], [
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
		<!-- <div class="pull-right">				        
		    <div class="form-group">					        
		        <?= Html::submitButton('Submit', ['soal'], ['class' => 'btn btn-primary']) ?>
		    </div>
		</div> -->
	<?php ActiveForm::end(); ?>
</div>
