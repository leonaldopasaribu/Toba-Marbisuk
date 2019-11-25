<?php

namespace frontend\models;

use Yii;

use common\behaviors\TimestampBehavior;
use common\behaviors\BlameableBehavior;
use common\behaviors\DeleteBehavior;

/**
 * This is the model class for table "komentar".
 *
 * @property integer $komentar_id
 * @property integer $kuis_id
 * @property string $komentar
 * @property string $username
 * @property string $gambar
 *
 * @property Kuis $kuis
 */
class Komentar extends \yii\db\ActiveRecord
{

    public function behaviors(){
        return [
            'timestamp' => [
                'class' => TimestampBehavior::className(),
            ],
            'blameable' => [
                'class' => BlameableBehavior::className(),
            ],
            'delete' => [
                'class' => DeleteBehavior::className(),
            ]
        ];
    }

    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'komentar';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['kuis_id'], 'integer'],
            [['komentar', 'username', 'gambar'], 'string', 'max' => 200],
            [['kuis_id'], 'exist', 'skipOnError' => true, 'targetClass' => Kuis::className(), 'targetAttribute' => ['kuis_id' => 'kuis_id']],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'komentar_id' => 'Komentar ID',
            'kuis_id' => 'Kuis ID',
            'komentar' => 'Komentar',
            'username' => 'Username',
            'gambar' => 'Gambar',
        ];
    }

    /**
     * @return \yii\db\ActiveQuery
     */
    public function getKuis()
    {
        return $this->hasOne(Kuis::className(), ['kuis_id' => 'kuis_id']);
    }
}
