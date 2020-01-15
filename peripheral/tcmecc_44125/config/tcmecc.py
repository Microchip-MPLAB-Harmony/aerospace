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
        Database.setSymbolValue("core", fixInterruptHandler, "TCMRAM_INTFIX_InterruptHandler", 2)
        Database.setSymbolValue("core", fixInterruptHandlerLock, True, 2)
        Database.setSymbolValue("core", noFixInterruptVector, True, 2)
        Database.setSymbolValue("core", noFixInterruptHandler, "TCMRAM_INTNOFIX_InterruptHandler", 2)
        Database.setSymbolValue("core", noFixInterruptHandlerLock, True, 2)
    else :
        Database.setSymbolValue("core", fixInterruptVector, False, 2)
        Database.setSymbolValue("core", fixInterruptHandler, "TCMRAM_INTFIX_Handler", 2)
        Database.setSymbolValue("core", fixInterruptHandlerLock, False, 2)
        Database.setSymbolValue("core", noFixInterruptVector, False, 2)
        Database.setSymbolValue("core", noFixInterruptHandler, "TCMRAM_INTNOFIX_Handler", 2)
        Database.setSymbolValue("core", noFixInterruptHandlerLock, False, 2)

###################################################################################################
########################################## Callbacks  #############################################
###################################################################################################

def tcmeccClockWarningStatus(symbol, event):
    symbol.setVisible(not event["value"])

def InterruptStatusWarning(symbol, event):
    if (Database.getSymbolValue(tcmeccInstanceName.getValue().lower(), "INTERRUPT_MODE") == True):
        symbol.setVisible(event["value"])

###################################################################################################
########################################## Component  #############################################
###################################################################################################

