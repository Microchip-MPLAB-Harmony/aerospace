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
#include <stdbool.h>
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
#define SPW_LINK_GET_STATE(status) ( (SPW_LINK_STATE)(uint8_t)( ((status) & SPW_LINK_STATUS_LINKSTATE_MASK) >> SPW_LINK1_STATUS_LINKSTATE_Pos ) )

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
    SPW_LINK_INVALID = 0xFFFFFFFFUL
} SPW_LINK;

// *****************************************************************************
/* SPW LINK status
   Summary:
    Identifies the SPW LINK current status

   Description:
    This data type identifies the SPW LINK status
*/
typedef uint32_t SPW_LINK_STATUS;

#define SPW_LINK_STATUS_LINKSTATE_MASK           (SPW_LINK1_STATUS_LINKSTATE_Msk)
#define SPW_LINK_STATUS_TXDEFDIV_MASK            (SPW_LINK1_STATUS_TXDEFDIV_Msk)
#define SPW_LINK_STATUS_TXEMPTY                  (SPW_LINK1_STATUS_TXEMPTY_Msk)
#define SPW_LINK_STATUS_GOTNULL                  (SPW_LINK1_STATUS_GOTNULL_Msk)
#define SPW_LINK_STATUS_GOTFCT                   (SPW_LINK1_STATUS_GOTFCT_Msk)
#define SPW_LINK_STATUS_GOTNCHAR                 (SPW_LINK1_STATUS_GOTNCHAR_Msk)
#define SPW_LINK_STATUS_SEEN0                    (SPW_LINK1_STATUS_SEEN0_Msk)
#define SPW_LINK_STATUS_SEEN1                    (SPW_LINK1_STATUS_SEEN1_Msk)
#define SPW_LINK_STATUS_SEEN2                    (SPW_LINK1_STATUS_SEEN2_Msk)
#define SPW_LINK_STATUS_SEEN3                    (SPW_LINK1_STATUS_SEEN3_Msk)
#define SPW_LINK_STATUS_SEEN4                    (SPW_LINK1_STATUS_SEEN4_Msk)
#define SPW_LINK_STATUS_SEEN5                    (SPW_LINK1_STATUS_SEEN5_Msk)
#define SPW_LINK_STATUS_INVALID                  (0xFFFFFFFFUL)


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
    SPW_LINK_STATE_INVALID = 0xFFFFFFFFUL
} SPW_LINK_STATE;

// *****************************************************************************
/* SPW LINK IRQ status
   Summary:
    Identifies the SPW LINK IRQ event that have pending interrupt

   Description:
    This data type identifies the SPW LINK IRQ event that have pending interrupt
*/
typedef uint32_t SPW_LINK_INT_MASK;

#define SPW_LINK_INT_MASK_DISERR                (SPW_LINK1_PI_RM_DISERR_Msk)
#define SPW_LINK_INT_MASK_PARERR                (SPW_LINK1_PI_RM_PARERR_Msk)
#define SPW_LINK_INT_MASK_ESCERR                (SPW_LINK1_PI_RM_ESCERR_Msk)
#define SPW_LINK_INT_MASK_CRERR                 (SPW_LINK1_PI_RM_CRERR_Msk)
#define SPW_LINK_INT_MASK_LINKABORT             (SPW_LINK1_PI_RM_LINKABORT_Msk)
#define SPW_LINK_INT_MASK_EEPTRANS              (SPW_LINK1_PI_RM_EEPTRANS_Msk)
#define SPW_LINK_INT_MASK_EEPREC                (SPW_LINK1_PI_RM_EEPREC_Msk)
#define SPW_LINK_INT_MASK_DISCARD               (SPW_LINK1_PI_RM_DISCARD_Msk)
#define SPW_LINK_INT_MASK_ESCEVENT2             (SPW_LINK1_PI_RM_ESCEVENT2_Msk)
#define SPW_LINK_INT_MASK_ESCEVENT1             (SPW_LINK1_PI_RM_ESCEVENT1_Msk)
#define SPW_LINK_INT_MASK_INVALID               (0xFFFFFFFFUL)


