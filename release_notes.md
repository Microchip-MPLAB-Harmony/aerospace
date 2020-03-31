---
title: Release notes
nav_order: 99
---

![Microchip logo](https://raw.githubusercontent.com/wiki/Microchip-MPLAB-Harmony/Microchip-MPLAB-Harmony.github.io/images/microchip_logo.png)
![Harmony logo small](https://raw.githubusercontent.com/wiki/Microchip-MPLAB-Harmony/Microchip-MPLAB-Harmony.github.io/images/microchip_mplab_harmony_logo_small.png)

# Microchip MPLAB® Harmony 3 Release Notes

## Aerospace Release v3.0.2
### New Features

* Fix of wrong URL for online documentation.

### Known Issues

* No changes from v3.0.1

### Development Tools

* No changes from v3.0.1

### Dependent Components

* No changes from v3.0.1

## Aerospace Release v3.0.1
### New Features

* Bring online documentation (https://microchip-mplab-harmony.github.io/aerospace/).

### Known Issues

* No changes from v3.0.0

### Development Tools

* No changes from v3.0.0

### Dependent Components

* No changes from v3.0.0

## Aerospace Release v3.0.0
### New Features

- **New peripheral libraries support** - This release introduces peripheral libraies support for:
    - MIL1553.
    - SpaceWire.
    - ICM.
    - TCMECC.
    - FLEXRAMECC.

- **Development kit and demo application support** - The following table provides number of peripheral library application available for different development kits

    | Development Kits                                                                                                                               | Number of applications |
    | ---                                                                                                                                            | --- |
    | [SAMRH71 Evaluation Kit](https://www.microchip.com/DevelopmentTools/ProductDetails/PartNO/SAMRH71F20-EK)                     | 7 |



### Known Issues

The current known issues are as follows:

* Preliminary support added for SAM RH71 using MPLAB X and XC32. This complete tooling support will be added in future release of MPLAB X.

* MPLABX v5.30 generates build error for SAMRH71 : After MHC code generation the field "XC32 Global Option -> Data TCM size" in project properties for DTCM size should be set to 0x20000.

### Development Tools

* [MPLAB® X IDE v5.30](https://www.microchip.com/mplab/mplab-x-ide)
* [MPLAB® XC32 C/C++ Compiler v2.30](https://www.microchip.com/mplab/compilers)
* MPLAB® X IDE plug-ins:
    * MPLAB® Harmony Configurator (MHC) v3.4.1 and above.

### Dependent Components

* [CSP v3.6.0](https://github.com/Microchip-MPLAB-Harmony/csp/releases/tag/v3.6.0)
* [dev_packs v3.6.0](https://github.com/Microchip-MPLAB-Harmony/dev_packs/releases/tag/v3.6.0)