def instantiateComponent(tcmeccComponent):

    global tcmeccInstanceName
    global fixInterruptVectorUpdate
    global fixInterruptVector
    global fixInterruptHandler
    global fixInterruptHandlerLock
    global noFixInterruptVectorUpdate
    global noFixInterruptVector
    global noFixInterruptHandler
    global noFixInterruptHandlerLock

    tcmeccInstanceName = tcmeccComponent.createStringSymbol("TCMECC_INSTANCE_NAME", None)
    tcmeccInstanceName.setVisible(False)
    tcmeccInstanceName.setDefaultValue(tcmeccComponent.getID().upper())
    print("Running " + tcmeccInstanceName.getValue())

    # Initialize peripheral clock
    Database.setSymbolValue("core", tcmeccInstanceName.getValue() + "_CLOCK_ENABLE", True, 1)

    ################################################################################
    #### Menu ####
    ################################################################################

    tcmeccInterruptMode = tcmeccComponent.createBooleanSymbol("INTERRUPT_MODE", None)
    tcmeccInterruptMode.setLabel("Interrupt Mode")
    tcmeccInterruptMode.setDefaultValue(False)

    tcmeccInjectionTestMode = tcmeccComponent.createBooleanSymbol("INJECTION_TEST_MODE", None)
    tcmeccInjectionTestMode.setLabel("Use Injection Test Mode")
    tcmeccInjectionTestMode.setDefaultValue(False)

    ############################################################################
    #### Dependency ####
    ############################################################################

    # Clock dependency Warning status
    tcmeccClkEnComment = tcmeccComponent.createCommentSymbol("TCMECC_CLOCK_ENABLE_COMMENT", None)
    tcmeccClkEnComment.setLabel("Warning!!! " + tcmeccInstanceName.getValue() + " Peripheral Clock is Disabled in Clock Manager")
    tcmeccClkEnComment.setVisible(False)
    tcmeccClkEnComment.setDependencies(tcmeccClockWarningStatus, ["core." + tcmeccInstanceName.getValue() + "_CLOCK_ENABLE"])

    fixInterruptVector = "TCMRAM_INTFIX_INTERRUPT_ENABLE"
    fixInterruptHandler = "TCMRAM_INTFIX_INTERRUPT_HANDLER"
    fixInterruptHandlerLock = "TCMRAM_INTFIX_INTERRUPT_HANDLER_LOCK"
    fixInterruptVectorUpdate = "TCMRAM_INTFIX_INTERRUPT_ENABLE_UPDATE"
    
    noFixInterruptVector = "TCMRAM_INTNOFIX_INTERRUPT_ENABLE"
    noFixInterruptHandler = "TCMRAM_INTNOFIX_INTERRUPT_HANDLER"
    noFixInterruptHandlerLock = "TCMRAM_INTNOFIX_INTERRUPT_HANDLER_LOCK"
    noFixInterruptVectorUpdate = "TCMRAM_INTNOFIX_INTERRUPT_ENABLE_UPDATE"

    # NVIC Dynamic settings
    tcmeccinterruptControl = tcmeccComponent.createBooleanSymbol("NVIC_TCMECC_ENABLE", None)
    tcmeccinterruptControl.setDependencies(interruptControl, ["INTERRUPT_MODE"])
    tcmeccinterruptControl.setVisible(False)

    # Dependency Status for interrupt
    tcmeccIntEnComment = tcmeccComponent.createCommentSymbol("TCMECC_INTERRUPT_ENABLE_COMMENT", None)
    tcmeccIntEnComment.setVisible(False)
    tcmeccIntEnComment.setLabel("Warning!!! " + tcmeccInstanceName.getValue() + " Interrupt is Disabled in Interrupt Manager")
    tcmeccIntEnComment.setDependencies(InterruptStatusWarning, ["core." + fixInterruptVectorUpdate, "core." + noFixInterruptVectorUpdate])

    ###################################################################################################
    ####################################### Code Generation  ##########################################
    ###################################################################################################

    configName = Variables.get("__CONFIGURATION_NAME")

    tcmeccHeaderFile = tcmeccComponent.createFileSymbol("TCMECC_HEADER", None)
    tcmeccHeaderFile.setSourcePath("/peripheral/tcmecc_44125/templates/plib_tcmecc.h.ftl")
    tcmeccHeaderFile.setOutputName("plib_" + tcmeccInstanceName.getValue().lower() + ".h")
    tcmeccHeaderFile.setDestPath("peripheral/tcmecc/")
    tcmeccHeaderFile.setProjectPath("config/" + configName +"/peripheral/tcmecc/")
    tcmeccHeaderFile.setType("HEADER")
    tcmeccHeaderFile.setMarkup(True)

    tcmeccSource1File = tcmeccComponent.createFileSymbol("TCMECC_SOURCE", None)
    tcmeccSource1File.setSourcePath("/peripheral/tcmecc_44125/templates/plib_tcmecc.c.ftl")
    tcmeccSource1File.setOutputName("plib_" + tcmeccInstanceName.getValue().lower() + ".c")
    tcmeccSource1File.setDestPath("peripheral/tcmecc/")
    tcmeccSource1File.setProjectPath("config/" + configName +"/peripheral/tcmecc/")
    tcmeccSource1File.setType("SOURCE")
    tcmeccSource1File.setMarkup(True)

    tcmeccSystemInitFile = tcmeccComponent.createFileSymbol("TCMECC_INIT", None)
    tcmeccSystemInitFile.setType("STRING")
    tcmeccSystemInitFile.setOutputName("core.LIST_SYSTEM_INIT_C_SYS_INITIALIZE_PERIPHERALS")
    tcmeccSystemInitFile.setSourcePath("/peripheral/tcmecc_44125/templates/system/initialization.c.ftl")
    tcmeccSystemInitFile.setMarkup(True)

    tcmeccSystemDefFile = tcmeccComponent.createFileSymbol("TCMECC_DEF", None)
    tcmeccSystemDefFile.setType("STRING")
    tcmeccSystemDefFile.setOutputName("core.LIST_SYSTEM_DEFINITIONS_H_INCLUDES")
    tcmeccSystemDefFile.setSourcePath("/peripheral/tcmecc_44125/templates/system/definitions.h.ftl")
    tcmeccSystemDefFile.setMarkup(True)
