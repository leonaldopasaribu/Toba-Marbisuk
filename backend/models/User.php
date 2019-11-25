<?php

namespace backend\models;

use Yii;

/**
 * This is the model class for table "user".
 *
 * @property integer $id
 * @property string $username
 * @property string $auth_key
 * @property string $password_hash
 * @property string $password_reset_token
 * @property string $nama_lengkap
 * @property string $file_foto
 * @property string $nama_sekolah
 * @property string $email
 * @property integer $status_aktif
 * @property integer $status
 * @property integer $role
 * @property string $no_hp
 * @property string $created_at
 * @property string $updated_at
 *
 * @property Kuis[] $kuis
 */
class User extends \yii\db\ActiveRecord
{
    public $password;
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'user';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['username', 'auth_key', 'password_hash', 'nama_lengkap', 'email', 'no_hp', 'created_at', 'updated_at'], 'safe'],
            [['status_aktif', 'status', 'role'], 'integer'],
            [['created_at', 'updated_at'], 'safe'],
            [['username', 'password_hash', 'password_reset_token', 'email', 'no_hp'], 'string', 'max' => 255],
            [['auth_key'], 'string', 'max' => 32],
            [['password'], 'string', 'min' => 6],
            [['nama_lengkap'], 'string', 'max' => 20],
            [['file_foto'], 'string', 'max' => 30],
            [['nama_sekolah'], 'string', 'max' => 200],
            [['username'], 'unique'],
            [['email'], 'unique'],
            [['password_reset_token'], 'unique'],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'username' => 'Username',
            'auth_key' => 'Auth Key',
            'password_hash' => 'Password Hash',
            'password_reset_token' => 'Password Reset Token',
            'nama_lengkap' => 'Nama Lengkap',
            'file_foto' => 'File Foto',
            'nama_sekolah' => 'Nama Sekolah',
            'email' => 'Email',
            'status_aktif' => 'Status Aktif',
            'status' => 'Status',
            'role' => 'Role',
            'no_hp' => 'No Hp',
            'created_at' => 'Created At',
            'updated_at' => 'Updated At',
        ];
    }
     /**
     * Generates password hash from password and sets it to the model
     *
     * @param string $password
     */
    public function setPassword($password)
    {
        $this->password_hash = Yii::$app->security->generatePasswordHash($password);
    }

    /**
     * Generates "remember me" authentication key
     */
    public function generateAuthKey()
    {
        $this->auth_key = Yii::$app->security->generateRandomString();
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getKuis()
    {
        return $this->hasMany(Kuis::className(), ['user_id' => 'id']);
    }
}
