/*******************************************************************************
  SPW Peripheral Library
  Source File

  Company:
    Microchip Technology Inc.

  File Name:
    plib_spw_link.c

  Summary:
    SPW PLIB Implementation file

  Description:
    This file defines the interface to the SPW peripheral library.
    This library provides access to and control of the associated peripheral
    instance.

*******************************************************************************/
// DOM-IGNORE-BEGIN
/*******************************************************************************
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
*******************************************************************************/
// DOM-IGNORE-END

// *****************************************************************************
// *****************************************************************************
// Section: Included Files
// *****************************************************************************
// *****************************************************************************

#include "device.h"
#include "plib_spw_link.h"

// *****************************************************************************
// *****************************************************************************
// SPW PLib Interface Routines
// *****************************************************************************
// *****************************************************************************
// *****************************************************************************

/* Function:
    void SPW_LINK_Initialize(void)

   Summary:
    Initialize LINK modules of the SPW peripheral.

   Precondition:
    None.

   Parameters:
    None.

   Returns:
    None
*/
void SPW_LINK_Initialize(void)
{
    /* Initialize link 1 clock divisor */
    SPW_REGS->SPW_LINK1_CLKDIV = SPW_LINK1_CLKDIV_TXINITDIV(19) | SPW_LINK1_CLKDIV_TXOPERDIV(0);

    /* Set link 1 configuration command */
    SPW_REGS->SPW_LINK1_CFG = SPW_LINK1_CFG_COMMAND(3);
    /* Initialize link 2 clock divisor */
    SPW_REGS->SPW_LINK2_CLKDIV = SPW_LINK2_CLKDIV_TXINITDIV(19) | SPW_LINK2_CLKDIV_TXOPERDIV(0);

    /* Set link 2 configuration command */
    SPW_REGS->SPW_LINK2_CFG = SPW_LINK2_CFG_COMMAND(2);
}

// *****************************************************************************
/* Function:
    SPW_LINK_STATUS SPW_LINK_StatusGet(SPW_LINK link)

   Summary:
    Get the SPW LINK status of the given SPW link.

   Precondition:
    None.

   Parameters:
    link - the selected link ID.

   Returns:
    Current status of the selected SPW link.
*/
SPW_LINK_STATUS SPW_LINK_StatusGet(SPW_LINK link)
{
    SPW_LINK_STATUS status = 0;
    if ( link == SPW_LINK_1 )
    {
        status = SPW_REGS->SPW_LINK1_STATUS;
    }
    else if ( link == SPW_LINK_2 )
    {
        status = SPW_REGS->SPW_LINK2_STATUS;
    }
    return status;
}

// *****************************************************************************
/* Function:
    SPW_LINK_INT_MASK SPW_LINK_IrqStatusGetMaskedAndClear(SPW_LINK link);

   Summary:
    Get the SPW LINK interrupt status for masked interrupt and clear them for the
    selected link interface.

   Precondition:
    None.

   Parameters:
    link - the selected link ID.

   Returns:
    Current interrupt status of the selected link.
*/
SPW_LINK_INT_MASK SPW_LINK_IrqStatusGetMaskedAndClear(SPW_LINK link)
{
    SPW_LINK_INT_MASK pendingMaskedIrq = 0;
    if (link == SPW_LINK_1)
    {
        pendingMaskedIrq = SPW_REGS->SPW_LINK1_PI_RM;
        SPW_REGS->SPW_LINK1_PI_C = pendingMaskedIrq;
    }
    else if (link == SPW_LINK_2)
    {
        pendingMaskedIrq = SPW_REGS->SPW_LINK2_PI_RM;
        SPW_REGS->SPW_LINK2_PI_C = pendingMaskedIrq;
    }
    return pendingMaskedIrq;
}

// *****************************************************************************
/* Function:
    void SPW_LINK_InterruptEnable(SPW_LINK link, SPW_LINK_INT_MASK interruptMask)

   Summary:
    Enables SPW LINK Interrupt for given link interface.

   Precondition:
    SPW_Initialize must have been called for the associated SPW instance.

   Parameters:
    link - the selected link ID.
    interruptMask - Interrupt to be enabled

   Returns:
    None
*/
void SPW_LINK_InterruptEnable(SPW_LINK link, SPW_LINK_INT_MASK interruptMask)
{
    if ( link == SPW_LINK_1 )
    {
        SPW_REGS->SPW_LINK1_IM_S = interruptMask;
    }
    else if ( link == SPW_LINK_2 )
    {
        SPW_REGS->SPW_LINK2_IM_S = interruptMask;
    }
}

// *****************************************************************************
/* Function:
    void SPW_LINK_InterruptDisable(SPW_LINK link, SPW_LINK_INT_MASK interruptMask)

   Summary:
    Disables SPW LINK Interrupt for given link interface.

   Precondition:
    SPW_Initialize must have been called for the associated SPW instance.

   Parameters:
    link - the selected link ID.
    interruptMask - Interrupt to be disabled

   Returns:
    None
*/
void SPW_LINK_InterruptDisable(SPW_LINK link, SPW_LINK_INT_MASK interruptMask)
{
    if ( link == SPW_LINK_1 )
    {
        SPW_REGS->SPW_LINK1_IM_C = interruptMask;
    }
    else if ( link == SPW_LINK_2 )
    {
        SPW_REGS->SPW_LINK2_IM_C = interruptMask;
    }
}

