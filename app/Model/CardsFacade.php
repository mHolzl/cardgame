<?php
namespace App\Model;

use App\Filter\CardsFilter;
use App\Provider\CardsProvider;
//use App\Validator\CardsValidator;
use Nette\Database\Row;
use Nette\SmartObject;
use PDOException;

final class CardsFacade
{
	use SmartObject;


	public function __construct(
		private CardsProvider $cardsProvider,
	) {
	}


	public function get(int $id): Row|null
	{
		return $this->cardsProvider->get($id);
	}

	public function getPrevById(int $id): Row|null
	{
		return $this->cardsProvider->getPrevById($id);
	}
	public function getNextById(int $id): Row|null
	{
		return $this->cardsProvider->getNextById($id);
	}




	public function getCount(CardsFilter $filter): int
	{
		return $this->cardsProvider->getCount($filter);
	}


	public function getAll(): array
	{
		return $this->cardsProvider->getAll();
	}

}