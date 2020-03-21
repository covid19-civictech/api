<?php

use Phinx\Migration\AbstractMigration;

class InitialMigration extends AbstractMigration
{

    public function change()
    {
        $this->execute(file_get_contents(__DIR__ . DIRECTORY_SEPARATOR . 'initial.sql'));
    }
}
