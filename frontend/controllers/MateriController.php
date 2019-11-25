<?php

namespace frontend\controllers;

use Yii;
use frontend\models\Materi;
use frontend\models\search\MateriSearch;
use frontend\models\Kuis;
use frontend\models\search\KuisSearch;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;
use frontend\models\Mapel;
use yii\web\UploadedFile;

/**
 * MateriController implements the CRUD actions for Materi model.
 */
class MateriController extends Controller
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
     * Lists all Materi models.
     * @return mixed
     */
   public function actionIndexByTeacher()
    {
        $model = Mapel::find()->all();

        return $this->render('index-by-teacher', [                
            'model' => $model,
        ]);
    }

    public function actionIndexByStudent()
    {
        $model = Mapel::find()->all();

        return $this->render('index-by-student', [                
            'model' => $model,
        ]);
    }    

     public function actionIndex()
    {
        $searchModel = new MateriSearch();
        $dataProvider = $searchModel->search(Yii::$app->request->queryParams);

        return $this->render('index', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
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

    public function actionTopikByMurid($id)
    {        
        $model = Kuis::find()->where(['mapel_id' => $id])->all();
        $models = Kuis::find()->where(['mapel_id' => $id])->one();
        $test = $id;
        return $this->render('topik-by-murid', [                
            'model' => $model,
            'models' => $models,
            'test' => $test,

        ]);
    }

    /**
     * Displays a single Materi model.
     * @param integer $id
     * @return mixed
     */
    public function actionView($id)
    {
        return $this->render('view', [
            'model' => $this->findModel($id),
        ]);
    }

    public function actionViewByGuru($id)
    {
        return $this->render('view-by-guru', [
            'model' => $this->findModel($id),
        ]);
    }

    public function actionViewByMurid($id)
    {
        return $this->render('view-by-murid', [
            'model' => $this->findModel($id),
        ]);
    }

    /**
     * Creates a new Materi model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return mixed
     */
    public function actionCreate($id)
    {
        $model = new Materi();
        $mapel = Mapel::find()->where(['mapel_id' => $id])->one();
        if ($model->load(Yii::$app->request->post())) {
                $model->file = UploadedFile::getInstance($model, 'file');

                $model->file->saveAs('uploads/' . $model->file->baseName . '.' . $model->file->extension);
                $model->file_materi = 'uploads/' . $model->file->baseName . '.' . $model->file->extension;

                $model->mapel_id = $mapel['mapel_id'];
                $model->save();
                
                return $this->redirect(['topik-by-guru', 'id' => $model->mapel_id]);
            
        } else {
            return $this->render('create', [
                'model' => $model,
            ]);
        }
    }

    /**
     * Updates an existing Materi model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param integer $id
     * @return mixed
     */
    public function actionUpdate($id)
    {
        $model = $this->findModel($id);

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            return $this->redirect(['view', 'id' => $model->materi_id]);
        } else {
            return $this->render('update', [
                'model' => $model,
            ]);
        }
    }

    /**
     * Deletes an existing Materi model.
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
     * Finds the Materi model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param integer $id
     * @return Materi the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id)
    {
        if (($model = Materi::findOne($id)) !== null) {
            return $model;
        } else {
            throw new NotFoundHttpException('The requested page does not exist.');
        }
    }

    public function actionDownload($id){        
        $model = $this->findModel($id);
        $file = $model->file_materi;
        $path = Yii::getAlias('@webroot').'/'.$file;
        if(file_exists($path)){
            Yii::$app->response->sendFile($path);
        }else{
            $this->render('download404');
        }
    }
}
