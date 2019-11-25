<?php

use yii\helpers\Html;
use yii\widgets\ActiveForm;

/* @var $this yii\web\View */
/* @var $model frontend\models\DetailKuis */
/* @var $form yii\widgets\ActiveForm */
$this->title = 'Hasil Kuis | Web';
$this->params['breadcrumbs'][] = ['label' => 'Detail Kuis', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="all-title-box" style="margin-top: 5px;">
	<div class="container text-center">
		<h1>Hasil Kuis<span class="m_1"></span></h1>
	</div>
</div>
<div class = "container top">
<?php $form = ActiveForm::begin(); ?>			    					    
<?php
	$urut = 0;
	foreach ($model as $value) { ?>
			<div class="panel panel-primary">
	          <div class="panel-heading">
	            <h4>SOAL Nomor <?php echo $urut=$urut+1; ?></h4>
	          </div>
	          <div class="panel-body">
	            <div class="hidden">
			    	<?= $form->field($value, 'id[]')->textInput(['value' => $value->detail_kuis_id]) ?>
			    </div>
			    				  	
				<h3><?php echo $value->pertanyaan; ?></h3>
						
				    <?= $form->field($value, 'pilihan['.$value->detail_kuis_id.']')->radio(['label' => $value->opsi_a, 'value' => 1, 'uncheck' => null])->label('A.') ?>
					<?= $form->field($value, 'pilihan['.$value->detail_kuis_id.']')->radio(['label' => $value->opsi_b, 'value' => 2, 'uncheck' => null])->label('B.') ?>
					<?= $form->field($value, 'pilihan['.$value->detail_kuis_id.']')->radio(['label' => $value->opsi_c, 'value' => 3, 'uncheck' => null])->label('C.') ?>
					<?= $form->field($value, 'pilihan['.$value->detail_kuis_id.']')->radio(['label' => $value->opsi_d, 'value' => 4, 'uncheck' => null])->label('D.') ?>
					<?= $form->field($value, 'pilihan['.$value->detail_kuis_id.']')->radio(['label' => $value->opsi_e, 'value' => 5, 'uncheck' => null])->label('E.') ?>	
	          </div>
	          <!-- /panel-body -->
	          <div class="panel-footer">
	            <p>
	            	<?php if ($value->jawaban_user == $value->jawaban_benar) { ?>
		  	     Jawaban Kamu Benar : 
		  	     <?php 	  	    
			  	    if ($value->jawaban_user == 1) {
			  	    	echo $value->opsi_a;
			  	    } else if($value->jawaban_user == 2){
			  	    	echo $value->opsi_b;
			  	    } else if($value->jawaban_user == 3){
			  	    	echo $value->opsi_c;
			  	    } else if($value->jawaban_user == 4){
			  	    	echo $value->opsi_d;
			  	    } else if($value->jawaban_user == 5){
			  	    	echo $value->opsi_e;
			  	    }
			  	?>	
		<?php }else { ?>
		  	     Jawaban Kamu :  
		  	    <?php 	  	    
			  	    if ($value->jawaban_user == 1) {
			  	    	echo $value->opsi_a;
			  	    } else if($value->jawaban_user == 2){
			  	    	echo $value->opsi_b;
			  	    } else if($value->jawaban_user == 3){
			  	    	echo $value->opsi_c;
			  	    } else if($value->jawaban_user == 4){
			  	    	echo $value->opsi_d;
			  	    } else if($value->jawaban_user == 5){
			  	    	echo $value->opsi_e;
			  	    }
			  	?>	  	      
			  	<br>
		  	     Jawaban Yang Benar : 
		  	     <?php 
			  	    if ($value->jawaban_benar == 1) {
			  	    	echo $value->opsi_a;
			  	    } else if($value->jawaban_benar == 2){
			  	    	echo $value->opsi_b;
			  	    } else if($value->jawaban_benar == 3){
			  	    	echo $value->opsi_c;
			  	    } else if($value->jawaban_benar == 4){
			  	    	echo $value->opsi_d;
			  	    } else if($value->jawaban_benar == 5){
			  	    	echo $value->opsi_e;
			  	    }
			  	?>

		
	
	            
	          </div>
	          <!-- panel footer -->
	         </div>	
<?php } } ?></p>
	
	<?php ActiveForm::end(); ?>
</div>






<!-- 	 -->