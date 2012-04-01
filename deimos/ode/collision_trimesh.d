/*************************************************************************
 *                          D bindings for ODE                           *
 *                                                                       *
 *       C header port by Daniel "q66" Kolesa <quaker66@gmail.com>       *
 *                                                                       *
 * Open Dynamics Engine, Copyright (C) 2001-2003 Russell L. Smith.       *
 * All rights reserved.  Email: russ@q12.org   Web: www.q12.org          *
 *                                                                       *
 * This library is free software; you can redistribute it and/or         *
 * modify it under the terms of EITHER:                                  *
 *   (1) The GNU Lesser General Public License as published by the Free  *
 *       Software Foundation; either version 2.1 of the License, or (at  *
 *       your option) any later version. The text of the GNU Lesser      *
 *       General Public License is included with this library in the     *
 *       file LICENSE.TXT.                                               *
 *   (2) The BSD-style license that is included with this library in     *
 *       the file LICENSE-BSD.TXT.                                       *
 *                                                                       *
 * This library is distributed in the hope that it will be useful,       *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of        *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the files    *
 * LICENSE.TXT and LICENSE-BSD.TXT for more details.                     *
 *                                                                       *
 *************************************************************************/

/*
 * TriMesh code by Erwin de Vries.
 *
 * Trimesh data.
 * This is where the actual vertexdata (pointers), and BV tree is stored.
 * Vertices should be single precision!
 * This should be more sophisticated, so that the user can easyly implement
 * another collision library, but this is a lot of work, and also costs some
 * performance because some data has to be copied.
 */

module deimos.ode.collision_trimesh;

private import deimos.ode.common;

extern (C):
nothrow:

/*
 * Data storage for triangle meshes.
 */
struct dxTriMeshData;
alias dxTriMeshData* dTriMeshDataID;

/*
 * These dont make much sense now, but they will later when we add more
 * features.
 */
dTriMeshDataID dGeomTriMeshDataCreate();
void dGeomTriMeshDataDestroy(dTriMeshDataID g);



enum { TRIMESH_FACE_NORMALS }
void  dGeomTriMeshDataSet(dTriMeshDataID g, int data_id, void* in_data);
void* dGeomTriMeshDataGet(dTriMeshDataID g, int data_id);

/**
 * We need to set the last transform after each time step for 
 * accurate collision response. These functions get and set that transform.
 * It is stored per geom instance, rather than per dTriMeshDataID.
 */
void dGeomTriMeshSetLastTransform(dGeomID g, dMatrix4 last_trans);
dReal* dGeomTriMeshGetLastTransform(dGeomID g);

/*
 * Build a TriMesh data object with single precision vertex data.
 */
void dGeomTriMeshDataBuildSingle(
    dTriMeshDataID g, in void* Vertices, int VertexStride, int VertexCount,
    in void* Indices, int IndexCount, int TriStride
);
/* same again with a normals array (used as trimesh-trimesh optimization) */
void dGeomTriMeshDataBuildSingle1(
    dTriMeshDataID g, in void* Vertices, int VertexStride, int VertexCount, 
    in void* Indices, int IndexCount, int TriStride, in void* Normals
);
/*
* Build a TriMesh data object with double precision vertex data.
*/
void dGeomTriMeshDataBuildDouble(
    dTriMeshDataID g, in void* Vertices, int VertexStride, int VertexCount,
    in void* Indices, int IndexCount, int TriStride
);
/* same again with a normals array (used as trimesh-trimesh optimization) */
void dGeomTriMeshDataBuildDouble1(
    dTriMeshDataID g, in void* Vertices,  int VertexStride,
    int VertexCount,  in void* Indices, int IndexCount,
    int TriStride, in void* Normals
);

/*
 * Simple build. Single/double precision based on dSINGLE/dDOUBLE!
 */
void dGeomTriMeshDataBuildSimple(
    dTriMeshDataID g, in dReal* Vertices, int VertexCount,
    in dTriIndex* Indices, int IndexCount
);
/* same again with a normals array (used as trimesh-trimesh optimization) */
void dGeomTriMeshDataBuildSimple1(
    dTriMeshDataID g, in dReal* Vertices, int VertexCount,
    in dTriIndex* Indices, int IndexCount, in int* Normals
);

