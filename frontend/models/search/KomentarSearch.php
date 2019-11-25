<?php

namespace frontend\models\search;

use Yii;
use yii\base\Model;
use yii\data\ActiveDataProvider;
use frontend\models\Komentar;

/**
 * KomentarSearch represents the model behind the search form about `frontend\models\Komentar`.
 */
class KomentarSearch extends Komentar
{
    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            [['komentar_id', 'kuis_id'], 'integer'],
            [['komentar', 'username', 'gambar'], 'safe'],
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
        $query = Komentar::find();

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
            'komentar_id' => $this->komentar_id,
            'kuis_id' => $this->kuis_id,
        ]);

        $query->andFilterWhere(['like', 'komentar', $this->komentar])
            ->andFilterWhere(['like', 'username', $this->username])
            ->andFilterWhere(['like', 'gambar', $this->gambar]);

        return $dataProvider;
    }
}
