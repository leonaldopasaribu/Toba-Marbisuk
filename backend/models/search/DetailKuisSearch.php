<?php

namespace backend\models\search;

use Yii;
use yii\base\Model;
use yii\data\ActiveDataProvider;
use backend\models\DetailKuis;

/**
 * DetailKuisSearch represents the model behind the search form about `backend\models\DetailKuis`.
 */
class DetailKuisSearch extends DetailKuis
{
    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['detail_kuis_id', 'kuis_id', 'status', 'created_at', 'updated_at'], 'integer'],
            [['pertanyaan', 'jawaban_user', 'jawaban_benar', 'opsi_a', 'opsi_b', 'opsi_c', 'opsi_d', 'opsi_e'], 'safe'],
        ];
    }

    /**
     * @inheritdoc
     */
    public function scenarios()
    {
        // bypass scenarios() implementation in the parent class
        return Model::scenarios();
    }

    /**
     * Creates data provider instance with search query applied
     *
     * @param array $params
     *
     * @return ActiveDataProvider
     */
    public function search($params)
    {
        $query = DetailKuis::find();

        // add conditions that should always apply here

        $dataProvider = new ActiveDataProvider([
            'query' => $query,
        ]);

        $this->load($params);

        if (!$this->validate()) {
            // uncomment the following line if you do not want to return any records when validation fails
            // $query->where('0=1');
            return $dataProvider;
        }

        // grid filtering conditions
        $query->andFilterWhere([
            'detail_kuis_id' => $this->detail_kuis_id,
            'kuis_id' => $this->kuis_id,
            'status' => $this->status,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ]);

        $query->andFilterWhere(['like', 'pertanyaan', $this->pertanyaan])
            ->andFilterWhere(['like', 'jawaban_user', $this->jawaban_user])
            ->andFilterWhere(['like', 'jawaban_benar', $this->jawaban_benar])
            ->andFilterWhere(['like', 'opsi_a', $this->opsi_a])
            ->andFilterWhere(['like', 'opsi_b', $this->opsi_b])
            ->andFilterWhere(['like', 'opsi_c', $this->opsi_c])
            ->andFilterWhere(['like', 'opsi_d', $this->opsi_d])
            ->andFilterWhere(['like', 'opsi_e', $this->opsi_e]);

        return $dataProvider;
    }
}
