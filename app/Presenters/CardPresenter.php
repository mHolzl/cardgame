<?php

declare(strict_types=1);

namespace App\Presenters;

use Nette;

use App\Presenters\BasePresenter;
use App\Model\CardsFacade;
use App\Model\GameManagerFacade;

final class CardPresenter extends BasePresenter
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
        // nacist data 
        $result['data'] = $this->cardsFacade->get($id);
        $this->template->card = $result['data'];
    }
    
}