/* Preprocess the trimesh data to remove mark unnecessary edges and vertices */
void dGeomTriMeshDataPreprocess(dTriMeshDataID g);
/* Get and set the internal preprocessed trimesh data buffer, for loading and saving */
void dGeomTriMeshDataGetBuffer(dTriMeshDataID g, ubyte** buf, int* bufLen);
void dGeomTriMeshDataSetBuffer(dTriMeshDataID g, ubyte*  buf);


/*
 * Per triangle callback. Allows the user to say if he wants a collision with
 * a particular triangle.
 */
alias int function(
    dGeomID TriMesh, dGeomID RefObject, int TriangleIndex
) dTriCallback;
void dGeomTriMeshSetCallback(dGeomID g, dTriCallback* Callback);
dTriCallback* dGeomTriMeshGetCallback(dGeomID g);

/*
 * Per object callback. Allows the user to get the list of triangles in 1
 * shot. Maybe we should remove this one.
 */
alias void function(
    dGeomID TriMesh, dGeomID RefObject, in int* TriIndicies, int TriCount
) dTriArrayCallback;
void dGeomTriMeshSetArrayCallback(dGeomID g, dTriArrayCallback* ArrayCallback);
dTriArrayCallback* dGeomTriMeshGetArrayCallback(dGeomID g);

/*
 * Ray callback.
 * Allows the user to say if a ray collides with a triangle on barycentric
 * coords. The user can for example sample a texture with alpha transparency
 * to determine if a collision should occur.
 */
alias int function(
    dGeomID TriMesh, dGeomID Ray, int TriangleIndex, dReal u, dReal v
) dTriRayCallback;
void dGeomTriMeshSetRayCallback(dGeomID g, dTriRayCallback* Callback);
dTriRayCallback* dGeomTriMeshGetRayCallback(dGeomID g);

/*
 * Triangle merging callback.
 * Allows the user to generate a fake triangle index for a new contact generated
 * from merging of two other contacts. That index could later be used by the 
 * user to determine attributes of original triangles used as sources for a 
 * merged contact.
 */
alias int function(
    dGeomID TriMesh, int FirstTriangleIndex, int SecondTriangleIndex
) dTriTriMergeCallback;
void dGeomTriMeshSetTriMergeCallback(dGeomID g, dTriTriMergeCallback* Callback);
dTriTriMergeCallback* dGeomTriMeshGetTriMergeCallback(dGeomID g);

/*
 * Trimesh class
 * Construction. Callbacks are optional.
 */
dGeomID dCreateTriMesh(
    dSpaceID space, dTriMeshDataID Data, dTriCallback* Callback,
    dTriArrayCallback* ArrayCallback, dTriRayCallback* RayCallback
);

void dGeomTriMeshSetData(dGeomID g, dTriMeshDataID Data);
dTriMeshDataID dGeomTriMeshGetData(dGeomID g);


// enable/disable/check temporal coherence
void dGeomTriMeshEnableTC(dGeomID g, int geomClass, int enable);
int dGeomTriMeshIsTCEnabled(dGeomID g, int geomClass);

/*
 * Clears the internal temporal coherence caches. When a geom has its
 * collision checked with a trimesh once, data is stored inside the trimesh.
 * With large worlds with lots of seperate objects this list could get huge.
 * We should be able to do this automagically.
 */
void dGeomTriMeshClearTCCache(dGeomID g);


/*
 * returns the TriMeshDataID
 */
dTriMeshDataID dGeomTriMeshGetTriMeshDataID(dGeomID g);

/*
 * Gets a triangle.
 */
void dGeomTriMeshGetTriangle(
    dGeomID g, int Index, dVector3* v0, dVector3* v1, dVector3* v2
);

/*
 * Gets the point on the requested triangle and the given barycentric
 * coordinates.
 */
void dGeomTriMeshGetPoint(
    dGeomID g, int Index, dReal u, dReal v, dVector3 Out
);

/*

This is how the strided data works:

struct StridedVertex{
    dVector3 Vertex;
    // Userdata
};
int VertexStride = sizeof(StridedVertex);

struct StridedTri{
    int Indices[3];
    // Userdata
};
int TriStride = sizeof(StridedTri);

*/


int dGeomTriMeshGetTriangleCount(dGeomID g);

void dGeomTriMeshDataUpdate(dTriMeshDataID g);
