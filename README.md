# broken_crystals

This project is a fun off-time task to create a vulnerable web app in Crystal.

## Installation

The project is available via dockerhub as the easiest option

```bash
docker pull neuralegion/broken_crystals
```

## Usage

To run the project use

```bash
docker run -it neuralegion/broken_crystals -p 3000:3000
```

and browse `http://localhost:3000/`

If you are running without docker copy `.env.example` and run following commands: 

```bash
crystal build -o ./cli cli.cr
./cli --help
```

## Development

Development goals and issues will be tracked in the issues section

## Contributing

1. Fork it (<https://github.com/NeuraLEgion/broken_crystals/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Bar Hofesh](https://github.com/bararchy) - creator and maintainer
- [Mirsad Halilcevic](https://github.com/sixaphone) - maintainer
- [Amar Zlojic](https://github.com/amar771) - maintainer
- [Faris Seferagic](https://github.com/farrza) - maintainer
- [Dzevad Alibegovic](https://github.com/cuteghost) - maintainer

