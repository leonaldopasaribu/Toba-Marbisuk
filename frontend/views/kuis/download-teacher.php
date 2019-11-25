<?php

use yii\helpers\Html;
use yii\widgets\DetailView;
use frontend\models\User;

/* @var $this yii\web\View */
/* @var $model frontend\models\Kuis */

$this->title = $model->kuis_name. " | Web";
$this->params['breadcrumbs'][] = ['label' => 'Kuis', 'url' => ['index']];
$this->params['breadcrumbs'][] = $this->title;
?>
<div class="all-title-box">
    <div class="container text-center">
        <h1><?php echo $model->mapel->nama_mapel; ?><span class="m_1">-<?php echo $model->kuis_name; ?>-</span></h1>
    </div>
</div>
<div class="container">
    <br>
    <h1 class="title text-center">Video <span>Pembelajaran</span></h1>
    <br>
    <br>
    <center>
        <div class="youtube">
            <iframe width="100%" height="100%" src="https://www.youtube.com/embed/<?php echo $model->materi_video;?>" frameborder="0" allowfullscreen="1" allow="accelerometer"> 
            </iframe>
        </div>
    </center>

    <div class="deskripsi">
        <h2><?php echo $model->deskripsi; ?></h2>
    </div>

    <?= Html::a('Unduh Materi <br> <i class="fa fa-download fa-3x"></i>', ['download-kuis', 'id' => $model->kuis_id], ['class' => 'btn btn-create']) ?>

    <?= $this->render('_form-komentar', [
        'models' => $models,
    ]) ?> 

    <div class="topik">
    <?php 
        foreach ($komentar as $key => $value) {
            $user = User::find()->where(['id' => $value->created_by])->one();
         ?>            
        <div class="media">
            <a href="#" class="pull-left">
                <img src= "<?= $user->file_foto ?>" class="img-responsive" width="50px" height="50px"/>
            </a>
            <div class="media-body">
                <h4 class="media-heading"><?= $user->nama_lengkap ?></h4> 
                <h4 class="media-heading1"><?= date('d M Y', strtotime($value->created_at));?></h4>
                <p><?= $value->komentar ?>.</p>
            </div>        
        </div>
        <br>

    <?php } ?>
    </div>
</div>
