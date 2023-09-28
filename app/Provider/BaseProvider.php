<?php
declare(strict_types=1);

namespace App\Provider;

use Nette\Database\Connection;

abstract class BaseProvider
{
	public function __construct(
		protected Connection     $connection,
	) {
	}


	public function beginTransaction(): void
	{
		$this->connection->beginTransaction();
	}


	public function commit(): void
	{
		$this->connection->commit();
	}


	public function rollBack(): void
	{
		$this->connection->rollBack();
	}
}