// *****************************************************************************
/* SPW LINK Distributed interrupts mask
   Summary:
    Identifies the SPW LINK Distributed interrupts fields.

   Description:
    This data type identifies the SPW LINK Distributed interrupts fields.
*/
typedef uint32_t SPW_LINK_DIST_INT_MASK;

#define SPW_LINK_DIST_INT_MASK_D0              (SPW_LINK1_DISTINTPI_RM_DI0_Msk)
#define SPW_LINK_DIST_INT_MASK_D1              (SPW_LINK1_DISTINTPI_RM_DI1_Msk)
#define SPW_LINK_DIST_INT_MASK_D2              (SPW_LINK1_DISTINTPI_RM_DI2_Msk)
#define SPW_LINK_DIST_INT_MASK_D3              (SPW_LINK1_DISTINTPI_RM_DI3_Msk)
#define SPW_LINK_DIST_INT_MASK_D4              (SPW_LINK1_DISTINTPI_RM_DI4_Msk)
#define SPW_LINK_DIST_INT_MASK_D5              (SPW_LINK1_DISTINTPI_RM_DI5_Msk)
#define SPW_LINK_DIST_INT_MASK_D6              (SPW_LINK1_DISTINTPI_RM_DI6_Msk)
#define SPW_LINK_DIST_INT_MASK_D7              (SPW_LINK1_DISTINTPI_RM_DI7_Msk)
#define SPW_LINK_DIST_INT_MASK_D8              (SPW_LINK1_DISTINTPI_RM_DI8_Msk)
#define SPW_LINK_DIST_INT_MASK_D9              (SPW_LINK1_DISTINTPI_RM_DI9_Msk)
#define SPW_LINK_DIST_INT_MASK_D10             (SPW_LINK1_DISTINTPI_RM_DI10_Msk)
#define SPW_LINK_DIST_INT_MASK_D11             (SPW_LINK1_DISTINTPI_RM_DI11_Msk)
#define SPW_LINK_DIST_INT_MASK_D12             (SPW_LINK1_DISTINTPI_RM_DI12_Msk)
#define SPW_LINK_DIST_INT_MASK_D13             (SPW_LINK1_DISTINTPI_RM_DI13_Msk)
#define SPW_LINK_DIST_INT_MASK_D14             (SPW_LINK1_DISTINTPI_RM_DI14_Msk)
#define SPW_LINK_DIST_INT_MASK_D15             (SPW_LINK1_DISTINTPI_RM_DI15_Msk)
#define SPW_LINK_DIST_INT_MASK_D16             (SPW_LINK1_DISTINTPI_RM_DI16_Msk)
#define SPW_LINK_DIST_INT_MASK_D17             (SPW_LINK1_DISTINTPI_RM_DI17_Msk)
#define SPW_LINK_DIST_INT_MASK_D18             (SPW_LINK1_DISTINTPI_RM_DI18_Msk)
#define SPW_LINK_DIST_INT_MASK_D19             (SPW_LINK1_DISTINTPI_RM_DI19_Msk)
#define SPW_LINK_DIST_INT_MASK_D20             (SPW_LINK1_DISTINTPI_RM_DI20_Msk)
#define SPW_LINK_DIST_INT_MASK_D21             (SPW_LINK1_DISTINTPI_RM_DI21_Msk)
#define SPW_LINK_DIST_INT_MASK_D22             (SPW_LINK1_DISTINTPI_RM_DI22_Msk)
#define SPW_LINK_DIST_INT_MASK_D23             (SPW_LINK1_DISTINTPI_RM_DI23_Msk)
#define SPW_LINK_DIST_INT_MASK_D24             (SPW_LINK1_DISTINTPI_RM_DI24_Msk)
#define SPW_LINK_DIST_INT_MASK_D25             (SPW_LINK1_DISTINTPI_RM_DI25_Msk)
#define SPW_LINK_DIST_INT_MASK_D26             (SPW_LINK1_DISTINTPI_RM_DI26_Msk)
#define SPW_LINK_DIST_INT_MASK_D27             (SPW_LINK1_DISTINTPI_RM_DI27_Msk)
#define SPW_LINK_DIST_INT_MASK_D28             (SPW_LINK1_DISTINTPI_RM_DI28_Msk)
#define SPW_LINK_DIST_INT_MASK_D29             (SPW_LINK1_DISTINTPI_RM_DI29_Msk)
#define SPW_LINK_DIST_INT_MASK_D30             (SPW_LINK1_DISTINTPI_RM_DI30_Msk)
#define SPW_LINK_DIST_INT_MASK_D31             (SPW_LINK1_DISTINTPI_RM_DI31_Msk)
#define SPW_LINK_DIST_INT_MASK_ALL             (SPW_LINK1_DISTINTPI_RM_Msk)

