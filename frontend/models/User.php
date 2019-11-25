<?php

namespace frontend\models;

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
 * @property string $kelas
 * @property string $bidang
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
    public $file;
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
            [['username', 'auth_key', 'password_hash', 'nama_lengkap', 'email', 'no_hp', 'created_at', 'updated_at'], 'required'],
            [['status_aktif', 'status', 'role'], 'integer'],
            [['created_at', 'updated_at'], 'safe'],
            [['username', 'password_hash', 'password_reset_token', 'email', 'no_hp'], 'string', 'max' => 255],
            [['auth_key'], 'string', 'max' => 32],
            [['nama_lengkap'], 'string', 'max' => 20],
            [['file_foto'], 'string', 'max' => 30],
            [['nama_sekolah'], 'string', 'max' => 200],
            [['kelas'], 'string', 'max' => 32],
            [['bidang'], 'string', 'max' => 32],
            [['username'], 'unique'],
            [['email'], 'unique'],
            [['file'], 'file'],
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
            'kelas' => 'Kelas',
            'bidang' => 'Bidang Mata Pelajaran',
            'status_aktif' => 'Status Aktif',
            'status' => 'Status',
            'role' => 'Role',
            'no_hp' => 'Nomor Handphone',
            'created_at' => 'Created At',
            'updated_at' => 'Updated At',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getKuis()
    {
        return $this->hasMany(Kuis::className(), ['user_id' => 'id']);
    }
}
