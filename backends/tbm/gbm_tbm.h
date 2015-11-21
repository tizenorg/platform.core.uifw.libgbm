#ifndef _GBM_TBM_H_
#define _GBM_TBM_H_

#include <gbm.h>

#ifdef USE_TBM_QUEUE
#include <tbm_surface.h>
#include <tbm_surface_queue.h>

tbm_surface_queue
gbm_tbm_get_surface_queue(struct gbm_surface* surf);

tbm_surface_h
gbm_tbm_get_surface(struct gbm_bo* bo);

#else
#include <tbm_bufmgr.h>

struct gbm_tbm_device;
struct gbm_tbm_bo;
struct gbm_tbm_surface;


void
gbm_tbm_device_set_callback_surface_has_free_buffers(struct gbm_tbm_device *gbm_tbm, int (*callback)(struct gbm_surface *));

void
gbm_tbm_device_set_callback_surface_lock_front_buffer(struct gbm_tbm_device *gbm_tbm, struct gbm_bo *(*callback)(struct gbm_surface *));

void
gbm_tbm_device_set_callback_surface_release_buffer(struct gbm_tbm_device *gbm_tbm, void (*callback)(struct gbm_surface *, struct gbm_bo *));

uint32_t
gbm_tbm_surface_get_width(struct gbm_tbm_surface *surf);

uint32_t
gbm_tbm_surface_get_height(struct gbm_tbm_surface *surf);

uint32_t
gbm_tbm_surface_get_format(struct gbm_tbm_surface *surf);

uint32_t
gbm_tbm_surface_get_flags(struct gbm_tbm_surface *surf);

void
gbm_tbm_surface_set_user_data(struct gbm_tbm_surface *surf, void *data);

void *
gbm_tbm_surface_get_user_data(struct gbm_tbm_surface *surf);

tbm_bo
gbm_tbm_bo_get_tbm_bo(struct gbm_tbm_bo *bo);

uint32_t
gbm_tbm_bo_get_stride(struct gbm_tbm_bo *bo);

#endif
#endif
