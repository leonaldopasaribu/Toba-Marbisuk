<?php

namespace backend\models;

use Yii;

/**
 * This is the model class for table "detail_kuis".
 *
 * @property integer $detail_kuis_id
 * @property integer $kuis_id
 * @property integer $status
 * @property string $pertanyaan
 * @property string $jawaban_user
 * @property string $jawaban_benar
 * @property string $opsi_a
 * @property string $opsi_b
 * @property string $opsi_c
 * @property string $opsi_d
 * @property string $opsi_e
 * @property integer $created_at
 * @property integer $updated_at
 *
 * @property Kuis $kuis
 */
class DetailKuis extends \yii\db\ActiveRecord
{
    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return 'detail_kuis';
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['kuis_id'], 'required'],
            [['kuis_id', 'status', 'created_at', 'updated_at'], 'integer'],
            [['pertanyaan'], 'string'],
            [['jawaban_user'], 'string', 'max' => 200],
            [['jawaban_benar', 'opsi_a', 'opsi_b', 'opsi_c', 'opsi_d', 'opsi_e'], 'string', 'max' => 100],
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
            'status' => 'Status',
            'pertanyaan' => 'Pertanyaan',
            'jawaban_user' => 'Jawaban User',
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
