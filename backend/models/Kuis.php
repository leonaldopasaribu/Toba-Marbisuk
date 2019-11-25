<?php

namespace backend\models;

use Yii;

/**
 * This is the model class for table "kuis".
 *
 * @property integer $kuis_id
 * @property integer $mapel_id
 * @property integer $user_id
 * @property string $kuis_name
 * @property integer $status
 * @property string $sandi_kuis
 * @property string $waktu_kuis
 * @property integer $score
 * @property string $deskripsi
 * @property string $penyelesaian_file
 * @property string $penyelesaian_video
 * @property string $materi_file
 * @property string $materi_video
 * @property string $created_at
 * @property string $created_by
 * @property string $updated_at
 * @property string $updated_by
 *
 * @property DetailKuis[] $detailKuis
 * @property DetailLatihan[] $detailLatihans
 * @property Mapel $mapel
 * @property User $user
 */
class Kuis extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'kuis';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['mapel_id', 'user_id', 'kuis_name'], 'required'],
            [['mapel_id', 'user_id', 'status', 'score'], 'integer'],
            [['waktu_kuis', 'created_at', 'updated_at', 'updated_by'], 'safe'],
            [['deskripsi'], 'string'],
            [['kuis_name', 'sandi_kuis', 'materi_file', 'materi_video'], 'string', 'max' => 200],
            [['penyelesaian_file', 'penyelesaian_video'], 'string', 'max' => 100],
            [['created_by'], 'string', 'max' => 32],
            [['mapel_id'], 'exist', 'skipOnError' => true, 'targetClass' => Mapel::className(), 'targetAttribute' => ['mapel_id' => 'mapel_id']],
            [['user_id'], 'exist', 'skipOnError' => true, 'targetClass' => User::className(), 'targetAttribute' => ['user_id' => 'id']],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'kuis_id' => 'Kuis ID',
            'mapel_id' => 'Mapel ID',
            'user_id' => 'User ID',
            'kuis_name' => 'Kuis Name',
            'status' => 'Status',
            'sandi_kuis' => 'Sandi Kuis',
            'waktu_kuis' => 'Waktu Kuis',
            'score' => 'Score',
            'deskripsi' => 'Deskripsi',
            'penyelesaian_file' => 'Penyelesaian File',
            'penyelesaian_video' => 'Penyelesaian Video',
            'materi_file' => 'Materi File',
            'materi_video' => 'Materi Video',
            'created_at' => 'Created At',
            'created_by' => 'Created By',
            'updated_at' => 'Updated At',
            'updated_by' => 'Updated By',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getDetailKuis()
    {
        return $this->hasMany(DetailKuis::className(), ['kuis_id' => 'kuis_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getDetailLatihans()
    {
        return $this->hasMany(DetailLatihan::className(), ['kuis_id' => 'kuis_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getMapel()
    {
        return $this->hasOne(Mapel::className(), ['mapel_id' => 'mapel_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getUser()
    {
        return $this->hasOne(User::className(), ['id' => 'user_id']);
    }
}
