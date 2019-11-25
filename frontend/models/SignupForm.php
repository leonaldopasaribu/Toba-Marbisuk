<?php
namespace frontend\models;

use yii\base\Model;
use common\models\User;

/**
 * Signup form
 */
class SignupForm extends Model
{
    public $username;
    public $email;
    public $password;    
    public $role;
    public $no_hp;
    public $kelas;


    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            ['username', 'trim'],
            ['username', 'required'],
            ['username', 'unique', 'targetClass' => '\common\models\User', 'message' => 'This username has already been taken.'],
            ['username', 'string', 'min' => 2, 'max' => 255],

            ['email', 'trim'],
            ['email', 'required'],
            ['email', 'email'],
            ['email', 'string', 'max' => 255],
            ['email', 'unique', 'targetClass' => '\common\models\User', 'message' => 'This email address has already been taken.'],

            ['password', 'required'],
            ['password', 'string', 'min' => 6],

            ['role', 'integer'],

            ['no_hp', 'string', 'max' => 255],
            ['no_hp', 'required'],

            ['kelas', 'string', 'max' => 32],
            ['kelas', 'required'],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'username' => 'Nama Pengguna',
            'password' => 'Kata Sandi',
            'no_hp' => 'Nomor Handphone',
            'kelas' => 'Kelas',
        ];
    }

    /**
     * Signs user up.
     *
     * @return User|null the saved model or null if saving fails
     */
    public function signup()
    {
         if ($this->validate()) {
        $user = new User();
        $user->username = $this->username;
        $user->email = $this->email;
        $user->setPassword($this->password);
        $user->generateAuthKey();
        $user->status = 0; 
        $user->role = 1;
        if ($user->save()) {
            return $user;
        }
        }
 
    return null; 
    }

    public function register()
    {
         if ($this->validate()) {
        $user = new User();
        $user->username = $this->username;
        $user->email = $this->email;
        $user->setPassword($this->password);
        $user->generateAuthKey();
        $user->status = 0; 
        $user->role = 2;
        if ($user->save()) {
            return $user;
        }
        }
 
    return null; 
    }
}
