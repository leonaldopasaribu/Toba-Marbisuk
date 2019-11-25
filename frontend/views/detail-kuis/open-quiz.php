<?php	
	use yii\helpers\Html;
	use yii\grid\GridView;
	use yii\helpers\Url;
	use frontend\models\Kuis;
	use frontend\models\User;
	use frontend\models\DetailKuis;	
	use yii\bootstrap\ActiveForm;

	$this->title = 'Kuis | Web';
	$kuis = Kuis::find()->where(['kuis_id' => $id])->one();	
	$detailKuis = DetailKuis::find()->where(['kuis_id' => $id])->count();
	$user = User::find()->where(['id' => $kuis->created_by])->one();	
?>	
<div class="all-title-box" style="margin-top: 5px;">
	<div class="container text-center">
		<h1>KUIS<span class="m_1"></span></h1>
	</div>
</div>
<div class="container">
	<br>
	<div class="open-quiz">
		<center>
		<?php if (Yii::$app->user->identity->role == 2) { ?>
			<?php if ($kuis->status == 1) { ?>
			<p style="color: #374f98; font-size: 30px;">
				<b>Hi,</b><br>
			</p>
			<p>
				Kamu telah menyelesaikan kuis ini cek materi dan video penyelesaian<br>
			</p>
			<p>
				Ikuti kuis lainnya
			</p>

			<h2 class="group inner list-group-item-text">
				<?= $kuis->kuis_name;?>
			</h2>
			<p class="group inner list-group-item-text">
				Jumlah Soal : <?= $detailKuis;?>
			</p>
			<p class="group inner list-group-item-text">
				Jumlah Score : <?= $kuis->score;?>
			</p>

			<?= Html::a(' Review Kuis <i class="fa fa-arrow-right"></i>', ['jawaban', 'id' => $id], ['class' => 'btn btn-success']) ?>
			<!-- <?= Html::a(' Download Penyelesaian <i class="fa fa-arrow-right"></i>', ['kuis/download-kuis', 'id' => $kuis->kuis_id], ['class' => 'btn btn-success']) ?> -->
			<?php } else {?>

			<div class="row">
				<div class="col-md-6">
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
				</div>
				
				

				<?php
					date_default_timezone_set('Asia/Jakarta');
					$sekarang = date("d-m-Y H:i:s");
					$awal  = strtotime($sekarang);
					$akhir = strtotime($model->waktu_kuis);
					$diff  = $akhir - $awal;

					// $jam   = floor($diff / (60 * 60));
					// $menit = $diff - $jam * (60 * 60);
					$day = floor($diff / 86400);
			        $jam = floor(($diff % 86400) / 3600);
			        $menit = floor(($diff % 3600) / 60);
			        $sec = ($diff % 60);

					$sub_kalimat = substr($sec,0,1);
					if ($sub_kalimat != '-' && $day == 0 && $jam == 0 && $menit == 0) {
						echo 'Kuis Akan Dimulai Setelah '. $sec . ' detik';
					} else if ($sub_kalimat != '-' && $day == 0 && $jam == 0 ) {
						echo 'Kuis Akan Dimulai Setelah ' .  $menit  . ' menit ' . $sec . ' detik';
					} else if ($sub_kalimat != '-' && $day == 0 ) {
						echo 'Kuis Akan Dimulai Setelah ' . $jam . ' jam '. $menit  . ' menit ' . $sec . ' detik';
					} else if ($sub_kalimat != '-') {
						echo 'Kuis Akan Dimulai Setelah ' .$day . ' hari '. $jam .  ' jam ' .  $menit  . ' menit ' . $sec . ' detik';
					} else {
						
					}			
				?>

				<?php if ($model->sandi_kuis == null) {	?>
					<?php if ($sub_kalimat != '-') { ?>
						<?= Html::a(' Mulai Kuis <i class="fa fa-arrow-right"></i>', ['soal-student', 'id' => $id], ['class' => 'btn btn-success', 'disabled' => true]) ?>	
					<?php } else {?>
						<?= Html::a(' Mulai Kuis <i class="fa fa-arrow-right"></i>', ['soal-student', 'id' => $id], ['class' => 'btn btn-success']) ?>
					<?php } ?>
				<?php } else {?>
					<?php
				       $form = ActiveForm::begin([	
					        // 'action' => ['open-kuis', 'id' => $kuis->kuis_id],
			       			'method' => 'post',		       		
				         	'layout' => 'horizontal',
				         	'fieldConfig' => [
				            'template' => "{label}\n{beginWrapper}\n{input}\n{error}\n{endWrapper}\n{hint}",
							'horizontalCssClasses' => [
				                'wrapper' => 'col-sm-7',
				                'error' => '',
				                'hint' => '',
				              ],
				           ],
				       ])
				    ?>	         

				    <div class="col-md-6">
					    <?= $form->field($model, 'pass')->textInput(['maxlength' => true, 'class' => 'input100', 'placeholder' => 'Masukkan Sandi Kuis'])->label('Sandi Kuis') ?>
					
					    <?php if ($sub_kalimat != '-') { ?>
						    <div class="form-group">
						        <div class="col-md-1 col-md-offset-2">
						            <?= Html::submitButton('Submit',['open-quiz', 'id' => $kuis->kuis_id, 'class' => 'btn btn-primary', 'disabled' => true]) ?>
						        </div>
						    </div>
						<?php } else {?>
							<div class="form-group">
						        <div class="col-md-0">
						            <?= Html::submitButton('Kirim',['open-quiz', 'id' => $kuis->kuis_id, 'class' => 'btn btn-primary']) ?>
						        </div>
						    </div>
				    </div>
					<?php } ?>

			    	<?php ActiveForm::end(); ?>
				<?php } ?>
			</div>

				<!-- <?= Html::a(' Mulai Kuis <i class="fa fa-arrow-right"></i>', ['soal-student', 'id' => $id], ['class' => 'btn btn-success']) ?> -->
			<?php } ?>
		<?php } else if(Yii::$app->user->identity->role == 1) {?>
			<h2 class="group inner list-group-item-text">
				Mata Pelajaran : <?= $kuis->mapel->nama_mapel;?><br>
				Topik Kuis : <?= $kuis->kuis_name;?>
			</h2>
			<p class="group inner list-group-item-text">
				Jumlah Soal : <?= $detailKuis;?>
			</p>
			<div>
				<?= Html::a(' Mulai Kuis <i class="fa fa-arrow-right"></i>', ['soal-teacher', 'id' => $id], ['class' => 'btn btn-success']) ?>
			</div>
		<?php } ?>
		</center>
	</div>
</div>








