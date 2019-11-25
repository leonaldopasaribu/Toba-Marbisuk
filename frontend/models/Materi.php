<?php

namespace frontend\models;

use Yii;

/**
 * This is the model class for table "materi".
 *
 * @property integer $materi_id
 * @property integer $mapel_id
 * @property string $judul
 * @property string $deskripsi
 * @property string $file_materi
 * @property integer $created_at
 * @property integer $updated_at
 *
 * @property Mapel $mapel
 */
class Materi extends \yii\db\ActiveRecord
{
    public $file;
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'materi';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['mapel_id', 'judul', 'file_materi'], 'required'],
            [['mapel_id', 'created_at', 'updated_at'], 'integer'],
            [['judul', 'file_materi'], 'string', 'max' => 100],
            [['deskripsi'], 'string', 'max' => 300],
            [['file'],'file'],
            [['mapel_id'], 'exist', 'skipOnError' => true, 'targetClass' => Mapel::className(), 'targetAttribute' => ['mapel_id' => 'mapel_id']],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'materi_id' => 'Materi ID',
            'mapel_id' => 'Mapel ID',
            'judul' => 'Judul',
            'deskripsi' => 'Deskripsi',
            'file_materi' => 'File Materi',
            'created_at' => 'Created At',
            'updated_at' => 'Updated At',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getMapel()
    {
        return $this->hasOne(Mapel::className(), ['mapel_id' => 'mapel_id']);
    }
}
