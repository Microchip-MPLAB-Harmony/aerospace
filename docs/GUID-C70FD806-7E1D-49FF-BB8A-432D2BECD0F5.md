# SPW_SYNC_EVENT_MASK

```c
typedef enum
{
    SPW_SYNC_EVENT_MASK_RTCOUT0 = 0x01,
    SPW_SYNC_EVENT_MASK_RTCOUT1 = 0x02,
    /* Force the compiler to reserve 32-bit memory for enum */
    SPW_SYNC_EVENT_MASK_INVALID = 0xFFFFFFFF
} SPW_SYNC_EVENT_MASK;
```

**Summary**

Identifies the SPW synchronization events mask

**Description**

This data type identifies the SPW synchronization events mask
