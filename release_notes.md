![Microchip logo](https://raw.githubusercontent.com/wiki/Microchip-MPLAB-Harmony/Microchip-MPLAB-Harmony.github.io/images/microchip_logo.png)
![Harmony logo small](https://raw.githubusercontent.com/wiki/Microchip-MPLAB-Harmony/Microchip-MPLAB-Harmony.github.io/images/microchip_mplab_harmony_logo_small.png)

# Microchip MPLAB® Harmony 3 Release Notes

## Aerospace Release v3.4.0
### New Features
- **Enhancements**
  - Remove Applications examples from aerospace repository to have them in dedicated repository.
  - Update peripheral libraries to add SAMRH707 support and new registers.
  - Fix compilation issues with XC32 v4.00.

### Known Issues

* No known issues.

### Development Tools

* [MPLAB® X IDE v6.00 or above](https://www.microchip.com/mplab/mplab-x-ide)
* [MPLAB® XC32 C/C++ Compiler v4.10](https://www.microchip.com/mplab/compilers)
* MPLAB® X IDE plug-ins:
    * MPLAB® Code Configurator 5.1.9 or higher

## Aerospace Release v3.3.0
### New Features
- **Enhancements**
  - Fix on FLEXRAMECC Plib after update of the SAMRH71 DFP to align register names with datasheet.
  - Add new warning compiler switches in examples projects.
  - Switch project configuration to yaml format.
  - Update examples generated code with new CSP v3.9.0 version.

### Known Issues

* No known issues.

### Development Tools

* [MPLAB® X IDE v5.45 or above](https://www.microchip.com/mplab/mplab-x-ide)
* [MPLAB® XC32 C/C++ Compiler v2.50](https://www.microchip.com/mplab/compilers)
* MPLAB® X IDE plug-ins:
    * MPLAB® Harmony Configurator (MHC) v3.6.2 and above.

### Dependent Components

* [CSP v3.9.0](https://github.com/Microchip-MPLAB-Harmony/csp/releases/tag/v3.9.0)
* [dev_packs v3.9.0](https://github.com/Microchip-MPLAB-Harmony/dev_packs/releases/tag/v3.9.0)

## Aerospace Release v3.2.0
### New Features
- **Enhancements**
  - Fixed typo in function name in TCMECC Plib header file.
  - Regenerated Harmony files with new CSP v3.8.0 version.

### Known Issues

* No known issues.

### Development Tools

* [MPLAB® X IDE v5.40 or above](https://www.microchip.com/mplab/mplab-x-ide)
* [MPLAB® XC32 C/C++ Compiler v2.41](https://www.microchip.com/mplab/compilers)
* MPLAB® X IDE plug-ins:
    * MPLAB® Harmony Configurator (MHC) v3.6.0 and above.

### Dependent Components

* [CSP v3.8.0](https://github.com/Microchip-MPLAB-Harmony/csp/releases/tag/v3.8.0)
* [dev_packs v3.8.0](https://github.com/Microchip-MPLAB-Harmony/dev_packs/releases/tag/v3.8.0)

## Aerospace Release v3.1.0
### New Features

* **Development kit and demo application support** - The following table provides number of peripheral library application available for different development kits

    | Development Kits                                                                                                  | Number of applications |
    | ---                                                                                                               | --- |
    | [SAMRH71 Evaluation Kit](https://www.microchip.com/DevelopmentTools/ProductDetails/PartNO/SAMRH71F20-EK)          | 8 |

* Add SpaceWire Link Escape Character and TCH support in peripheral libraries and add and example.
* Update 1553 peripheral libraries and upgrade examples (BC and RT) for mode command transfer examples.
* Fix of MISRA warnings.
* Fix ICM calculated value for TRSIZE field when size multiple of 64
* Fix handler name in TCMECC component
* Fix faulty wait condition in SpaceWire RMAP Example and set stall mode in RX initialization
* Fix documentation rendering and typo.

### Known Issues

* No known issues.

### Development Tools

* [MPLAB® X IDE v5.40 or above](https://www.microchip.com/mplab/mplab-x-ide)
* [MPLAB® XC32 C/C++ Compiler v2.41](https://www.microchip.com/mplab/compilers)
* MPLAB® X IDE plug-ins:
    * MPLAB® Harmony Configurator (MHC) v3.4.2 and above.

### Dependent Components

* [CSP v3.7.0](https://github.com/Microchip-MPLAB-Harmony/csp/releases/tag/v3.7.0)
* [dev_packs v3.7.0](https://github.com/Microchip-MPLAB-Harmony/dev_packs/releases/tag/v3.7.0)

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
