<?php

namespace backend\models\search;

use Yii;
use yii\base\Model;
use yii\data\ActiveDataProvider;
use backend\models\Kuis;

/**
 * KuisSearch represents the model behind the search form about `backend\models\Kuis`.
 */
class KuisSearch extends Kuis
{
    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['kuis_id', 'mapel_id', 'user_id', 'status', 'score'], 'integer'],
            [['kuis_name', 'sandi_kuis', 'waktu_kuis', 'deskripsi', 'penyelesaian_file', 'penyelesaian_video', 'materi_file', 'materi_video', 'created_at', 'created_by', 'updated_at', 'updated_by'], 'safe'],
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
        $query = Kuis::find();

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
            'kuis_id' => $this->kuis_id,
            'mapel_id' => $this->mapel_id,
            'user_id' => $this->user_id,
            'status' => $this->status,
            'waktu_kuis' => $this->waktu_kuis,
            'score' => $this->score,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
            'updated_by' => $this->updated_by,
        ]);

        $query->andFilterWhere(['like', 'kuis_name', $this->kuis_name])
            ->andFilterWhere(['like', 'sandi_kuis', $this->sandi_kuis])
            ->andFilterWhere(['like', 'deskripsi', $this->deskripsi])
            ->andFilterWhere(['like', 'penyelesaian_file', $this->penyelesaian_file])
            ->andFilterWhere(['like', 'penyelesaian_video', $this->penyelesaian_video])
            ->andFilterWhere(['like', 'materi_file', $this->materi_file])
            ->andFilterWhere(['like', 'materi_video', $this->materi_video])
            ->andFilterWhere(['like', 'created_by', $this->created_by]);

        return $dataProvider;
    }
}
