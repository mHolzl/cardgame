<?php

declare(strict_types=1);

namespace App\Presenters;

use Nette;
use Nette\Application\UI\Presenter;
use Nette\Database\Row;
use Nette\DI\Attributes\Inject;

abstract class BasePresenter extends Nette\Application\UI\Presenter
{
    public function beforeRender()
	{
		$this->template->constImagesRoot = 'http://www.cardgames.local/images/';
        //$this->template->constImagesRoot = $_SERVER["DOCUMENT_ROOT"] . '/images/';
	}
}
