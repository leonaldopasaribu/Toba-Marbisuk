<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model frontend\models\DetailKuis */
/* @var $form yii\widgets\ActiveForm */
$this->title = 'Soal | Web';
$this->params['breadcrumbs'][] = ['label' => 'Detail Kuis', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="all-title-box" style="margin-top: 5px;">
	<div class="container text-center">

	</div>
</div>
<div class = "container">
<div class="open-quiz">
	<h4>
		Aturan Quiz
	</h4>
</div>

<?php $form = ActiveForm::begin(); ?>			    					    
<?php
	$urut = 0;
	foreach ($models as $data) { ?>
			<div class="panel panel-primary">
	          <div class="panel-heading">
	            <h4>SOAL NOMOR <?php echo $urut=$urut+1; ?></h4>
	          </div>
	          <div class="panel-body">
	            <div class="hidden">
			    	<?= $form->field($data, 'id[]')->textInput(['value' => $data->detail_kuis_id]) ?>
			    </div>
			    				  	
				<h3><?php echo $data->pertanyaan; ?></h3>
						
				    <?= $form->field($data, 'pilihan['.$data->detail_kuis_id.']')->radio(['label' => $data->opsi_a, 'value' => 1, 'uncheck' => null])->label('A.') ?>
					<?= $form->field($data, 'pilihan['.$data->detail_kuis_id.']')->radio(['label' => $data->opsi_b, 'value' => 2, 'uncheck' => null])->label('B.') ?>
					<?= $form->field($data, 'pilihan['.$data->detail_kuis_id.']')->radio(['label' => $data->opsi_c, 'value' => 3, 'uncheck' => null])->label('C.') ?>
					<?= $form->field($data, 'pilihan['.$data->detail_kuis_id.']')->radio(['label' => $data->opsi_d, 'value' => 4, 'uncheck' => null])->label('D.') ?>
					<?= $form->field($data, 'pilihan['.$data->detail_kuis_id.']')->radio(['label' => $data->opsi_e, 'value' => 5, 'uncheck' => null])->label('E.') ?>	
	          </div>
	          <!-- /panel-body -->
	          <div class="panel-footer">
	            <p>Soal 1 dari 3</p>
	          </div>
	          <!-- panel footer -->
	         </div>	
	<?php } ?>
	<div class="pull-right">				        
	    <div class="form-group">					        
	        <?= Html::submitButton('Submit', ['soal'], ['class' => 'btn btn-primary']) ?>
	    </div>
	</div>
	<?php ActiveForm::end(); ?>
</div>
