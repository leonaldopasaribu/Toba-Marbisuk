<?php	
	use yii\helpers\Html;
	use yii\grid\GridView;
	use yii\helpers\Url;	
	use frontend\models\User;

	$this->title = 'Topik Latihan | Web';	
?>	

<div class="all-title-box">
	<div class="container text-center">
		<h1>TOPIK LATIHAN<span class="m_1"></span></h1>
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
		        <div class="col-md-8">    
		            <h4 class="title-heading">
		                <?= $value->kuis_name;?>
		            </h4>
		            <p class="created"><i class="fa fa-user"></i> <?= $user->nama_lengkap;?> &emsp; <i class="fa fa-calendar"></i> <?= date('d M Y', strtotime($value->created_at));?></p>
		            <p class="group inner list-group-item-text">
		               	<?= $value->deskripsi;?> <br><br>
		               	<?= Html::a('Ikuti Latihan', ['detail-latihan/index-by-student', 'id' => $value->kuis_id], ['class' => 'btn btn-info']) ?>
		               	<?= Html::a('Ikuti Kuis', ['open-quiz', 'id' => $value->kuis_id], ['class' => 'btn btn-warning']) ?>
		            </p>
		        </div>
	      	</div>
	    </div>

	    <?php }?>
	</div>
</div>