// *****************************************************************************
/* SPW LINK Distributed Acknowledge interrupts
   Summary:
    Identifies the SPW LINK Distributed Acknowledge interrupts fields.

   Description:
    This data type identifies the SPW LINK Distributed Acknowledge interrupts fields.
*/
typedef uint32_t SPW_LINK_DIST_ACK_MASK;

 #define SPW_LINK_DIST_ACK_MASK_D0             (SPW_LINK1_DISTACKPI_RM_DA0_Msk)
 #define SPW_LINK_DIST_ACK_MASK_D1             (SPW_LINK1_DISTACKPI_RM_DA1_Msk)
 #define SPW_LINK_DIST_ACK_MASK_D2             (SPW_LINK1_DISTACKPI_RM_DA2_Msk)
 #define SPW_LINK_DIST_ACK_MASK_D3             (SPW_LINK1_DISTACKPI_RM_DA3_Msk)
 #define SPW_LINK_DIST_ACK_MASK_D4             (SPW_LINK1_DISTACKPI_RM_DA4_Msk)
 #define SPW_LINK_DIST_ACK_MASK_D5             (SPW_LINK1_DISTACKPI_RM_DA5_Msk)
 #define SPW_LINK_DIST_ACK_MASK_D6             (SPW_LINK1_DISTACKPI_RM_DA6_Msk)
 #define SPW_LINK_DIST_ACK_MASK_D7             (SPW_LINK1_DISTACKPI_RM_DA7_Msk)
 #define SPW_LINK_DIST_ACK_MASK_D8             (SPW_LINK1_DISTACKPI_RM_DA8_Msk)
 #define SPW_LINK_DIST_ACK_MASK_D9             (SPW_LINK1_DISTACKPI_RM_DA9_Msk)
 #define SPW_LINK_DIST_ACK_MASK_D10            (SPW_LINK1_DISTACKPI_RM_DA10_Msk)
 #define SPW_LINK_DIST_ACK_MASK_D11            (SPW_LINK1_DISTACKPI_RM_DA11_Msk)
 #define SPW_LINK_DIST_ACK_MASK_D12            (SPW_LINK1_DISTACKPI_RM_DA12_Msk)
 #define SPW_LINK_DIST_ACK_MASK_D13            (SPW_LINK1_DISTACKPI_RM_DA13_Msk)
 #define SPW_LINK_DIST_ACK_MASK_D14            (SPW_LINK1_DISTACKPI_RM_DA14_Msk)
 #define SPW_LINK_DIST_ACK_MASK_D15            (SPW_LINK1_DISTACKPI_RM_DA15_Msk)
 #define SPW_LINK_DIST_ACK_MASK_D16            (SPW_LINK1_DISTACKPI_RM_DA16_Msk)
 #define SPW_LINK_DIST_ACK_MASK_D17            (SPW_LINK1_DISTACKPI_RM_DA17_Msk)
 #define SPW_LINK_DIST_ACK_MASK_D18            (SPW_LINK1_DISTACKPI_RM_DA18_Msk)
 #define SPW_LINK_DIST_ACK_MASK_D19            (SPW_LINK1_DISTACKPI_RM_DA19_Msk)
 #define SPW_LINK_DIST_ACK_MASK_D20            (SPW_LINK1_DISTACKPI_RM_DA20_Msk)
 #define SPW_LINK_DIST_ACK_MASK_D21            (SPW_LINK1_DISTACKPI_RM_DA21_Msk)
 #define SPW_LINK_DIST_ACK_MASK_D22            (SPW_LINK1_DISTACKPI_RM_DA22_Msk)
 #define SPW_LINK_DIST_ACK_MASK_D23            (SPW_LINK1_DISTACKPI_RM_DA23_Msk)
 #define SPW_LINK_DIST_ACK_MASK_D24            (SPW_LINK1_DISTACKPI_RM_DA24_Msk)
 #define SPW_LINK_DIST_ACK_MASK_D25            (SPW_LINK1_DISTACKPI_RM_DA25_Msk)
 #define SPW_LINK_DIST_ACK_MASK_D26            (SPW_LINK1_DISTACKPI_RM_DA26_Msk)
 #define SPW_LINK_DIST_ACK_MASK_D27            (SPW_LINK1_DISTACKPI_RM_DA27_Msk)
 #define SPW_LINK_DIST_ACK_MASK_D28            (SPW_LINK1_DISTACKPI_RM_DA28_Msk)
 #define SPW_LINK_DIST_ACK_MASK_D29            (SPW_LINK1_DISTACKPI_RM_DA29_Msk)
 #define SPW_LINK_DIST_ACK_MASK_D30            (SPW_LINK1_DISTACKPI_RM_DA30_Msk)
 #define SPW_LINK_DIST_ACK_MASK_D31            (SPW_LINK1_DISTACKPI_RM_DA31_Msk)
 #define SPW_LINK_DIST_ACK_MASK_ALL            (SPW_LINK1_DISTACKPI_RM_Msk)

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

