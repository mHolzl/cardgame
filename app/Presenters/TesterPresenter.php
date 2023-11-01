<?php

declare(strict_types=1);

namespace App\Presenters;

use Nette;

use App\Presenters\BasePresenter;
use App\Filter\CardsFilter;
use App\Model\CardsFacade;
use App\Model\GameManagerFacade;

final class TesterPresenter extends BasePresenter
{
    public function __construct(
        private GameManagerFacade $gameManagerFacade,
        private CardsFacade $cardsFacade,

    )
    {
        parent::__construct();
    }

    public function renderCardDetail(int $id): void
    {
        $filter = new CardsFilter([]);

        // nacist data 
        $result['data'] = $this->cardsFacade->get($id, $filter);
        $this->template->card = $result['data'];
        $result['data'] = $this->cardsFacade->getPrevById($id, $filter);
        $this->template->prevCard = $result['data'];
        $result['data'] = $this->cardsFacade->getNextById($id, $filter);
        $this->template->nextCard = $result['data'];
    }


    public function renderCardList(): void
    {
        //$filterPattern['landtype_id'] = 1;
        //$filterPattern['cardtype_id'] = [];

        $filter = ['filter' => $filterPattern ?? []];

        $filter = new CardsFilter($filter);
      
        // nacist data 
        $result['data'] = $this->cardsFacade->getAll($filter);
        $this->template->cardList = $result['data'];
    }
    
        
    public function renderGame(): void
    {
  
        // nacist data 
        $result['data'] = $this->gameManagerFacade->prepareGame();
        $this->template->cardList = $result['data'];
    }
}
