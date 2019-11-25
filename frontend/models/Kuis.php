<?php

namespace frontend\models;

use Yii;

use common\behaviors\TimestampBehavior;
use common\behaviors\BlameableBehavior;

/**
 * This is the model class for table "kuis".
 *
 * @property integer $kuis_id
 * @property integer $user_id
 * @property string $kuis_name
 * @property integer $created_at
 * @property integer $updated_at
 *
 * @property DetailKuis[] $detailKuis
 * @property User $user
 */
class Kuis extends \yii\db\ActiveRecord
{
    public $file;
    public $penyel;
    public $pass;

    /**
     * behaviour to add created_at and updatet_at field with current datetime (timestamp)
     * and created_by and updated_by field with current user id (blameable)
     */
    public function behaviors(){
        return [
            'timestamp' => [
                'class' => TimestampBehavior::className(),
            ],
            'blameable' => [
                'class' => BlameableBehavior::className(),
            ],
        ];
    }

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
            [['deskripsi','kuis_name', 'status', 'waktu_kuis', 'sandi_kuis', 'created_at', 'updated_at'], 'safe'],
            [['mapel_id'], 'integer'],
            [['kuis_name','penyelesaian_file','penyelesaian_video', 'materi_file', 'materi_video'], 'string', 'max' => 200],
            [['file'],'file'],
            [['penyel'],'file'],
            [['created_by', 'updated_by'], 'string', 'max' => 32],
            [['mapel_id'], 'exist', 'skipOnError' => true, 'targetClass' => Mapel::className(), 'targetAttribute' => ['mapel_id' => 'mapel_id']],
            [['kuis_name'], 'string', 'max' => 200],            
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'kuis_id' => 'Kuis ID',
            'user_id' => 'User ID',
            'kuis_name' => 'Nama Topik',
            'created_at' => 'Created At',
            'updated_at' => 'Updated At',
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
    public function getUser()
    {
        return $this->hasOne(User::className(), ['id' => 'user_id']);
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getMapel()
    {
        return $this->hasOne(Mapel::className(), ['mapel_id' => 'mapel_id']);
    }
}
