<?php	
	use yii\helpers\Html;
	use yii\grid\GridView;
	use yii\helpers\Url;

	$this->title = 'Latihan | Web';
?>

<div class="all-title-box">
	<section class="top-border"></section>
	<div class="container text-center">
		<h1>LATIHAN<span class="m_1">Uji kemampuan akademik kamu disini</span></h1>
	</div>
</div>
<div class="container">
	<br>
    <h1 class="title text-center">Mata <span>Pelajaran</span></h1>

    <br>
    <br>
	<div class="isotope-container row grid-space-20">
	<?php
		foreach ($model as $key => $value) {
			$mapel = $value->nama_mapel;
	?>
	<!-- portfolio items start -->
		<div class="col-sm-6 col-md-3 isotope-item web-design">
			<div class="image-box">
				<div class="overlay-container">
					<img src="worthy/images/<?php echo $mapel.".png";?>">
						<?php echo "<a class='overlay' href='".Url::toRoute(['detail-kuis/topik-by-guru', 'id' => $value->mapel_id])."'>".$value->nama_mapel; ?>
							<i class="fa fa-search"></i>
							<span>Lihat Materi</span>
						<?php echo "</a>"; ?>
				</div>
			</div>
		</div>  
	<?php } ?> 
	</div>
<!-- portfolio items end -->
</div>









