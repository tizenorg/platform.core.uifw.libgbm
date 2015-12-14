#ifndef _GBM_TBM_H_
#define _GBM_TBM_H_

#include <gbm.h>
#include <tbm_surface.h>
#include <tbm_surface_queue.h>

tbm_surface_queue_h
gbm_tbm_get_surface_queue(struct gbm_surface* surf);

tbm_surface_h
gbm_tbm_get_surface(struct gbm_bo* bo);

#endif
