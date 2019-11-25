<?php

namespace frontend\controllers;

use Yii;
use frontend\models\DetailKuis;
use frontend\models\search\DetailKuisSearch;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;
use frontend\models\Kuis;

/**
 * DetailKuisController implements the CRUD actions for DetailKuis model.
 */
class DetailKuisController extends Controller
{
    /**
     * @inheritdoc
     */
    public function behaviors()
    {
        return [
            'verbs' => [
                'class' => VerbFilter::className(),
                'actions' => [
                    'delete' => ['POST'],
                ],
            ],
        ];
    }

    /**
     * Lists all DetailKuis models.
     * @return mixed
     */
    public function actionIndex()
    {
        $searchModel = new DetailKuisSearch();
        $dataProvider = $searchModel->search(Yii::$app->request->queryParams);

        return $this->render('index', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
        ]);
    }

    public function actionOpenQuiz($id)
    {
        // echo 'test';die();
        // $searchModel = new DetailKuisSearch();
        // $dataProvider = $searchModel->search(Yii::$app->request->queryParams);
        $model = Kuis::find()->where(['kuis_id' => $id])->one();
        // echo $model->pass;die();
        if(isset($_POST['Kuis']['pass'])) {
            // echo $_POST['Kuis']['pass'];die();
            // echo $model->sandi_kuis;
            if ($_POST['Kuis']['pass'] == $model->sandi_kuis) {
                return $this->redirect(['soal-student', 'id' => $model->kuis_id]);
            }else{               
              Yii::$app->getSession()->setFlash('warning', 'Kata Sandi Yang Anda Masukkan Salah');
            }
        }


        return $this->render('open-quiz', [
            'id' => $id,
            'model' => $model,
        ]);
    }

    /**
     * Displays a single DetailKuis model.
     * @param integer $id
     * @return mixed
     */
    public function actionView($id)
    {
        return $this->render('view', [
            'model' => $this->findModel($id),
        ]);
    }

    /**
     * Creates a new DetailKuis model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return mixed
     */
    public function actionCreate($id)
    {        
        $model = new DetailKuis();            
        $kuis = Kuis::find()->where(['kuis_id' => $id])->one();        

        if ($model->load(Yii::$app->request->post())) {
            if ($model->validate()) {
                $model->kuis_id = $kuis['kuis_id'];    
                $model->save();
                return $this->redirect(['create', 'id' => $model->kuis_id]);
            }
        } else {
            return $this->render('create', [
                'model' => $model,
                'kuis' => $kuis,
            ]);
        }
    }

    /**
     * Updates an existing DetailKuis model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param integer $id
     * @return mixed
     */
    public function actionUpdate($id)
    {
        $model = $this->findModel($id);

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            return $this->redirect(['soal-teacher', 'id' => $model->kuis_id]);
        } else {
            return $this->render('update', [
                'model' => $model,
            ]);
        }
    }

    // public function actionSoal()
    // {
    //     // $user_id = yii::$app->user->identity->id;        
    //     // $kuis = Kuis::find()->where(['user_id' => $user_id])->one();        
    //     $model = DetailKuis::find()->all();
        
    //     return $this->render('soal', [
    //         'model' => $model,
    //     ]);
        
    // }

    // public function actionSoal()
    // {        
    //     $model = new DetailKuis();
    //     $models = DetailKuis::find()->one();                      
    //     if ($model->load(Yii::$app->request->post())) {
    //         if ($model->validate()) {   
    //             $id = $models->kuis_id;
    //             $modelUpdate = DetailKuis::find()->where(['kuis_id' => $id])->one();               
    //             $modelUpdate->jawaban_user = $model->jawaban_user;
    //             $modelUpdate->save();
    //             return $this->redirect(['view', 'id' => $modelUpdate->detail_kuis_id]);
    //         }
    //     } else {
    //         return $this->render('createsoal', [
    //             'model' => $model,
    //             'models' => $models,
    //         ]);
    //     }
    // }

    public function actionSoalTeacher($id)
    {        
        $models = DetailKuis::find()->where(['kuis_id' => $id])->all();
        $test = $id;
        $hitung = count($models);             
        if (isset($_POST['DetailKuis']['id'])) {
             
            $id_soal = $_POST['DetailKuis']['id'];
            $pilihan = $_POST['DetailKuis']['pilihan'];
            $score=0;
            $benar=0;
            $salah=0;
            $kosong=0;


            for ($i=0; $i < $hitung; $i++) { 
                $nomor = $id_soal[$i];
                if (empty($pilihan[$nomor])) {
                    $kosong++;
                }else{
                    $jawaban = $pilihan[$nomor];
                    $kuncijawaban = DetailKuis::find()->where(['detail_kuis_id' => $nomor])->one();   
                    $kuis = Kuis::find()->where(['kuis_id' => $id])->one();
                    $kuncijawaban->jawaban_user = $jawaban;
                    $kuis->status = 1;

                    $kuncijawaban->save();
                    $kuis->save();
                    
                    if ($kuncijawaban->jawaban_benar == $jawaban) {
                        $benar++;
                    }else{
                        $salah++;
                    }                    
                }
                $score = 100/$hitung*$benar;
                $kuis->score = $score;
                $kuis->save();

            }            
            return $this->redirect(['jawaban', 'id' => $kuncijawaban->kuis_id]);
            
        }
            return $this->render('soal-teacher', [                
                'models' => $models,
                'test' => $test,
                'id' => $id,
            ]);
        // }
    }

    public function actionSoalStudent($id)
    {        
        $models = DetailKuis::find()->where(['kuis_id' => $id])->all();            
        $test = $id;
        $hitung = count($models);     

        // if ($models->load(Yii::$app->request->post())) {
        //     if ($models->validate()) {                   
        //         $models->save();
        //         return $this->redirect(['view', 'id' => $models->detail_kuis_id]);
        //     }
        // } else {        
        if (isset($_POST['DetailKuis']['id'])) {
             // var_dump($_POST['DetailKuis']['id']);
             // var_dump($_POST['DetailKuis']['pilihan']);
             
            $id_soal = $_POST['DetailKuis']['id'];
            $pilihan = $_POST['DetailKuis']['pilihan'];
            $score=0;
            $benar=0;
            $salah=0;
            $kosong=0;

            for ($i=0; $i < $hitung; $i++) { 
                $nomor = $id_soal[$i];
                if (empty($pilihan[$nomor])) {
                    $kosong++;
                }else{
                    $jawaban = $pilihan[$nomor];
                    $kuncijawaban = DetailKuis::find()->where(['detail_kuis_id' => $nomor])->one();   
                    $kuis = Kuis::find()->where(['kuis_id' => $id])->one();
                    $kuncijawaban->jawaban_user = $jawaban;
                    $kuis->status = 1;

                    $kuncijawaban->save();
                    $kuis->save();
                    
                    if ($kuncijawaban->jawaban_benar == $jawaban) {
                        $benar++;
                    }else{
                        $salah++;
                    }                    
                }
                $score = 100/$hitung*$benar;
                $kuis->score = $score;
                $kuis->save();

            }  
            return $this->redirect(['jawaban', 'id' => $kuncijawaban->kuis_id]);
            
        }
            return $this->render('soal-student', [                
                'models' => $models,
                'test' => $test,
            ]);
        // }
    }

    public function actionLatihanStudent()
    {        
        $models = DetailKuis::find()->all();                    
        $hitung = count($models);     
        
        if (isset($_GET['Kuis']['kuis_name'])) {
             
             
            $id_soal = $_GET['Kuis']['kuis_name'];
            $kuis = Kuis::find()->where(['kuis_id' => $id_soal])->one();  
           
            return $this->redirect(['open-quiz', 'id' => $id_soal]);
            
        }
            return $this->render('soal-student', [                
                'models' => $models,
                'test' => $test,
            ]);
    }

    public function actionLatihanTeacher()
    {        
        $models = DetailKuis::find()->all();                    
        $hitung = count($models);     
        
        if (isset($_GET['Kuis']['kuis_name'])) {             
            $id_soal = $_GET['Kuis']['kuis_name'];   
           
            return $this->redirect(['soal-teacher', 'id' => $id_soal]);
            
        }
            return $this->render('soal-student', [                
                'models' => $models,
                'test' => $test,
            ]);
    }

    public function actionJawaban($id)
    {
        $model = DetailKuis::find()->where(['kuis_id' => $id])->all();   
        $kuis  = Kuis::find()->where(['kuis_id' => $id])->one();        

        return $this->render('jawaban', [                
            'model' => $model,
            'kuis' => $kuis,
        ]);
    }

    public function actionOpenTanggal($id)
    {
        // $searchModel = new DetailKuisSearch();
        // $dataProvider = $searchModel->search(Yii::$app->request->queryParams);
        $model = Kuis::find()->where(['kuis_id' => $id])->one();        

        return $this->render('open-tanggal', [
            'id' => $id,
            'model' => $model,
        ]);
    }

    public function actionTopikByMurid($id)
    {
        $model = Kuis::find()->where(['mapel_id' => $id])->orderBy(['kuis_id' => SORT_DESC])->all();        

        return $this->render('topik-by-murid', [                
            'model' => $model,
        ]);
    }

    public function actionTopikByGuru($id)
    {        
        $model = Kuis::find()->where(['mapel_id' => $id])->andWhere(['user_id' => Yii::$app->user->identity->id])->orderBy(['kuis_id' => SORT_DESC])->all();
        $models = Kuis::find()->where(['mapel_id' => $id])->one();
        $test = $id;
        return $this->render('topik-by-guru', [                
            'model' => $model,
            'models' => $models,
            'test' => $test,

        ]);
    }

    public function actionSubmit($id)
    {
        //$model = new DetailKuis();
        $model = DetailKuis::find()->where(['detail_kuis_id' => $id])->one();    

        return $this->render('jawaban', [
            'model' => $model,
        ]);
    }    

    /**
     * Deletes an existing DetailKuis model.
     * If deletion is successful, the browser will be redirected to the 'index' page.
     * @param integer $id
     * @return mixed
     */
    public function actionDelete($id)
    {
        $this->findModel($id)->delete();

        return $this->redirect(['index']);
    }

    /**
     * Finds the DetailKuis model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param integer $id
     * @return DetailKuis the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id)
    {
        if (($model = DetailKuis::findOne($id)) !== null) {
            return $model;
        } else {
            throw new NotFoundHttpException('The requested page does not exist.');
        }
    }
}









// public function actionSoal()
//     {                
//         $models = DetailKuis::find()->all();
//         $hitung = count($models);        

//         // if ($models->load(Yii::$app->request->post())) {
//         //     if ($models->validate()) {                   
//         //         $models->save();
//         //         return $this->redirect(['view', 'id' => $models->detail_kuis_id]);
//         //     }
//         // } else {        
//         if (isset($_POST['DetailKuis']['id'])) {
//              // var_dump($_POST['DetailKuis']['id']);
//              // var_dump($_POST['DetailKuis']['pilihan']);
             
//             $id_soal = $_POST['DetailKuis']['id'];
//             $pilihan = $_POST['DetailKuis']['pilihan'];
//             $score=0;
//             $benar=0;
//             $salah=0;
//             $kosong=0;


//             for ($i=0; $i < $hitung; $i++) { 
//                 $nomor = $id_soal[$i];
//                 if (empty($pilihan[$nomor])) {
//                     $kosong++;
//                 }else{
//                     $jawaban = $pilihan[$nomor];
//                     $kuncijawaban = DetailKuis::find()->where(['detail_kuis_id' => $nomor])->one();                    
//                     $kuncijawaban->jawaban_user = $jawaban;

//                     $kuncijawaban->save();
                    
//                     if ($kuncijawaban->jawaban_benar == $jawaban) {
//                         $benar++;
//                     }else{
//                         $salah++;
//                     }
//                 }
//             }        
//             echo $benar."<br>".$salah;die();
//         }
//             return $this->render('soal', [                
//                 'models' => $models,
//             ]);
//         // }
//     }