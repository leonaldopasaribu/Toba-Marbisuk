<?php

namespace backend\models;

use Yii;

/**
 * This is the model class for table "detail_latihan".
 *
 * @property integer $latihan_id
 * @property integer $kuis_id
 * @property string $pertanyaan
 * @property string $jawaban_benar
 * @property string $opsi_a
 * @property string $opsi_b
 * @property string $opsi_c
 * @property string $opsi_d
 * @property string $opsi_e
 * @property string $file_penyelesaian
 * @property string $created_at
 * @property string $updated_at
 *
 * @property Kuis $kuis
 */
class DetailLatihan extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'detail_latihan';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['kuis_id'], 'integer'],
            [['created_at', 'updated_at'], 'safe'],
            [['pertanyaan', 'jawaban_benar', 'opsi_a', 'opsi_b', 'opsi_c', 'opsi_d', 'opsi_e'], 'string', 'max' => 200],
            [['kuis_id'], 'exist', 'skipOnError' => true, 'targetClass' => Kuis::className(), 'targetAttribute' => ['kuis_id' => 'kuis_id']],
        ];
    }

    /**
     * @inheritdoc
     */
    public function attributeLabels()
    {
        return [
            'latihan_id' => 'Latihan ID',
            'kuis_id' => 'Kuis ID',
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
