# usage

add `bin/` to path and provide path to file as argument

```sh
# go
go-sum.sed path/to/go.sum

# rust
cargo-lock.sed < path/to/Cargo.lock
```

or call script from sed with `-nf` flags
```sh
sed -nf path/to/go-sum.sed < path/to/go.sum
```
