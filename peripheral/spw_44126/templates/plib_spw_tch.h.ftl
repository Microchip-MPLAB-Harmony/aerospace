/*******************************************************************************
  SPW Peripheral Library
  Instance Header File

  Company:
    Microchip Technology Inc.

  File Name:
    plib_${SPW_INSTANCE_NAME?lower_case}_tch.h

  Summary:
    ${SPW_INSTANCE_NAME} PLIB TCH Header file

  Description:
    This file defines the interface to the ${SPW_INSTANCE_NAME} peripheral 
    library. This library provides access to and control of the associated 
    peripheral instance.
*******************************************************************************/
// DOM-IGNORE-BEGIN
/*******************************************************************************
* Copyright (C) 2020 Microchip Technology Inc. and its subsidiaries.
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

#ifndef PLIB_${SPW_INSTANCE_NAME}_TCH_H
#define PLIB_${SPW_INSTANCE_NAME}_TCH_H

// *****************************************************************************
// *****************************************************************************
// Section: Included Files
// *****************************************************************************
// *****************************************************************************
/* This section lists the other files that are included in this file.
*/
#include <stdbool.h>
#include "device.h"
#include "plib_${SPW_INSTANCE_NAME?lower_case}.h"

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


// *****************************************************************************
// *****************************************************************************
// Section: ${SPW_INSTANCE_NAME} Types
// *****************************************************************************
// *****************************************************************************
/* SPW TCH Interrupt status mask
   Summary:
    Identifies the SPW TCH Interrupt status mask.

   Description:
    This data type identifies the SPW TCH Interrupt status mask.
*/
typedef uint32_t SPW_TCH_INT_MASK;

#define SPW_TCH_INT_MASK_TCEVENT              (SPW_TCH_PI_RM_TCEVENT_Msk)
#define SPW_TCH_INT_MASK_TIMECODE             (SPW_TCH_PI_RM_TIMECODE_Msk)
#define SPW_TCH_INT_MASK_ANYTIMECODE          (SPW_TCH_PI_RM_ANYTIMECODE_Msk)
#define SPW_TCH_INT_MASK_LATEWD               (SPW_TCH_PI_RM_LATEWD_Msk)
#define SPW_TCH_INT_MASK_EARLYWD              (SPW_TCH_PI_RM_EARLYWD_Msk)
#define SPW_TCH_INT_MASK_INVALID              (0xFFFFFFFFUL)

// *****************************************************************************
/* SPW TCH Selected link for sender or listener
   Summary:
    Identifies the SPW TCH Selected link for sender or listener.

   Description:
    This data type identifies the SPW TCH Selected link for sender or listener.
*/
typedef uint32_t SPW_TCH_SEL_LINK_MASK;

#define SPW_TCH_SEL_LINK_MASK_L1                                    (0x01UL)
#define SPW_TCH_SEL_LINK_MASK_L2                                    (0x02UL)
#define SPW_TCH_SEL_LINK_MASK_INVALID                               (0xFFFFFFFFUL)

// *****************************************************************************
/* SPW TCH Configure restart input
   Summary:
    Identifies the SPW TCH Configure restart input.

   Description:
    This data type identifies the SPW TCH Configure restart input event.
*/
typedef enum
{
    SPW_TCH_CFG_RESTART_IN_PPS = 0,
    SPW_TCH_CFG_RESTART_IN_EVENT = 1,
    /* Force the compiler to reserve 32-bit memory for enum */
    SPW_TCH_CFG_RESTART_IN_INVALID = 0xFFFFFFFFUL
} SPW_TCH_CFG_RESTART_IN;

// *****************************************************************************
// *****************************************************************************
// Section: Interface Routines
// *****************************************************************************
// *****************************************************************************
/*
 * The following functions make up the methods (set of possible operations) of
 * this interface.
 */

void ${SPW_INSTANCE_NAME}_TCH_LinkListenerSet(SPW_TCH_SEL_LINK_MASK links);

void ${SPW_INSTANCE_NAME}_TCH_LinkSenderSet(SPW_TCH_SEL_LINK_MASK links);

void ${SPW_INSTANCE_NAME}_TCH_ConfigureEvent(SPW_SYNC_EVENT_MASK eventMask);

void ${SPW_INSTANCE_NAME}_TCH_ConfigureRestart(uint8_t timeCodeValue, bool oneshot, SPW_TCH_CFG_RESTART_IN inputEvent, SPW_SYNC_EVENT_MASK eventMask);

void ${SPW_INSTANCE_NAME}_TCH_ConfigureTcEvent(uint8_t timeCodeMask, uint8_t timeCodeValue);

void ${SPW_INSTANCE_NAME}_TCH_ConfigureWatchdog(uint16_t earlyNumTick, uint16_t lateNumTick);

void ${SPW_INSTANCE_NAME}_TCH_LastTimeCodeSet(uint8_t timeCode, bool now);

uint8_t ${SPW_INSTANCE_NAME}_TCH_LastTimeCodeGet(void);

SPW_TCH_INT_MASK ${SPW_INSTANCE_NAME}_TCH_IrqStatusGetMaskedAndClear(void);

void ${SPW_INSTANCE_NAME}_TCH_InterruptEnable(SPW_TCH_INT_MASK interruptMask);

void ${SPW_INSTANCE_NAME}_TCH_InterruptDisable(SPW_TCH_INT_MASK interruptMask);

// DOM-IGNORE-BEGIN
#ifdef __cplusplus  // Provide C++ Compatibility
}
#endif
// DOM-IGNORE-END

#endif /* PLIB_${SPW_INSTANCE_NAME}_TCH_H */
