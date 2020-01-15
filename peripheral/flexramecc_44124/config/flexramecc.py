"""*****************************************************************************
* Copyright (C) 2019 Microchip Technology Inc. and its subsidiaries.
*
* Subject to your compliance with these terms, you may use Microchip software
* and any derivatives exclusively with Microchip products. It is your
* responsibility to comply with third party license terms applicable to your
* use of third party software (including open source software) that may
* accompany Microchip software.
*
* THIS SOFTWARE IS SUPPLIED BY MICROCHIP "AS IS". NO WARRANTIES, WHETHER
* EXPRESS, IMPLIED OR STATUTORY, APPLY TO THIS SOFTWARE, INCLUDING ANY IMPLIED
* WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY, AND FITNESS FOR A
* PARTICULAR PURPOSE.
*
* IN NO EVENT WILL MICROCHIP BE LIABLE FOR ANY INDIRECT, SPECIAL, PUNITIVE,
* INCIDENTAL OR CONSEQUENTIAL LOSS, DAMAGE, COST OR EXPENSE OF ANY KIND
* WHATSOEVER RELATED TO THE SOFTWARE, HOWEVER CAUSED, EVEN IF MICROCHIP HAS
* BEEN ADVISED OF THE POSSIBILITY OR THE DAMAGES ARE FORESEEABLE. TO THE
* FULLEST EXTENT ALLOWED BY LAW, MICROCHIP'S TOTAL LIABILITY ON ALL CLAIMS IN
* ANY WAY RELATED TO THIS SOFTWARE WILL NOT EXCEED THE AMOUNT OF FEES, IF ANY,
* THAT YOU HAVE PAID DIRECTLY TO MICROCHIP FOR THIS SOFTWARE.
*****************************************************************************"""

###################################################################################################
#################################### Global Variables #############################################
###################################################################################################
global fixInterruptVector
global fixInterruptHandler
global fixInterruptHandlerLock
global noFixInterruptVector
global noFixInterruptHandler
global noFixInterruptHandlerLock

###################################################################################################
######################################### Functions ###############################################
###################################################################################################

def interruptControl(NVIC, event):
    global fixInterruptVector
    global fixInterruptHandler
    global fixInterruptHandlerLock
    global noFixInterruptVector
    global noFixInterruptHandler
    global noFixInterruptHandlerLock
    Database.clearSymbolValue("core", fixInterruptVector)
    Database.clearSymbolValue("core", fixInterruptHandler)
    Database.clearSymbolValue("core", fixInterruptHandlerLock)
    Database.clearSymbolValue("core", noFixInterruptVector)
    Database.clearSymbolValue("core", noFixInterruptHandler)
    Database.clearSymbolValue("core", noFixInterruptHandlerLock)
    if (event["value"] == True):
        Database.setSymbolValue("core", fixInterruptVector, True, 2)
        Database.setSymbolValue("core", fixInterruptHandler, flexrameccInstanceName.getValue() + "_INTFIX_InterruptHandler", 2)
        Database.setSymbolValue("core", fixInterruptHandlerLock, True, 2)
        Database.setSymbolValue("core", noFixInterruptVector, True, 2)
        Database.setSymbolValue("core", noFixInterruptHandler, flexrameccInstanceName.getValue() + "_INTNOFIX_InterruptHandler", 2)
        Database.setSymbolValue("core", noFixInterruptHandlerLock, True, 2)
    else :
        Database.setSymbolValue("core", fixInterruptVector, False, 2)
        Database.setSymbolValue("core", fixInterruptHandler, "FLEXRAMECC_INTFIX_Handler", 2)
        Database.setSymbolValue("core", fixInterruptHandlerLock, False, 2)
        Database.setSymbolValue("core", noFixInterruptVector, False, 2)
        Database.setSymbolValue("core", noFixInterruptHandler, "FLEXRAMECC_INTNOFIX_Handler", 2)
        Database.setSymbolValue("core", noFixInterruptHandlerLock, False, 2)


###################################################################################################
########################################## Callbacks  #############################################
###################################################################################################

def flexrameccClockWarningStatus(symbol, event):
    symbol.setVisible(not event["value"])

def InterruptStatusWarning(symbol, event):
    if (Database.getSymbolValue(flexrameccInstanceName.getValue().lower(), "INTERRUPT_MODE") == True):
        symbol.setVisible(event["value"])

###################################################################################################
########################################## Component  #############################################
###################################################################################################


