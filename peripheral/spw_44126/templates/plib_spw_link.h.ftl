/*******************************************************************************
  SPW Peripheral Library
  Instance Header File

  Company:
    Microchip Technology Inc.

  File Name:
    plib_${SPW_INSTANCE_NAME?lower_case}_link.h

  Summary:
    ${SPW_INSTANCE_NAME} PLIB LINK Header file

  Description:
    This file defines the interface to the ${SPW_INSTANCE_NAME} peripheral 
    library. This library provides access to and control of the associated 
    peripheral instance.
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

#ifndef PLIB_${SPW_INSTANCE_NAME}_LINK_H
#define PLIB_${SPW_INSTANCE_NAME}_LINK_H

// *****************************************************************************
// *****************************************************************************
// Section: Included Files
// *****************************************************************************
// *****************************************************************************
/* This section lists the other files that are included in this file.
*/
#include "device.h"

// DOM-IGNORE-BEGIN
#ifdef __cplusplus // Provide C++ Compatibility
    extern "C" {
#endif
// DOM-IGNORE-END

// *****************************************************************************
// *****************************************************************************
// Section: ${SPW_INSTANCE_NAME} defines
// *****************************************************************************
// *****************************************************************************

/* Return SPW LINK State from Link status word. */
#define SPW_LINK_GET_STATE(status) ( (SPW_LINK_STATE)( (status & SPW_LINK_STATUS_LINKSTATE_MASK) >> SPW_LINK1_STATUS_LINKSTATE_Pos ) )

// *****************************************************************************
// *****************************************************************************
// Section: ${SPW_INSTANCE_NAME} Types
// *****************************************************************************
// *****************************************************************************

/* SPW link
   Summary:
    Identifies the SPW link

   Description:
    This data type identifies the SPW link
*/
typedef enum
{
    SPW_LINK_1 = 1,
    SPW_LINK_2 = 2,
    /* Force the compiler to reserve 32-bit memory for enum */
    SPW_LINK_INVALID = 0xFFFFFFFF
} SPW_LINK;

// *****************************************************************************
/* SPW LINK status
   Summary:
    Identifies the SPW LINK current status

   Description:
    This data type identifies the SPW LINK status
*/
typedef enum
{
    SPW_LINK_STATUS_LINKSTATE_MASK = SPW_LINK1_STATUS_LINKSTATE_Msk, 
    SPW_LINK_STATUS_TXDEFDIV_MASK = SPW_LINK1_STATUS_TXDEFDIV_Msk,
    SPW_LINK_STATUS_TXEMPTY = SPW_LINK1_STATUS_TXEMPTY_Msk,
    SPW_LINK_STATUS_GOTNULL = SPW_LINK1_STATUS_GOTNULL_Msk,
    SPW_LINK_STATUS_GOTFCT = SPW_LINK1_STATUS_GOTFCT_Msk,
    SPW_LINK_STATUS_GOTNCHAR = SPW_LINK1_STATUS_GOTNCHAR_Msk,
    SPW_LINK_STATUS_SEEN0 = SPW_LINK1_STATUS_SEEN0_Msk, 
    SPW_LINK_STATUS_SEEN1 = SPW_LINK1_STATUS_SEEN1_Msk,
    SPW_LINK_STATUS_SEEN2 = SPW_LINK1_STATUS_SEEN2_Msk,
    SPW_LINK_STATUS_SEEN3 = SPW_LINK1_STATUS_SEEN3_Msk,
    SPW_LINK_STATUS_SEEN4 = SPW_LINK1_STATUS_SEEN4_Msk,
    SPW_LINK_STATUS_SEEN5 = SPW_LINK1_STATUS_SEEN5_Msk,
    /* Force the compiler to reserve 32-bit memory for enum */
    SPW_LINK_STATUS_INVALID = 0xFFFFFFFF
} SPW_LINK_STATUS;

// *****************************************************************************
/* SPW LINK state
   Summary:
    Identifies the SPW LINK current CODEC link state machine

   Description:
    This data type identifies the SPW CODEC link state machine
*/
typedef enum
{
    SPW_LINK_STATE_ERROR_RESET = 0,
    SPW_LINK_STATE_ERROR_WAIT,
    SPW_LINK_STATE_READY,
    SPW_LINK_STATE_STARTED,
    SPW_LINK_STATE_CONNECTING,
    SPW_LINK_STATE_RUN,
    /* Force the compiler to reserve 32-bit memory for enum */
    SPW_LINK_STATE_INVALID = 0xFFFFFFFF
} SPW_LINK_STATE;

// *****************************************************************************
/* SPW LINK IRQ status
   Summary:
    Identifies the SPW LINK IRQ event that have pending interrupt

   Description:
    This data type identifies the SPW LINK IRQ event that have pending interrupt
*/
typedef enum
{
    SPW_LINK_INT_MASK_DISERR = SPW_LINK1_PI_RM_DISERR_Msk,
    SPW_LINK_INT_MASK_PARERR = SPW_LINK1_PI_RM_PARERR_Msk,
    SPW_LINK_INT_MASK_ESCERR = SPW_LINK1_PI_RM_ESCERR_Msk,
    SPW_LINK_INT_MASK_CRERR = SPW_LINK1_PI_RM_CRERR_Msk,
    SPW_LINK_INT_MASK_LINKABORT = SPW_LINK1_PI_RM_LINKABORT_Msk,
    SPW_LINK_INT_MASK_EEPTRANS = SPW_LINK1_PI_RM_EEPTRANS_Msk,
    SPW_LINK_INT_MASK_EEPREC = SPW_LINK1_PI_RM_EEPREC_Msk,
    SPW_LINK_INT_MASK_DISCARD = SPW_LINK1_PI_RM_DISCARD_Msk,
    SPW_LINK_INT_MASK_ESCEVENT2 = SPW_LINK1_PI_RM_ESCEVENT2_Msk,
    SPW_LINK_INT_MASK_ESCEVENT1 = SPW_LINK1_PI_RM_ESCEVENT1_Msk,
    /* Force the compiler to reserve 32-bit memory for enum */
    SPW_LINK_INT_MASK_INVALID = 0xFFFFFFFF
} SPW_LINK_INT_MASK;

// *****************************************************************************
// *****************************************************************************
// Section: Interface Routines
// *****************************************************************************
// *****************************************************************************

/*
 * The following functions make up the methods (set of possible operations) of
 * this interface.
 */

void ${SPW_INSTANCE_NAME}_LINK_Initialize(void);

SPW_LINK_STATUS ${SPW_INSTANCE_NAME}_LINK_StatusGet(SPW_LINK link);

<#if INTERRUPT_MODE == true>
SPW_LINK_INT_MASK ${SPW_INSTANCE_NAME}_LINK_IrqStatusGetMaskedAndClear(SPW_LINK link);

void ${SPW_INSTANCE_NAME}_LINK_InterruptEnable(SPW_LINK link, SPW_LINK_INT_MASK interruptMask);

void ${SPW_INSTANCE_NAME}_LINK_InterruptDisable(SPW_LINK link, SPW_LINK_INT_MASK interruptMask);
</#if>

// DOM-IGNORE-BEGIN
#ifdef __cplusplus  // Provide C++ Compatibility
}
#endif
// DOM-IGNORE-END

#endif /* PLIB_${SPW_INSTANCE_NAME}_LINK_H */
