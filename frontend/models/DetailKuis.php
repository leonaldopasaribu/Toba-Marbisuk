<?php

namespace frontend\models;

use Yii;

use common\behaviors\TimestampBehavior;
use common\behaviors\BlameableBehavior;
use common\behaviors\DeleteBehavior;

/**
 * This is the model class for table "detail_kuis".
 *
 * @property integer $detail_kuis_id
 * @property integer $kuis_id
 * @property integer $no_soal
 * @property string $pertanyaan
 * @property string $jawaban_benar
 * @property string $opsi_a
 * @property string $opsi_b
 * @property string $opsi_c
 * @property string $opsi_d
 * @property string $opsi_e
 * @property string $penyelesaian_file
 * @property string $penyelesaian_video
 * @property integer $created_at
 * @property integer $updated_at
 *
 * @property Kuis $kuis
 */
class DetailKuis extends \yii\db\ActiveRecord
{

    public $jawaban;

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
        return 'detail_kuis';
    }
    public $id = array();
    public $pilihan = array();

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['created_at', 'updated_at'], 'safe'],
            [['jawaban_user', 'status'], 'integer'],
            [['pertanyaan'], 'string', 'max' => 200],
            [['created_by', 'updated_by'], 'string', 'max' => 32],
            [['jawaban_benar', 'jawaban_user','opsi_a', 'opsi_b', 'opsi_c', 'opsi_d', 'opsi_e'], 'string', 'max' => 100],
            [['kuis_id'], 'exist', 'skipOnError' => true, 'targetClass' => Kuis::className(), 'targetAttribute' => ['kuis_id' => 'kuis_id']],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'detail_kuis_id' => 'Detail Kuis ID',
            'kuis_id' => 'Kuis ID',
            'kuis_name' => 'Topik Kuis',
            'no_soal' => 'Nomor Soal',
            'pertanyaan' => 'Pertanyaan',
            'jawaban_benar' => 'Jawaban Benar',
            'opsi_a' => 'Opsi A',
            'opsi_b' => 'Opsi B',
            'opsi_c' => 'Opsi C',
            'opsi_d' => 'Opsi D',
            'opsi_e' => 'Opsi E',            
            'created_at' => 'Created At',
            'updated_at' => 'Updated At',
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
