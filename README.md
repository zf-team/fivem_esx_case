# fivem_esx_case


## Overview
This repository contains a Lua script for the FiveM framework, specifically designed to integrate with the ESX system. The script adds case management functionality for ESX-based servers.
The case pops up if the amount of money, which is set in the config, is over the limit. 

## Features
- Case appearance when the money is over the limit
- Easy configutantion (for example: money amount, sprint with case) and setup

## Installation

1. Clone this repository into your `resources` folder:

   ```bash
   git clone https://github.com/zf-team/fivem_esx_case.git
   ```

2. Add the script to your server configuration file:

   ```bash
   ensure fivem_esx_case
   ```

3. Configure the script by editing the `config.lua` file:

   ```lua
    Config.EnableCase = true
    Config.CanSprintWithCase = false
    
    -- Save amount of money to show the case
    Config.Amount = 10
   ```

## Usage
1. Start your FiveM server.
2. The case management system will be available in-game.

## Contributing
Feel free to open issues or submit pull requests. Contributions are welcome!

## License
This project is licensed under the MIT License.
