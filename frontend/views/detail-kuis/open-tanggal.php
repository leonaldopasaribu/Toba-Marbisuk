<?php	
	use yii\helpers\Html;
	use yii\grid\GridView;
	use yii\helpers\Url;
	use frontend\models\Kuis;
	use frontend\models\DetailKuis;	
	use frontend\models\User;
	use kartik\widgets\DateTimePicker;  
	use yii\bootstrap\ActiveForm;

	$this->title = 'Kuis | Web';
	$kuis = Kuis::find()->where(['kuis_id' => $id])->one();	
	$detailKuis = DetailKuis::find()->where(['kuis_id' => $id])->count();
	$user = User::find()->where(['id' => $kuis->created_by])->one();
?>	
<div class="all-title-box">
	<div class="container text-center">
		<h1>KUIS<span class="m_1"></span></h1>
	</div>
</div>
<div class="container">
	<br>
	<div class="open-quiz">
		<div class="row">
			<div class="col-md-5">
				<center>
					<h1 class="group card-title inner list-group-item-heading-head">
						<?= $kuis->mapel->nama_mapel;?>
					</h1>
					<h1 class="group card-title inner list-group-item-heading">
						<?= $kuis->kuis_name;?>
					</h1>

					<h2 class="group inner list-group-item-text">
						Jumlah Soal : <?= $detailKuis;?>
					</h2>
					<p class="group inner list-group-item-text">
					 <i class="fa fa-user"></i> <?= $user->nama_lengkap;?>
					</p>
				</center>
			</div>
			<div class="col-md-6">
		<?php
	       $form = ActiveForm::begin([
	       		'action' => ['kuis/update-tanggal', 'id'=>$model->kuis_id],
	       		'method' => 'post',
	         	'layout' => 'horizontal',
	         	'fieldConfig' => [
	            'template' => "{label}\n{beginWrapper}\n{input}\n{error}\n{endWrapper}\n{hint}",
				'horizontalCssClasses' => [
	                'label' => 'col-sm-4',
	                'wrapper' => 'col-sm-8',
	                'error' => '',
	                'hint' => '',
	              ],
	           ],
	       ])
	    ?>	         

	    <?= $form->field($model, 'waktu_kuis')->widget(DateTimePicker::classname(), [
	      'options' => ['class'=> 'input100','placeholder' => 'Masukkan Waktu Mulai Kuis'],
	      'pluginOptions' => [
	        'autoclose' => true,	        
	      ]
	    ]); ?>

	    <?= $form->field($model, 'sandi_kuis')->textInput(['class'=> 'input100','maxlength' => true, 'placeholder' => 'Masukkan Sandi Kuis'])->label('Sandi Kuis') ?>

	    <div class="form-group">
	        <div class="col-md-1 col-md-offset-2">
	            <?= Html::submitButton('Simpan', ['class' => 'btn btn-primary']) ?>
	        </div>
	    </div>

	    <?php ActiveForm::end(); ?>
	</div>
	</div>
</div>