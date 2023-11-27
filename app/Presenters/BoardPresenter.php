<?php

declare(strict_types=1);

namespace App\Presenters;

use Nette;

use App\Presenters\BasePresenter;
//use App\Filter\CardsFilter;
use App\Model\CardsFacade;
//use App\Model\GameManagerFacade;

final class BoardPresenter extends BasePresenter
{
    public function __construct(
      //private GameManagerFacade $gameManagerFacade,
      private CardsFacade $cardsFacade,
    )
    {
        parent::__construct();
    }

    public function renderDefault(): void
    {
        //$filter = new CardsFilter([]);

        // nacist data 
        //$result['data'] = $this->cardsFacade->get($id);
        //$this->template->card = $result['data'];
        $id=32;
        $this->template->seasons["seasonsActiveCard"] = $this->cardsFacade->get($id);
        $this->template->seasons["seasonsTotals"] = 5;
        $this->template->seasons["seasonsActive"] = 2;

        $this->template->playerHand[] = $this->cardsFacade->get(45);
        $this->template->playerHand[] = $this->cardsFacade->get(48);
        $this->template->playerHand[] = $this->cardsFacade->get(73);
        $this->template->playerHand[] = $this->cardsFacade->get(68);
        $this->template->playerHand[] = $this->cardsFacade->get(85);
        $this->template->playerHand[] = $this->cardsFacade->get(94);

        $this->template->placedLands[] = $this->cardsFacade->get(2);
        $this->template->placedLands[] = $this->cardsFacade->get(7);
        $this->template->placedLands[] = $this->cardsFacade->get(16);
        $this->template->placedLands[] = $this->cardsFacade->get(4);
        $this->template->placedLands[] = $this->cardsFacade->get(21);






    }
    
}
