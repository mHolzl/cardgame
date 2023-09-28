<?php

declare(strict_types=1);

namespace App\Entity;

#[\Attribute] class CardsEntity implements EntityInterface
{
	public int|null $id = null;
	public string $name = '';
	public string $title = '';
	public string $description = '';
	public int|null $value = null;
	public int|null $price = null;
	public int|null $cardtype_id = null;
	public int|null $landtype_id = null;
}