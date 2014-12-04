# ZoneMount

An intelligent mounting add-on for World of Warcraft.

## Installation

You can download the latest release from
<https://github.com/jfarmer/ZoneMount/releases/latest>.  To install, uncompress
the downloaded file and copy the newly-created `ZoneMount` directory to the
`Interface/AddOns` directory.  On a Mac, for example, this lives at

```text
/Applications/World of Warcraft/Interface/AddOns
```

## Usage

In the game, run

```text
/zone_mount "<flyingMount>" "<groundMount>"
```

For example,

```
/zone_mount "Dark Phoenix" "Raven Lord"
/zone_mount "Albino Drake" "Black War Bear"
```

This command will cause you to mount according to the following logic:

1. If a zone-specific mount exists, mount using that.
2. If you're in a flying zone, use the specified flying mount.
3. Otherwise, use the specified ground mount.

If you want to bind this to an action button, create a macro via `/macro` and
enter the desired `/zone_mount` command as the macro's script body.
