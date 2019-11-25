<?php	
	use yii\helpers\Html;
	use yii\grid\GridView;
	use yii\helpers\Url;
	use frontend\models\User;	

	$this->title = 'Topik Latihan | Web';	
?>	

<div class="all-title-box">
	<div class="container text-center">
		<h1>TOPIK LATIHAN<span class="m_1">Pilih Topik Pelajaran Kegemaranmu</span></h1>
	</div>
</div>

<div class="container">
	<br>
	<h1 class="title text-center">Topik <span> Latihan</span></h1>
	<br>
	<div id="products" class="row view-group">
	<?php
		foreach ($model as $key => $value) {

		$user = User::find()->where(['id' => $value->created_by])->one();			
	?>
	    <div class="item">
	      	<div class="col-md-12 topik" style="padding-top: 10px;">
		        <div class="col-md-2">
		            <img src="worthy/images/<?php echo $value->mapel->nama_mapel.".png";?>" class="img-responsive">
		    	</div>
		        <div class="col-md-9">    
		            <h4 class="title-heading">
		                <?= $value->kuis_name;?>
		            </h4>
		            <p class="created"><i class="fa fa-user"></i> <?= $user->nama_lengkap;?> &emsp; <i class="fa fa-calendar"></i> <?= date('d M Y', strtotime($value->created_at));?></p>
		            <p class="group inner list-group-item-text">
		               	<?= $value->deskripsi;?> <br><br>

		               	<?= Html::a('Tambah Latihan', ['detail-latihan/index-by-teacher', 'id' => $value->kuis_id], ['class' => 'btn btn-info']) ?>
		               	<?= Html::a('Tambah Kuis', ['open-tanggal', 'id' => $value->kuis_id], ['class' => 'btn btn-warning']) ?>
		            </p>
		        </div>
		        <!-- <div class="col-md-1">
		        	<p>
				        <?= Html::a('<i class="fa fa-pencil"></i> Edit', ['/kuis/update', 'id' => $value->kuis_id], ['class' => 'btn btn-info']) ?>
				    </p>
		        	<p style="margin-top: 5px;">
				        <?= Html::a('<i class="fa fa-trash"></i> Hapus ', ['/kuis/create', 'id' => $test], ['class' => 'btn btn-danger']) ?>
				    </p>
		        </div> -->
	      	</div>
	    </div>

	    <?php }?>
	</div>
</div>
