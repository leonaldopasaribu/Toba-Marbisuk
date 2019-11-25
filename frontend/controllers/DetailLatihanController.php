<?php

namespace frontend\controllers;

use Yii;
use frontend\models\DetailLatihan;
use frontend\models\search\DetailLatihanSearch;
use frontend\models\Kuis;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;
use yii\web\UploadedFile;

/**
 * DetailLatihanController implements the CRUD actions for DetailLatihan model.
 */
class DetailLatihanController extends Controller
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
     * Lists all DetailLatihan models.
     * @return mixed
     */
    public function actionIndexByTeacher($id)
    {
        $searchModel = new DetailLatihanSearch();
        $dataProvider = $searchModel->search(Yii::$app->request->queryParams);
        $models = DetailLatihan::find()->where(['kuis_id' => $id])->all();

        return $this->render('index-by-teacher', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
            'models' => $models,
            'id' => $id,
        ]);
    }

    /**
     * Lists all DetailLatihan models.
     * @return mixed
     */
    public function actionIndexByStudent($id)
    {
        $searchModel = new DetailLatihanSearch();
        $dataProvider = $searchModel->search(Yii::$app->request->queryParams);
        $models = DetailLatihan::find()->where(['kuis_id' => $id])->all();
        $kuis = Kuis::find()->where(['kuis_id' => $id])->one();

        return $this->render('index-by-student', [
            'searchModel' => $searchModel,
            'dataProvider' => $dataProvider,
            'models' => $models,
            'kuis' => $kuis,
            'id' => $id,
        ]);
    }

    /**
     * Displays a single DetailLatihan model.
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
     * Creates a new DetailLatihan model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return mixed
     */
    public function actionCreate($id)
    {
        $model = new DetailLatihan();

        if ($model->load(Yii::$app->request->post())) {  

            if ($model->validate()) {
                $model->kuis_id = $id;
                $model->save();
                return $this->redirect(['index-by-teacher', 'id' => $id]); 
            }else{
                $errors = $model->$errors;
                print_r(array_values($errors));
            }            
        } else {
            return $this->render('create', [
                'model' => $model,
                'id' => $id,
            ]);
        }
    }

    /**
     * Updates an existing DetailLatihan model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param integer $id
     * @return mixed
     */
    public function actionUpdate($id)
    {
        $model = $this->findModel($id);

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            return $this->redirect(['index-by-teacher', 'id' => $model->kuis_id]);
        } else {
            return $this->render('update', [
                'model' => $model,
            ]);
        }
    }

    /**
     * Updates an existing DetailLatihan model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param integer $id
     * @return mixed
     */
    public function actionUnggah($id)
    {
        $model = Kuis::find()->one();

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            $model->file = UploadedFile::getInstance($model, 'file');
            $model->file->saveAs('uploads/penyelesaian/' . $model->file->baseName . '.' . $model->file->extension);
            $model->file_foto = 'uploads/penyelesaian/' . $model->file->baseName . '.' . $model->file->extension;

            $model->save();
            return $this->redirect(['index-by-teacher', 'id' => $model->kuis_id]);
        } else {
            return $this->render('unggah', [
                'model' => $model,
            ]);
        }
    }

    /**
     * Updates an existing DetailLatihan model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param integer $id
     * @return mixed
     */
    public function actionVideo($id)
    {
        $model = Kuis::find()->where(['kuis_id' => $id])->one();

        if ($model->load(Yii::$app->request->post())) {  

            if ($model->validate()) {

                $model->save();
                return $this->redirect(['index-by-teacher', 'id' => $model->kuis_id]); 
            }else{
                $errors = $model->$errors;
                print_r(array_values($errors));
            }            
        } else {
            return $this->render('video', [
                'model' => $model,
            ]);
        }
    }

    /**
     * Deletes an existing DetailLatihan model.
     * If deletion is successful, the browser will be redirected to the 'index' page.
     * @param integer $id
     * @return mixed
     */
    public function actionDelete($id)
    {
        $model = DetailLatihan::find()->where(['latihan_id' => $id])->one();

        $this->findModel($id)->delete();

        return $this->redirect(['index-by-teacher', 'id' => $model->kuis_id]);
    }

    /**
     * Finds the DetailLatihan model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param integer $id
     * @return DetailLatihan the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id)
    {
        if (($model = DetailLatihan::findOne($id)) !== null) {
            return $model;
        } else {
            throw new NotFoundHttpException('The requested page does not exist.');
        }
    }
}
