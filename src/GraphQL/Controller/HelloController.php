<?php

namespace App\GraphQL\Controller;

use TheCodingMachine\GraphQLite\Annotations\Query;

final class HelloController
{
    #[Query]
    public function hello(string $name = 'world'): string
    {
        return sprintf('Hello %s', $name);
    }
}
