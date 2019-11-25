<?php
namespace frontend\controllers;

use Yii;
use yii\base\InvalidParamException;
use yii\web\BadRequestHttpException;
use yii\web\Controller;
use yii\filters\VerbFilter;
use yii\filters\AccessControl;
use common\models\LoginForm;
use frontend\models\PasswordResetRequestForm;
use frontend\models\ResetPasswordForm;
use frontend\models\SignupForm;
use frontend\models\ContactForm;
use frontend\models\User;
use yii\web\UploadedFile;

/**
 * Site controller
 */
class SiteController extends Controller
{
    /**
     * @inheritdoc
     */
    public function behaviors()
    {
        return [
            'access' => [
                'class' => AccessControl::className(),
                'only' => ['logout', 'signup', 'about', 'contact'],
                'rules' => [
                    [
                        'actions' => ['signup'],
                        'allow' => true,
                        'roles' => ['?'],
                    ],
                    [
                        'actions' => ['logout'],
                        'allow' => true,
                        'roles' => ['@'],
                    ],
                    [
                        'actions' => ['about', 'contact'],
                        'allow' => true,
                        'roles' => ['@'],
                        'matchCallback' => function($rule, $action){
                            return User::isUserAdmin(Yii::$app->user->identity->username);
                        }
                    ],
                ],
            ],
            'verbs' => [
                'class' => VerbFilter::className(),
                'actions' => [
                    'logout' => ['post'],
                ],
            ],
        ];
    }

    /**
     * @inheritdoc
     */
    public function actions()
    {
        return [
            'error' => [
                'class' => 'yii\web\ErrorAction',
            ],
            'captcha' => [
                'class' => 'yii\captcha\CaptchaAction',
                'fixedVerifyCode' => YII_ENV_TEST ? 'testme' : null,
            ],
        ];
    }

    /**
     * Displays homepage.
     *
     * @return mixed
     */
    public function actionIndex()
    {
        return $this->render('index');
    }

    /**
     * Logs in a user.
     *
     * @return mixed
     */
    public function actionLogin()
    {
        if (!Yii::$app->user->isGuest) {
            return $this->goHome();
        }

        $model = new LoginForm();
        if ($model->load(Yii::$app->request->post()) && $model->login()) {
            return $this->goBack();
        } else {
            return $this->render('login', [
                'model' => $model,
            ]);
        }
    }

    /**
     * Logs in a user.
     *
     * @return mixed
     */
    public function actionLoginTeacher()
    {
        if (!Yii::$app->user->isGuest) {
            return $this->goHome();
        }

        $model = new LoginForm();
        if ($model->load(Yii::$app->request->post()) && $model->loginAdmin()) {
            return $this->goBack();
        } else {
            return $this->render('login-teacher', [
                'model' => $model,
            ]);
        }
    }

