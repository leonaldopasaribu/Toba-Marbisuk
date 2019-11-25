<?php

namespace backend\models\search;

use Yii;
use yii\base\Model;
use yii\data\ActiveDataProvider;
use backend\models\Mapel;

/**
 * MapelSearch represents the model behind the search form about `backend\models\Mapel`.
 */
class MapelSearch extends Mapel
{
    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['mapel_id', 'user_id'], 'integer'],
            [['nama_mapel', 'deskripsi'], 'safe'],
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
        $query = Mapel::find();

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
            'mapel_id' => $this->mapel_id,
            'user_id' => $this->user_id,
        ]);

        $query->andFilterWhere(['like', 'nama_mapel', $this->nama_mapel])
            ->andFilterWhere(['like', 'deskripsi', $this->deskripsi]);

        return $dataProvider;
    }
}