def instantiateComponent(flexrameccComponent):

    global flexrameccInstanceName
    global fixInterruptVectorUpdate
    global fixInterruptVector
    global fixInterruptHandler
    global fixInterruptHandlerLock
    global noFixInterruptVectorUpdate
    global noFixInterruptVector
    global noFixInterruptHandler
    global noFixInterruptHandlerLock

    flexrameccInstanceName = flexrameccComponent.createStringSymbol("FLEXRAMECC_INSTANCE_NAME", None)
    flexrameccInstanceName.setVisible(False)
    flexrameccInstanceName.setDefaultValue(flexrameccComponent.getID().upper())
    print("Running " + flexrameccInstanceName.getValue())

    # Initialize peripheral clock
    Database.setSymbolValue("core", flexrameccInstanceName.getValue() + "_CLOCK_ENABLE", True, 1)

    ################################################################################
    #### Menu ####
    ################################################################################

    flexrameccInterruptMode = flexrameccComponent.createBooleanSymbol("INTERRUPT_MODE", None)
    flexrameccInterruptMode.setLabel("Interrupt Mode")
    flexrameccInterruptMode.setDefaultValue(False)

    flexrameccInjectionTestMode = flexrameccComponent.createBooleanSymbol("INJECTION_TEST_MODE", None)
    flexrameccInjectionTestMode.setLabel("Use Injection Test Mode")
    flexrameccInjectionTestMode.setDefaultValue(False)

    ############################################################################
    #### Dependency ####
    ############################################################################

    # Clock dependency Warning status
    flexrameccClkEnComment = flexrameccComponent.createCommentSymbol("FLEXRAMECC_CLOCK_ENABLE_COMMENT", None)
    flexrameccClkEnComment.setLabel("Warning!!! " + flexrameccInstanceName.getValue() + " Peripheral Clock is Disabled in Clock Manager")
    flexrameccClkEnComment.setVisible(False)
    flexrameccClkEnComment.setDependencies(flexrameccClockWarningStatus, ["core." + flexrameccInstanceName.getValue() + "_CLOCK_ENABLE"])

    fixInterruptVector = flexrameccInstanceName.getValue() + "_INTFIX_INTERRUPT_ENABLE"
    fixInterruptHandler = flexrameccInstanceName.getValue() + "_INTFIX_INTERRUPT_HANDLER"
    fixInterruptHandlerLock = flexrameccInstanceName.getValue() + "_INTFIX_INTERRUPT_HANDLER_LOCK"
    fixInterruptVectorUpdate = flexrameccInstanceName.getValue() + "_INTFIX_INTERRUPT_ENABLE_UPDATE"
    noFixInterruptVector = flexrameccInstanceName.getValue() + "_INTNOFIX_INTERRUPT_ENABLE"
    noFixInterruptHandler = flexrameccInstanceName.getValue() + "_INTNOFIX_INTERRUPT_HANDLER"
    noFixInterruptHandlerLock = flexrameccInstanceName.getValue() + "_INTNOFIX_INTERRUPT_HANDLER_LOCK"
    noFixInterruptVectorUpdate = flexrameccInstanceName.getValue() + "_INTNOFIX_INTERRUPT_ENABLE_UPDATE"

    # NVIC Dynamic settings
    flexrameccinterruptControl = flexrameccComponent.createBooleanSymbol("NVIC_FLEXRAMECC_ENABLE", None)
    flexrameccinterruptControl.setDependencies(interruptControl, ["INTERRUPT_MODE"])
    flexrameccinterruptControl.setVisible(False)

    # Dependency Status for interrupt
    flexrameccIntEnComment = flexrameccComponent.createCommentSymbol("FLEXRAMECC_INTERRUPT_ENABLE_COMMENT", None)
    flexrameccIntEnComment.setVisible(False)
    flexrameccIntEnComment.setLabel("Warning!!! " + flexrameccInstanceName.getValue() + " Interrupt is Disabled in Interrupt Manager")
    flexrameccIntEnComment.setDependencies(InterruptStatusWarning, ["core." + fixInterruptVectorUpdate, "core." + noFixInterruptVectorUpdate])

    ###################################################################################################
    ####################################### Code Generation  ##########################################
    ###################################################################################################

    configName = Variables.get("__CONFIGURATION_NAME")

    flexrameccHeaderFile = flexrameccComponent.createFileSymbol("FLEXRAMECC_HEADER", None)
    flexrameccHeaderFile.setSourcePath("/peripheral/flexramecc_44124/templates/plib_flexramecc.h.ftl")
    flexrameccHeaderFile.setOutputName("plib_" + flexrameccInstanceName.getValue().lower() + ".h")
    flexrameccHeaderFile.setDestPath("peripheral/flexramecc/")
    flexrameccHeaderFile.setProjectPath("config/" + configName +"/peripheral/flexramecc/")
    flexrameccHeaderFile.setType("HEADER")
    flexrameccHeaderFile.setMarkup(True)

    flexrameccSource1File = flexrameccComponent.createFileSymbol("FLEXRAMECC_SOURCE", None)
    flexrameccSource1File.setSourcePath("/peripheral/flexramecc_44124/templates/plib_flexramecc.c.ftl")
    flexrameccSource1File.setOutputName("plib_" + flexrameccInstanceName.getValue().lower() + ".c")
    flexrameccSource1File.setDestPath("peripheral/flexramecc/")
    flexrameccSource1File.setProjectPath("config/" + configName +"/peripheral/flexramecc/")
    flexrameccSource1File.setType("SOURCE")
    flexrameccSource1File.setMarkup(True)

    flexrameccSystemInitFile = flexrameccComponent.createFileSymbol("FLEXRAMECC_INIT", None)
    flexrameccSystemInitFile.setType("STRING")
    flexrameccSystemInitFile.setOutputName("core.LIST_SYSTEM_INIT_C_SYS_INITIALIZE_PERIPHERALS")
    flexrameccSystemInitFile.setSourcePath("/peripheral/flexramecc_44124/templates/system/initialization.c.ftl")
    flexrameccSystemInitFile.setMarkup(True)

    flexrameccSystemDefFile = flexrameccComponent.createFileSymbol("FLEXRAMECC_DEF", None)
    flexrameccSystemDefFile.setType("STRING")
    flexrameccSystemDefFile.setOutputName("core.LIST_SYSTEM_DEFINITIONS_H_INCLUDES")
    flexrameccSystemDefFile.setSourcePath("/peripheral/flexramecc_44124/templates/system/definitions.h.ftl")
    flexrameccSystemDefFile.setMarkup(True)