    /**
     * Displays profil page.
     *
     * @return mixed
     */
    public function actionProfilSiswa($id)
    {   
        $userOn = Yii::$app->user->identity->id;
        $user = User::find()->where(['id' => $userOn])->one();

        $model = $this->findModel($id);

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            $model->file = UploadedFile::getInstance($model, 'file');
            $model->file->saveAs('img/' . $model->file->baseName . '.' . $model->file->extension);
            $model->file_foto = 'img/' . $model->file->baseName . '.' . $model->file->extension;

            $model->save();
            return $this->redirect(['profil-siswa', 'id' => $user->id]);
        } else {
            return $this->render('profil-siswa', [
                'model' => $model,
                'user' => $user,
            ]);
        }
    }

    /**
     * Displays profil page.
     *
     * @return mixed
     */
    public function actionProfilGuru($id)
    {   
        $userOn = Yii::$app->user->identity->id;
        $user = User::find()->where(['id' => $userOn])->one();

        $model = $this->findModel($id);

        if ($model->load(Yii::$app->request->post()) && $model->save()) {
            $model->file = UploadedFile::getInstance($model, 'file');
            $model->file->saveAs('img/' . $model->file->baseName . '.' . $model->file->extension);
            $model->file_foto = 'img/' . $model->file->baseName . '.' . $model->file->extension;

            $model->save();
            return $this->redirect(['profil-guru', 'id' => $user->id]);
        } else {
            return $this->render('profil-guru', [
                'model' => $model,
                'user' => $user,
            ]);
        }
    }

    /**
     * Logs out the current user.
     *
     * @return mixed
     */
    public function actionLogout()
    {
        Yii::$app->user->logout();

        return $this->goHome();
    }

    /**
     * Displays contact page.
     *
     * @return mixed
     */
    public function actionContact()
    {
        $model = new ContactForm();
        if ($model->load(Yii::$app->request->post()) && $model->validate()) {
            if ($model->sendEmail(Yii::$app->params['adminEmail'])) {
                Yii::$app->session->setFlash('success', 'Thank you for contacting us. We will respond to you as soon as possible.');
            } else {
                Yii::$app->session->setFlash('error', 'There was an error sending your message.');
            }

            return $this->refresh();
        } else {
            return $this->render('contact', [
                'model' => $model,
            ]);
        }
    }

    /**
     * Displays about page.
     *
     * @return mixed
     */
    public function actionTentang()
    {
        return $this->render('tentang');
    }

    /**
     * Signs user up.
     *
     * @return mixed
     */
    public function actionSignup()
    {
        $model = new SignupForm();
        if ($model->load(Yii::$app->request->post())) {
            if ($user = $model->signup()) {
                if (Yii::$app->getUser()->login($user)) {
                    return $this->goHome();
                }
            }
        }

        return $this->render('signup', [
            'model' => $model,
        ]);
    }

    /**
     * Signs user up.
     *
     * @return mixed
     */
    public function actionSignupTeacher()
    {
        $model = new SignupForm();
        if ($model->load(Yii::$app->request->post())) {
        if ($user = $model->signup()) {
        $email = \Yii::$app->mailer->compose()
        ->setTo($user->email)
        ->setFrom([\Yii::$app->params['supportEmail'] => \Yii::$app->name . ' robot'])
        ->setSubject('Signup Confirmation')
        ->setTextBody("
            Click this link ".\yii\helpers\Html::a('confirm',
            Yii::$app->urlManager->createAbsoluteUrl(
            ['site/confirm','id'=>$user->id]))
            )
        ->send();
        if($email){
        Yii::$app->getSession()->setFlash('success','Check Your email!');
        }
        else{
        Yii::$app->getSession()->setFlash('warning','Failed, contact Admin!');
        }
        return $this->goHome();
        }
        }
         
        return $this->render('signup-teacher', [
        'model' => $model,
        ]);
    }

    /**
     * Signs user up.
     *
     * @return mixed
     */
    public function actionSignupStudent()
    {
        $model = new SignupForm();
        if ($model->load(Yii::$app->request->post())) {
        if ($user = $model->signup()) {
        $email = \Yii::$app->mailer->compose()
        ->setTo($user->email)
        ->setFrom([\Yii::$app->params['supportEmail'] => \Yii::$app->name . ' robot'])
        ->setSubject('Signup Confirmation')
        ->setTextBody("
            Click this link ".\yii\helpers\Html::a('confirm',
            Yii::$app->urlManager->createAbsoluteUrl(
            ['site/confirm','id'=>$user->id]))
            )
        ->send();
        if($email){
        Yii::$app->getSession()->setFlash('success','Check Your email!');
        }
        else{
        Yii::$app->getSession()->setFlash('warning','Failed, contact Admin!');
        }
        return $this->goHome();
        }
        }
         
        return $this->render('signup-student', [
        'model' => $model,
        ]);

    }

    /**
     * Requests password reset.
     *
     * @return mixed
     */
    public function actionRequestPasswordReset()
    {
        $model = new PasswordResetRequestForm();
        if ($model->load(Yii::$app->request->post()) && $model->validate()) {
            if ($model->sendEmail()) {
                Yii::$app->session->setFlash('success', 'Check your email for further instructions.');

                return $this->goHome();
            } else {
                Yii::$app->session->setFlash('error', 'Sorry, we are unable to reset password for the provided email address.');
            }
        }

        return $this->render('requestPasswordResetToken', [
            'model' => $model,
        ]);
    }

    /**
     * Resets password.
     *
     * @param string $token
     * @return mixed
     * @throws BadRequestHttpException
     */
    public function actionResetPassword($token)
    {
        try {
            $model = new ResetPasswordForm($token);
        } catch (InvalidParamException $e) {
            throw new BadRequestHttpException($e->getMessage());
        }

        if ($model->load(Yii::$app->request->post()) && $model->validate() && $model->resetPassword()) {
            Yii::$app->session->setFlash('success', 'New password saved.');

            return $this->goHome();
        }

        return $this->render('resetPassword', [
            'model' => $model,
        ]);
    }

    public function actionConfirm($id)
    {
        $user = \common\models\User::find()->where([
        'id'=>$id,
        'status'=>0,
        ])->one();
        if(!empty($user)){
        $user->status=10;
        $user->save();
        Yii::$app->getSession()->setFlash('success','Success!');
        }
        else{
        Yii::$app->getSession()->setFlash('warning','Failed!');
        }
        return $this->goHome();
    }

    /**
     * Finds the Mapel model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param integer $id
     * @return Mapel the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id)
    {
        if (($model = User::findOne($id)) !== null) {
            return $model;
        } else {
            throw new NotFoundHttpException('The requested page does not exist.');
        }
    }
}
