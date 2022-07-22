# SPW_RMAP_STATUS

```c
typedef enum
{
    SPW_RMAP_STATUS_ERRCODE_MASK = SPW_RMAP1_STS_RC_ERRCODE_Msk,
    SPW_RMAP_STATUS_VALID = SPW_RMAP1_STS_RC_VALID_Msk,
    /* Force the compiler to reserve 32-bit memory for enum */
    SPW_RMAP_STATUS_INVALID = 0xFFFFFFFF
} SPW_RMAP_STATUS;
```

**Summary**

Identifies the SPW RMAP current status

**Description**

This data type identifies the SPW RMAP status
