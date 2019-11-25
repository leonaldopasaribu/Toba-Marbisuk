<?php	
	use yii\helpers\Html;
	use yii\grid\GridView;
	use yii\helpers\Url;

	$this->title = 'Mata Pelajaran | Web';
?>

<div class="all-title-box">
	<div class="container text-center">
		<h1>BAHAN BACAAN<span class="m_1">Temukan Hal Baru Untuk Memperluas Wawasan Kamu</span></h1>
	</div>
</div>
<div class="container">
	<br>
    <h1 class="title text-center">Mata <span>Pelajaran</span></h1>
    <br><br>
	<div class="isotope-container row grid-space-20">
	<?php
		foreach ($model as $key => $value) {
			// echo $value->kuis_name.'<br>';
			// echo "<a href='".Url::toRoute(['/detail-kuis/topik-by-murid', 'id' => $value->mapel_id])."'>".$value->nama_mapel."</a>";
			// echo '<br>'.$value->deskripsi.'<br><br>';
			$mapel = $value->nama_mapel;
	?>
	<!-- portfolio items start -->
		<div class="col-sm-6 col-md-3 isotope-item web-design">
			<div class="image-box">
				<div class="overlay-container">
					<img src="/WebPKM2018/frontend/web/worthy/images/<?php echo $mapel.".png";?>">
					<?php if (Yii::$app->user->isGuest) { ?>
						<?php echo "<a class='overlay' href='".Url::toRoute(['site/login'])."'>".$value->nama_mapel; ?>
							<i class="fa fa-search"></i>
							<span>Lihat Materi</span>
						<?php echo "</a>"; ?>
					<?php } else {?>
						<?php echo "<a class='overlay' href='".Url::toRoute(['topik-by-murid', 'id' => $value->mapel_id])."'>".$value->nama_mapel; ?>
							<i class="fa fa-search"></i>
							<span>Lihat Materi</span>
						<?php echo "</a>"; ?>
					<?php } ?>
				</div>
			<!-- <a class="btn btn-primary btn-block">Lihat Materi <i class="fa fa-arrow-right"></i></a> -->
			</div>
		</div>  
	<?php } ?> 
	</div>
<!-- portfolio items end -->
</div>
