# spacex-client-haskell

[![CI](https://github.com/alessandrocandolini/spacex-client-haskell/actions/workflows/ci.yml/badge.svg)](https://github.com/alessandrocandolini/spacex-client-haskell/actions/workflows/ci.yml) [![codecov](https://codecov.io/gh/alessandrocandolini/spacex-client-haskell/branch/main/graph/badge.svg?token=7R6FJHNC5S)](https://codecov.io/gh/alessandrocandolini/spacex-client-haskell)

Unofficial CLI client written in Haskell for SpaceX Apis: https://github.com/r-spacex/SpaceX-API

## How to build and run locally

The project uses the [Haskell tool stack](https://docs.haskellstack.org/en/stable/README/).

Assuming `stack` is installed in the system, the project can be build by running
```
stack build
```
To build and also run the tests, run
```
stack test
```
which is equivalent to
```
stack build --test
```
To run tests with coverage
```
stack test --coverage
```
which generates text and html reports.

To run the executable,
```
stack exec spacex-client-haskell-exe
```
For faster feedback loop,
```
stack test --fast --file-watch
```
To run `ghci` (with a version compatible with the resolver) run
```
stack ghci
```
For more information, refer to the `stack` official docs.
