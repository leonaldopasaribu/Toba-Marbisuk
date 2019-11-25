<?php	
	use yii\helpers\Html;
	use yii\grid\GridView;
	use yii\helpers\Url;
	use frontend\models\User;	

	$this->title = 'Topik Pelajaran | Web';	
?>	
<div class="all-title-box">
	<div class="container text-center">
		<h1>TOPIK PELAJARAN<span class="m_1"></span></h1>
	</div>
</div>

<div class="container">
	<br>
	<h1 class="title text-center">Topik <span> Pelajaran</span></h1>
	<br>
	<div id="products" class="row view-group">
	<?php
		foreach ($model as $key => $value) {

		$user = User::find()->where(['id' => $value->created_by])->one();		
	?>
	    <div class="item">
	      	<div class="col-md-12 topik" style="padding-top: 20px;">
		        <div class="col-md-2">
		            <img src=<?= Yii::getAlias('@web') . "/frontend/web/worthy/images/" . $value->mapel->nama_mapel . ".png" ?>>
		        </div>
		        <div class="col-md-8">    
		            <h4 class="title-heading">
		                <?= $value->kuis_name;?>
		            </h4>
		            <p class="created"><i class="fa fa-user"></i> <?= $user->nama_lengkap;?> &emsp; <i class="fa fa-calendar"></i> <?= date('d M Y', strtotime($value->created_at));?></p>
		            <p class="group inner list-group-item-text">
		               	<?= $value->deskripsi;?> <br><br>
		               	<?= Html::a('Lihat Selengkapnya <i class="fa fa-long-arrow-right m-l-5" aria-hidden="true"></i>', ['kuis/download-teacher', 'id' => $value->kuis_id], ['class' => 'btn btn-success']) ?>
		               	<!-- <a type="button" href="<?php echo $value->materi_video;?>" value="" target="_blank" class="btn btn-info">Lihat Video</a> -->
		            </p>
		        </div>
	      	</div>
	    </div>

	    <?php }?>
	</div>
</div>
