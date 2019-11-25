<?php

/* @var $this yii\web\View */

$this->title = 'Beranda | Web';
?>

<div class="site-index">
    <!-- Slider -->
    <div id="bootstrap-touch-slider" class="carousel bs-slider fade  control-round indicators-line" data-ride="carousel" data-pause="hover" data-interval="false" >
        <!-- Indicators -->
        <ol class="carousel-indicators">
            <li data-target="#bootstrap-touch-slider" data-slide-to="0" class="active"></li>
            <li data-target="#bootstrap-touch-slider" data-slide-to="1"></li>
            <li data-target="#bootstrap-touch-slider" data-slide-to="2"></li>
        </ol>
        <div class="carousel-inner" role="listbox">
            <div class="item active">
                <div id="home" class="first-section" style="background-image:url('img/1.jpg'); background-size: cover;">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-12 col-sm-12 text-center">
                                <div class="big-tagline">
                                    <h2 data-animation="animated zoomInRight"> Belajar Menjadi <strong>Makin Seru</strong></h2>
                                    <p class="lead" data-animation="animated fadeInLeft">Dengan Materi dan Tutorial Terbaik</p>
                                </div>
                            </div>
                        </div><!-- end row -->            
                    </div><!-- end container -->
                </div><!-- end section -->
            </div>
            <div class="item">
                <div id="home" class="first-section" style="background-image:url('img/2.jpg'); background-size: cover;">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-12 col-sm-12 text-center">
                                <div class="big-tagline">
                                    <h2 data-animation="animated zoomInRight">Dengan <strong> Fitur</strong> Menarik</h2>
                                    <p class="lead" data-animation="animated fadeInLeft">Fitur menarik yang kami sediakan membuat belajar semakin nyaman dan berkembang</p>
                                </div>
                            </div>
                        </div><!-- end row -->            
                    </div><!-- end container -->
                </div><!-- end section -->
            </div>
            <div class="item">
                <div id="home" class="first-section" style="background-image:url('img/3.jpg'); background-size: cover;">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-12 col-sm-12 text-center">
                                <div class="big-tagline">
                                    <h2 data-animation="animated zoomInRight">Sumber Materi <strong>Terpercaya</strong></h2>
                                    <p class="lead" data-animation="animated fadeInLeft">Materi pelajaran yang diberikan merupakan hasil diskusi guru dan dosen yang berpengalaman</p>
                                </div>
                            </div>
                        </div><!-- end row -->            
                    </div><!-- end container -->
                </div><!-- end section -->
            </div>
            <!-- Left Control -->
            <a class="left carousel-control" href="#bootstrap-touch-slider" role="button" data-slide="prev">
                <span class="fa fa-angle-left" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>

            <!-- Right Control -->
            <a class="right carousel-control" href="#bootstrap-touch-slider" role="button" data-slide="next">
                <span class="fa fa-angle-right" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>
    </div>
    <!-- End Slider -->
    <div class="fitur">
        <div class="container">
            <div class="row">
                <br>
                <h1 class="judul text-center" style="font-size: 30px;">Fitur Lengkap <span>Penunjang Belajar</span></h1><br>
                <h3 class="text-center" style="font-weight: 1200;"><b>Dirancang khusus sesuai kebutuhanmu<b></h3>
                <br>
                <div class="col-md-4">
                    <img src="img/video.png">
                    <br>
                    <h3 class="text-center"><b>Tonton Video Pembelajaran</b></h3>
                    <p class="text-center">Pahami konsep dengan mudah dari tutor terbaik</p>
                </div>

                <div class="col-md-4">
                    <img src="img/kuis.png">
                    <br>
                    <h3 class="text-center"><b>Latihan Soal dan Pembahasan</b></h3>
                    <p class="text-center">Terdapat banyak soal untuk menguji pemahaman kamu tentang suatu konsep</p>
                </div>

                <div class="col-md-4">
                    <img src="img/materi.png">
                    <br>
                    <h3 class="text-center"><b>Unduh Catatan Belajar</b></h3>
                    <p class="text-center">Catatan materi yang dapat diunduh untuk kamu yang suka belajar dari catatan</p>
                </div>
            </div>
        </div>
    </div>
</div>
