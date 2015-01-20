# Flagon

## Initialising

You can initialise flagon using either a filename, a hash of settings or nothing if you'd like it to check environment variables.

### Using Environment Variables

```
Flagon.configure
```

Environment variables should be "on" or anything else to be off.

```
export SOME_VAR='on'
```

### Using a Yaml Settings File

```
Flagon.configure "/path/to/settings.yaml"
```

The yaml file format should be single level, with values of on or off. E.g.

```
feature_1: on
feature_2: off
```

### Using a Settings Hash

```
Flagon.configure {feature_1: "on", feature_2: "off"}
```

## Usage

You can use flagon in two ways. By checking the flag directly, or by passing a block.

### Checking the flag

```
profit! if Flagon.enabled?(:feature_1)
```

### Passing a block

```
Flagon.when_enabled(:feature_1) do
  profit!
end
```
