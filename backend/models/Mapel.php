<?php

namespace backend\models;

use Yii;

/**
 * This is the model class for table "mapel".
 *
 * @property integer $mapel_id
 * @property integer $user_id
 * @property string $nama_mapel
 * @property string $deskripsi
 *
 * @property Kuis[] $kuis
 * @property Materi[] $materis
 */
class Mapel extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'mapel';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['user_id'], 'required'],
            [['user_id'], 'integer'],
            [['deskripsi'], 'string'],
            [['nama_mapel'], 'string', 'max' => 45],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'mapel_id' => 'Mapel ID',
            'user_id' => 'User ID',
            'nama_mapel' => 'Nama Mapel',
            'deskripsi' => 'Deskripsi',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getKuis()
    {
        return $this->hasMany(Kuis::className(), ['mapel_id' => 'mapel_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getMateris()
    {
        return $this->hasMany(Materi::className(), ['mapel_id' => 'mapel_id']);
    }
}
