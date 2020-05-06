# Database

## Summary

Broken crystal uses postgresql as its database driver.
All queries, migrations and such are written using `postgresql`.

## Important to know

- `migration.cr`

    is the base class for a migration. Every migration should inherit the base class to have access to `DB`. Base class also enforces child classes to implement up and down method.

- `migrations/**` 

    This is the folder containing all migrations. Add a new migration in format 
    ```crystal
    class MyMigration < Migration
        def up() 
        # create and stuff
        end
        
        def down() 
        # create and stuff
        end
    end
    ```

- `migration_up.cr`

    Run migrations. After creating a new migration add class call here in format `<Class>.new.up()`. Order is not important untill you break something.
    Run with command `env $(cat .env) crystal src/db/migration_up.cr`
    If `POSTGRES_URL` is exported to env there is no need for the `env $(cat .env)` part

- `migration_down.cr`

    Same as up just down
