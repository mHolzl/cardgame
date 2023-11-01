<?php
declare(strict_types=1);

namespace App\Provider;

use App\Entity\CardsEntity;
use App\Filter\CardsFilter;
use Nette\Database\Row;

final class CardsProvider extends BaseProvider
{
	/**
	 * Vrati jednu kartu podle zadaneho ID.
	 *
	 * @param int $id
	 * @return Row|null
	 */
	public function get(int $id): Row|null
	{
		$sql = "
			SELECT c.*, ct.parent_id, ct.name as cardtype_name, IFNULL((SELECT name FROM cardtype AS ct2 WHERE  ct2.id = ct.parent_id), ct.name) parent_cardtype_name
			FROM cards AS c
			LEFT JOIN cardtype ct ON c.cardtype_id = ct.id
			WHERE c.id=?";
		return $this->connection->fetch($sql, $id);
	}

	/**
	 * Vrati předchozí kartu na základě ID aktuální karty
	 *
	 * @param int $id
	 * @return Row|null
	 */
	public function getPrevById(int $id, CardsFilter $filter): Row|null
	{
		$sql = "
			SELECT c.*
			FROM cards AS c
			WHERE id = (SELECT max(id) from `cards` WHERE id < ?); 
			";
		return $this->connection->fetch($sql, $id);
	}

	/**
	 * Vrati následující kartu na základě ID aktuální karty
	 *
	 * @param int $id
	 * @return Row|null
	 */
	public function getNextById(int $id, CardsFilter $filter): Row|null
	{
		$sql = "
			SELECT c.*
			FROM cards AS c
			WHERE id = (SELECT min(id) from `cards` WHERE id > ?); 
			";
		return $this->connection->fetch($sql, $id);
	}


	/**
	 * Vrati list karet na základě filtru a limitů
	 *
	 * @param CardsFilter $filter
	 * @return array
	 */
	public function getAll(CardsFilter $filter): array
	{
		$sql = "
		SELECT c.*, ct.parent_id, ct.name as cardtype_name, IFNULL((SELECT name FROM cardtype AS ct2 WHERE  ct2.id = ct.parent_id), ct.name) parent_cardtype_name
		FROM cards AS c
		LEFT JOIN cardtype ct ON c.cardtype_id = ct.id
		WHERE " . $filter->getFilter() . "
		ORDER BY IFNULL((SELECT name FROM cardtype AS ct2 WHERE  ct2.id = ct.parent_id), ct.name), c.landtype_id, c.cardtype_id
		";

		return $this->connection->fetchAll($sql);
	}

	/**
	 * Vrati celkový počet adres podle zvoleného filtru
	 *
	 * @param AddressFilter $filter
	 * @return int
	 */
	public function getCount(AddressFilter $filter): int
	{
		$sql = "
			SELECT COUNT(*)
			FROM address AS a
			WHERE " . $filter->getFilter();
		return (int) $this->connection->fetchField($sql);
	}

}