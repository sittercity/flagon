# Flagon

Flagon is a storage agnostic feature flag gem.
You can use flagon if you have features in your program that you'd like to be able to turn
on or off using environment variables, a yaml file, a simple hash on initialization or a custom
storage method you create yourself and pass in.

## Initialising

You can initialise flagon using either a filename, a hash of settings or nothing if you'd like it to check environment variables.

### Using Environment Variables

```
Flagon.init
```

Environment variables should be "on" or anything else to be off.

```
export MY_FLAG='on'
```

### Using a Yaml Settings File

```
loader = Flagon.file_loader "/path/to/settings.yaml"
Flagon.init loader
```

The yaml file format should be single level, with values of on or off. E.g.

```
feature_1: on
feature_2: off
```

### Using a Settings Hash

```
loader = Flagon.hash_loader {feature_1: "on", feature_2: "off"}
Flagon.init loader
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

### Using the inspector directly

When you call `Flagon.init` an inspector object is returned.
The class methods above are just convenience methods that call this inspector so
you can also use it directly if that's your cup of tea.

```
ENV['BACON'] = 'on'
flagon = Flagon.init
flagon.enabled?(:bacon) # => true
```
