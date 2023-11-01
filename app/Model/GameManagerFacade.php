<?php

declare(strict_types=1);

namespace App\Model;

use Nette\SmartObject;
use App\Provider\CardsProvider;
use App\Filter\CardsFilter;


class GameManagerFacade
{
    public function __construct(
		private CardsProvider $cardsProvider,
	) {
	}




    public function prepareCardDeck()
    {
        return $x + $y;
    }

    public function prepareSeasonsDeck()
    {
        return $x + $y;
    }

    
    public function preparePlayersLands()
    {
        return $x + $y;
    }

    public function preparePlayersHands()
    {
        
        return $x + $y;
    }

    public function prepareGame()
    {
        $filterPattern['landtype_id'] = 2;
        //$filterPattern['cardtype_id'] = [2];

        $filter = ['filter' => $filterPattern ?? []];

        $filter = new CardsFilter($filter);

        $result = $this->cardsProvider->getAll($filter);


        return $result;
    }

}