SPW_LINK_DIST_INT_MASK ${SPW_INSTANCE_NAME}_LINK_DistIrqStatusGetMaskedAndClear(SPW_LINK link);

void ${SPW_INSTANCE_NAME}_LINK_DistInterruptEnable(SPW_LINK link, SPW_LINK_DIST_INT_MASK interruptMask);

void ${SPW_INSTANCE_NAME}_LINK_DistInterruptDisable(SPW_LINK link, SPW_LINK_DIST_INT_MASK interruptMask);

SPW_LINK_DIST_ACK_MASK ${SPW_INSTANCE_NAME}_LINK_DistAckIrqStatusGetMaskedAndClear(SPW_LINK link);

void ${SPW_INSTANCE_NAME}_LINK_DistAckInterruptEnable(SPW_LINK link, SPW_LINK_DIST_ACK_MASK interruptMask);

void ${SPW_INSTANCE_NAME}_LINK_DistAckInterruptDisable(SPW_LINK link, SPW_LINK_DIST_ACK_MASK interruptMask);

void ${SPW_INSTANCE_NAME}_LINK_EscapeCharEvent1Set(SPW_LINK link, bool active, uint8_t mask, uint8_t value);

void ${SPW_INSTANCE_NAME}_LINK_EscapeCharEvent2Set(SPW_LINK link, bool active, uint8_t mask, uint8_t value);

uint8_t ${SPW_INSTANCE_NAME}_LINK_LastRecvEscapeCharEvent1Get(SPW_LINK link);

uint8_t ${SPW_INSTANCE_NAME}_LINK_LastRecvEscapeCharEvent2Get(SPW_LINK link);

void ${SPW_INSTANCE_NAME}_LINK_TransmitEscapeChar(SPW_LINK link, uint8_t escChar);

</#if>

// DOM-IGNORE-BEGIN
#ifdef __cplusplus  // Provide C++ Compatibility
}
#endif
// DOM-IGNORE-END

#endif /* PLIB_${SPW_INSTANCE_NAME}_LINK_H */
