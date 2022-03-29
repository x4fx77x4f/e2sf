# E2SF
E2SF is an [Expression 2](https://github.com/wiremod/wire/wiki/Expression-2) to Lua transpiler, and a [StarfallEx](https://github.com/thegrb93/StarfallEx)-based runtime for running transpiled E2 code. It is currently extremely incomplete and not usable for anything.

## Warning
**This software is provided as is without warranty of any kind.** While an effort has been made to reduce the chance of bad things happening as a result of this software, absolutely no guarantees are made as to its safety. In particular, while this software was written with the intent of not allowing Lua injection in compiled code, for the runtime to be a secure sandbox, and for ran code to behave the same as it would natively, I cannot guarantee that any of those claims are true. By using this software, you accept the risk of potentially being adversely affected by potential flaws.

## Usage
1. `git clone https://github.com/x4fx77x4f/e2sf.git ~/.steam/steam/steamapps/common/GarrysMod/garrysmod/data/starfall/e2sf`
2. Place your Expression 2 code into the `expression2` folder (note: must be manually translated into Lua for now)
3. Flash `e2sf/init.lua` to a Starfall Processor (after changing hardcoded path)
4. Optionally place and wire a Starfall Component (needed for EGP v3)

## License
This software is derived from [Wiremod](https://github.com/wiremod/wire) and uses the same license, which is the Apache License 2.0. The license terms can be read in [`LICENSE`](LICENSE). You may not use this software except in compliance with the license.

Copyright (c) 2022 x4fx77x4f

> Copyright 2008 onwards by the Wire Team
