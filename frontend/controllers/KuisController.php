<?php

namespace frontend\controllers;

use Yii;
use frontend\models\Kuis;
use frontend\models\Komentar;
use frontend\models\search\KuisSearch;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;
use frontend\models\User;
use frontend\models\Mapel;
use yii\web\UploadedFile;

/**
 * KuisController implements the CRUD actions for Kuis model.
 */
class KuisController extends Controller
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
     * Lists all Kuis models.
     * @return mixed
     */
    public function actionIndex()
    {
        $searchModel = new KuisSearch();
        $dataProvider = $searchModel->search(Yii::$app->request->queryParams);

        return $this->render('index', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
        ]);
    }

    /**
     * Displays a single Kuis model.
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
     * Creates a new Kuis model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return mixed
     */
    public function actionCreate($id)
    {                
        $model = new Kuis();    
        $mapel = Mapel::find()->where(['mapel_id' => $id])->one(); 
        $user = User::find()->Where(['id' => Yii::$app->user->identity->id])->one();

        if ($model->load(Yii::$app->request->post())) {

                $model->file = UploadedFile::getInstance($model, 'file');
                $model->file->saveAs('uploads/penyelesaian/' . $model->file->baseName . '.' . $model->file->extension);
                $model->materi_file = 'uploads/penyelesaian/' . $model->file->baseName . '.' . $model->file->extension;

            
            $model->mapel_id = $mapel['mapel_id'];
            $model->user_id = $user['id'];

            $model->save();
            return $this->redirect(['/materi/topik-by-guru', 'id' => $model->mapel_id]);
        } else {
            return $this->render('create', [
                'model' => $model,
            ]);
        }
    }

    public function actionUpdatePenyel($id)
    {
        $model = $this->findModel($id);        

        if ($model->load(Yii::$app->request->post())) {

            $model->file = UploadedFile::getInstance($model, 'penyel');
            $model->file->saveAs('uploads/penyelesaian/' . $model->file->baseName . '.' . $model->file->extension);
            $model->penyelesaian_file = 'uploads/penyelesaian/' . $model->file->baseName . '.' . $model->file->extension;

            $model->save();
            return $this->redirect(['/detail-latihan/index-by-teacher', 'id' => $model->kuis_id]);
        } else {
            return $this->render('unggah', [
                'model' => $model,
            ]);
        }
    }

    public function actionIndexByStudent()
    {
        $model = Mapel::find()->all();

        return $this->render('index-by-student', [                
            'model' => $model,
        ]);
    } 

    public function actionLatihanByTeacher()
    {
        $model = new Kuis();
        $models = Mapel::find()->all();

        return $this->render('latihan-by-teacher', [
            'model' => $model,
            'models' => $models,
        ]);
    } 

    public function actionLatihanByStudent()
    {
        $model = new Kuis();
        $models = Mapel::find()->all();

        return $this->render('latihan-by-student', [
            'model' => $model,
            'models' => $models,            
        ]);
    } 

    public function actionGetKuis($id)
    {
        $model = Kuis::find()->where(['mapel_id' => $id])->all();        

        //$kab = KabupatenKota::find()->where('deleted!=1')->andWhere(['provinsi_id' => $provinsi_id])->orderBy(['name' => SORT_ASC])->All();        
        echo "<option value =''>Pilih Kuis</option>";
        if(count($model)>0){
            foreach($model as $r){
                echo "<option value='$r->kuis_id'>$r->kuis_name</option>";
            }
        }
        else{
            echo "";
        }
    }

    public function actionIndexByTeacher()
    {
        $model = Mapel::find()->all();

        return $this->render('index-by-teacher', [                
            'model' => $model,
        ]);
    }   

    /**
     * Updates an existing Kuis model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param integer $id
     * @return mixed
     */
    public function actionUpdate($id)
    {
        $model = $this->findModel($id);        

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            return $this->redirect(['/materi/topik-by-guru', 'id' => $model->mapel_id]);
        } else {
            return $this->render('update', [
                'model' => $model,
            ]);
        }
    }


    public function actionUpdateTanggal($id)
    {
        $model = $this->findModel($id);        

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            return $this->redirect(['/detail-kuis/soal-teacher', 'id' => $model->kuis_id]);
        } else {
            return $this->render('update', [
                'model' => $model,
            ]);
        }
    }

    public function actionDownloadTeacher($id)
    {
        $komentar = Komentar::find()->where(['kuis_id' => $id])->orderBy(['komentar_id' => SORT_DESC])->all(); 

        $models = new Komentar();      


        if(isset($_POST['Komentar']['komentar'])) {
            $models->kuis_id = $id;
            $models->komentar = $_POST['Komentar']['komentar'];
            $models->username = Yii::$app->user->identity->nama_lengkap;
            $models->gambar = Yii::$app->user->identity->file_foto;
            $models->save();
            return $this->redirect(['/kuis/download-teacher', 'id' => $id]);
        } else {        
            return $this->render('download-teacher', [
                'model' => $this->findModel($id),
                'models' => $models,
                'komentar' => $komentar,
            ]);
        }
    }

    public function actionDownloadKuis($id){
        $model = $this->findModel($id);
        $file = $model->materi_file;
        $path = Yii::getAlias('@webroot').'/'.$file;
        if(file_exists($path)){
            Yii::$app->response->sendFile($path);
        }else{
            $this->render('download404');
        }
    }

    public function actionDownloadPenyelesaian($id){
        $model = $this->findModel($id);
        $file = $model->penyelesaian_file;
        $path = Yii::getAlias('@webroot').'/'.$file;
        if(file_exists($path)){
            Yii::$app->response->sendFile($path);
        }else{
            $this->render('download404');
        }
    }



    /**
     * Deletes an existing Kuis model.
     * If deletion is successful, the browser will be redirected to the 'index' page.
     * @param integer $id
     * @return mixed
     */
    public function actionDelete($id)
    {
        $this->findModel($id)->delete();

        $kuis = Kuis::find()->one();

        return $this->redirect(['/materi/topik-by-guru', 'id' => $kuis->mapel_id]);
    }

    /**
     * Finds the Kuis model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param integer $id
     * @return Kuis the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id)
    {
        if (($model = Kuis::findOne($id)) !== null) {
            return $model;
        } else {
            throw new NotFoundHttpException('The requested page does not exist.');
        }
    }
}
