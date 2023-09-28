<?php

declare(strict_types=1);

namespace App\Presenters;

use Nette;

use App\Presenters\BasePresenter;
//use App\Model\GameFacade;
use App\Model\GameManagerFacade;

final class GamePresenter extends BasePresenter
{
    public function __construct(
        private GameManagerFacade $gameManagerFacade,
      //  private GameFacade $gameFacade,

    )
    {
        parent::__construct();
    }

    public function renderPrepareGame(int $id): void
    {
        // nacist data 
        $result['data'] = $this->cardsFacade->get($id);
        $this->template->card = $result['data'];
    }
    
}
