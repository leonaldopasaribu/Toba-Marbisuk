<?php

namespace frontend\models\search;

use Yii;
use yii\base\Model;
use yii\data\ActiveDataProvider;
use frontend\models\Materi;

/**
 * MateriSearch represents the model behind the search form about `frontend\models\Materi`.
 */
class MateriSearch extends Materi
{
    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['materi_id', 'mapel_id', 'created_at', 'updated_at'], 'integer'],
            [['judul', 'deskripsi', 'file_materi'], 'safe'],
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
        $query = Materi::find();

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
            'materi_id' => $this->materi_id,
            'mapel_id' => $this->mapel_id,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ]);

        $query->andFilterWhere(['like', 'judul', $this->judul])
            ->andFilterWhere(['like', 'deskripsi', $this->deskripsi])
            ->andFilterWhere(['like', 'file_materi', $this->file_materi]);

        return $dataProvider;
    }
}
