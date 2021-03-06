{-# LANGUAGE DeriveDataTypeable #-}
module SFML.Graphics.CircleShape
(
    module SFML.Utils
,   CircleShapeException(..)
,   createCircleShape
,   copy
,   destroy
,   setPosition
,   setRotation
,   setScale
,   setOrigin
,   getPosition
,   getRotation
,   getScale
,   getOrigin
,   move
,   rotate
,   scale
,   getTransform
,   getInverseTransform
,   setTexture
,   setTextureRect
,   getTexture
,   getTextureRect
,   setFillColor
,   setOutlineColor
,   setOutlineThickness
,   getFillColor
,   getOutlineColor
,   getOutlineThickness
,   getPointCount
,   getPoint
,   setRadius
,   getRadius
,   setPointCount
,   getLocalBounds
,   getGlobalBounds
)
where


import SFML.Graphics.SFBounded
import SFML.Graphics.Color
import SFML.Graphics.Rect
import SFML.Graphics.SFShape
import SFML.Graphics.SFShapeResizable
import SFML.Graphics.SFTexturable
import SFML.Graphics.Transform
import SFML.Graphics.Transformable
import SFML.Graphics.Types
import SFML.SFCopyable
import SFML.SFResource
import SFML.System.Vector2
import SFML.Utils

import Control.Exception
import Control.Monad ((>=>))
import Data.Typeable
import Foreign.C.Types
import Foreign.Ptr (Ptr, nullPtr)
import Foreign.Marshal.Alloc (alloca)
import Foreign.Marshal.Utils (with)
import Foreign.Storable (peek)


checkNull :: CircleShape -> Maybe CircleShape
checkNull cs@(CircleShape ptr) = if ptr == nullPtr then Nothing else Just cs


checkNullTexture :: Texture -> Maybe Texture
checkNullTexture tex@(Texture ptr) = if ptr == nullPtr then Nothing else Just tex


data CircleShapeException = CircleShapeException String deriving (Show, Typeable)

instance Exception CircleShapeException


-- | Create a new circle shape.
createCircleShape :: IO (Either CircleShapeException CircleShape)
createCircleShape =
    let err = CircleShapeException "Failed creating circle shape"
    in fmap (tagErr err . checkNull) sfCircleShape_create

foreign import ccall unsafe "sfCircleShape_create"
    sfCircleShape_create :: IO CircleShape

-- \return A new sfCircleShape object, or NULL if it failed

--CSFML_GRAPHICS_API sfCircleShape* sfCircleShape_create(void);


instance SFCopyable CircleShape where

    {-# INLINABLE copy #-}
    copy = sfCircleShape_copy


foreign import ccall unsafe "sfCircleShape_copy"
    sfCircleShape_copy :: CircleShape -> IO CircleShape

--CSFML_GRAPHICS_API sfCircleShape* sfCircleShape_copy(sfCircleShape* shape);


instance SFResource CircleShape where

    {-# INLINABLE destroy #-}
    destroy = sfCircleShape_destroy

foreign import ccall unsafe "sfCircleShape_destroy"
    sfCircleShape_destroy :: CircleShape -> IO ()

--CSFML_GRAPHICS_API void sfCircleShape_destroy(sfCircleShape* shape);


instance Transformable CircleShape where

    {-# INLINABLE setPosition #-}
    setPosition c p = with p $ sfCircleShape_setPosition_helper c

    {-# INLINABLE setRotation #-}
    setRotation c r = sfCircleShape_setRotation c (realToFrac r)

    {-# INLINABLE setScale #-}
    setScale c s = with s $ sfCircleShape_setScale_helper c

    {-# INLINABLE setOrigin #-}
    setOrigin c o = with o $ sfCircleShape_setOrigin_helper c

    {-# INLINABLE getPosition #-}
    getPosition c = alloca $ \ptr -> sfCircleShape_getPosition_helper c ptr >> peek ptr

    {-# INLINABLE getRotation #-}
    getRotation = sfCircleShape_getRotation >=> return . realToFrac

    {-# INLINABLE getScale #-}
    getScale c = alloca $ \ptr -> sfCircleShape_getScale_helper c ptr >> peek ptr

    {-# INLINABLE getOrigin #-}
    getOrigin c = alloca $ \ptr -> sfCircleShape_getOrigin_helper c ptr >> peek ptr

    {-# INLINABLE move #-}
    move c off = with off $ sfCircleShape_move_helper c

    {-# INLINABLE rotate #-}
    rotate c a = sfCircleShape_rotate c (realToFrac a)

    {-# INLINABLE scale #-}
    scale c s = with s $ sfCircleShape_scale_helper c

    {-# INLINABLE getTransform #-}
    getTransform c = alloca $ \ptr -> sfCircleShape_getTransform_helper c ptr >> peek ptr

    {-# INLINABLE getInverseTransform #-}
    getInverseTransform c = alloca $ \ptr -> sfCircleShape_getInverseTransform_helper c ptr >> peek ptr


foreign import ccall unsafe "sfCircleShape_setPosition_helper"
    sfCircleShape_setPosition_helper :: CircleShape -> Ptr Vec2f -> IO ()

--CSFML_GRAPHICS_API void sfCircleShape_setPosition(sfCircleShape* shape, sfVector2f position);

foreign import ccall unsafe "sfCircleShape_setRotation"
    sfCircleShape_setRotation :: CircleShape -> CFloat -> IO ()

--CSFML_GRAPHICS_API void sfCircleShape_setRotation(sfCircleShape* shape, float angle);

foreign import ccall unsafe "sfCircleShape_setScale_helper"
    sfCircleShape_setScale_helper :: CircleShape -> Ptr Vec2f -> IO ()

--CSFML_GRAPHICS_API void sfCircleShape_setScale(sfCircleShape* shape, sfVector2f scale);

foreign import ccall unsafe "sfCircleShape_setOrigin_helper"
    sfCircleShape_setOrigin_helper :: CircleShape -> Ptr Vec2f -> IO ()

--CSFML_GRAPHICS_API void sfCircleShape_setOrigin(sfCircleShape* shape, sfVector2f origin);

foreign import ccall unsafe "sfCircleShape_getPosition_helper"
    sfCircleShape_getPosition_helper :: CircleShape -> Ptr Vec2f -> IO ()

--CSFML_GRAPHICS_API sfVector2f sfCircleShape_getPosition(const sfCircleShape* shape);

foreign import ccall unsafe "sfCircleShape_getRotation"
    sfCircleShape_getRotation :: CircleShape -> IO CFloat

--CSFML_GRAPHICS_API float sfCircleShape_getRotation(const sfCircleShape* shape);

foreign import ccall unsafe "sfCircleShape_getScale_helper"
    sfCircleShape_getScale_helper :: CircleShape -> Ptr Vec2f -> IO ()

--CSFML_GRAPHICS_API sfVector2f sfCircleShape_getScale(const sfCircleShape* shape);

foreign import ccall unsafe "sfCircleShape_getOrigin_helper"
    sfCircleShape_getOrigin_helper :: CircleShape -> Ptr Vec2f -> IO ()

--CSFML_GRAPHICS_API sfVector2f sfCircleShape_getOrigin(const sfCircleShape* shape);

foreign import ccall unsafe "sfCircleShape_move_helper"
    sfCircleShape_move_helper :: CircleShape -> Ptr Vec2f -> IO ()

--CSFML_GRAPHICS_API void sfCircleShape_move(sfCircleShape* shape, sfVector2f offset);

foreign import ccall unsafe "sfCircleShape_rotate"
    sfCircleShape_rotate :: CircleShape -> CFloat -> IO ()

--CSFML_GRAPHICS_API void sfCircleShape_rotate(sfCircleShape* shape, float angle);

foreign import ccall unsafe "sfCircleShape_scale_helper"
    sfCircleShape_scale_helper :: CircleShape -> Ptr Vec2f -> IO ()

--CSFML_GRAPHICS_API void sfCircleShape_scale(sfCircleShape* shape, sfVector2f factors);

foreign import ccall unsafe "sfCircleShape_getTransform_helper"
    sfCircleShape_getTransform_helper :: CircleShape -> Ptr Transform -> IO ()

--CSFML_GRAPHICS_API sfTransform sfCircleShape_getTransform(const sfCircleShape* shape);

foreign import ccall unsafe "sfCircleShape_getInverseTransform_helper"
    sfCircleShape_getInverseTransform_helper :: CircleShape -> Ptr Transform -> IO ()

--CSFML_GRAPHICS_API sfTransform sfCircleShape_getInverseTransform(const sfCircleShape* shape);


instance SFTexturable CircleShape where

    {-# INLINABLE setTexture #-}
    setTexture c tex reset = sfCircleShape_setTexture c tex (fromIntegral . fromEnum $ reset)

    {-# INLINABLE setTextureRect #-}
    setTextureRect c rect = with rect $ sfCircleShape_setTextureRect_helper c

    {-# INLINABLE getTexture #-}
    getTexture = sfCircleShape_getTexture >=> return . checkNullTexture

    {-# INLINABLE getTextureRect #-}
    getTextureRect c = alloca $ \ptr -> sfCircleShape_getTextureRect_helper c ptr >> peek ptr


foreign import ccall unsafe "sfCircleShape_setTexture"
    sfCircleShape_setTexture :: CircleShape -> Texture -> CInt -> IO ()

--CSFML_GRAPHICS_API void sfCircleShape_setTexture(sfCircleShape* shape, const sfTexture* texture, sfBool resetRect);

foreign import ccall unsafe "sfCircleShape_setTextureRect_helper"
    sfCircleShape_setTextureRect_helper :: CircleShape -> Ptr IntRect -> IO ()

--CSFML_GRAPHICS_API void sfCircleShape_setTextureRect(sfCircleShape* shape, sfIntRect rect);

foreign import ccall unsafe "sfCircleShape_getTexture"
    sfCircleShape_getTexture :: CircleShape -> IO Texture

--CSFML_GRAPHICS_API const sfTexture* sfCircleShape_getTexture(const sfCircleShape* shape);

foreign import ccall unsafe "sfCircleShape_getTextureRect_helper"
    sfCircleShape_getTextureRect_helper :: CircleShape -> Ptr IntRect -> IO ()

--CSFML_GRAPHICS_API sfIntRect sfCircleShape_getTextureRect(const sfCircleShape* shape);


instance SFShape CircleShape where

    {-# INLINABLE setFillColor #-}
    setFillColor c color = with color $ sfCircleShape_setFillColor_helper c

    {-# INLINABLE setOutlineColor #-}
    setOutlineColor c color = with color $ sfCircleShape_setOutlineColor_helper c

    {-# INLINABLE setOutlineThickness #-}
    setOutlineThickness c t = sfCircleShape_setOutlineThickness c (realToFrac t)

    {-# INLINABLE getFillColor #-}
    getFillColor c = alloca $ \ptr -> sfCircleShape_getFillColor_helper c ptr >> peek ptr

    {-# INLINABLE getOutlineColor #-}
    getOutlineColor c = alloca $ \ptr -> sfCircleShape_getOutlineColor_helper c ptr >> peek ptr

    {-# INLINABLE getOutlineThickness #-}
    getOutlineThickness = sfCircleShape_getOutlineThickness >=> return . realToFrac

    {-# INLINABLE getPointCount #-}
    getPointCount = sfCircleShape_getPointCount >=> return . fromIntegral

    {-# INLINABLE getPoint #-}
    getPoint c idx = alloca $ \ptr -> sfCircleShape_getPoint_helper c (fromIntegral idx) ptr >> peek ptr


foreign import ccall unsafe "sfCircleShape_setFillColor_helper"
    sfCircleShape_setFillColor_helper :: CircleShape -> Ptr Color -> IO ()

--CSFML_GRAPHICS_API void sfCircleShape_setFillColor(sfCircleShape* shape, sfColor color);

foreign import ccall unsafe "sfCircleShape_setOutlineColor_helper"
    sfCircleShape_setOutlineColor_helper :: CircleShape -> Ptr Color -> IO ()

--CSFML_GRAPHICS_API void sfCircleShape_setOutlineColor(sfCircleShape* shape, sfColor color);

foreign import ccall unsafe "sfCircleShape_setOutlineThickness"
    sfCircleShape_setOutlineThickness :: CircleShape -> CFloat -> IO ()

--CSFML_GRAPHICS_API void sfCircleShape_setOutlineThickness(sfCircleShape* shape, float thickness);

foreign import ccall unsafe "sfCircleShape_getFillColor_helper"
    sfCircleShape_getFillColor_helper :: CircleShape -> Ptr Color -> IO ()

--CSFML_GRAPHICS_API sfColor sfCircleShape_getFillColor(const sfCircleShape* shape);

foreign import ccall unsafe "sfCircleShape_getOutlineColor_helper"
    sfCircleShape_getOutlineColor_helper :: CircleShape -> Ptr Color -> IO ()

--CSFML_GRAPHICS_API sfColor sfCircleShape_getOutlineColor(const sfCircleShape* shape);

foreign import ccall unsafe "sfCircleShape_getOutlineThickness"
    sfCircleShape_getOutlineThickness :: CircleShape -> IO CFloat

--CSFML_GRAPHICS_API float sfCircleShape_getOutlineThickness(const sfCircleShape* shape);

foreign import ccall unsafe "sfCircleShape_getPointCount"
    sfCircleShape_getPointCount :: CircleShape -> IO CUInt

--CSFML_GRAPHICS_API unsigned int sfCircleShape_getPointCount(const sfCircleShape* shape);

foreign import ccall unsafe "sfCircleShape_getPoint_helper"
    sfCircleShape_getPoint_helper :: CircleShape -> CUInt -> Ptr Vec2f -> IO ()

--CSFML_GRAPHICS_API sfVector2f sfCircleShape_getPoint(const sfCircleShape* shape, unsigned int index);


-- | Set the radius of a circle.
setRadius
    :: CircleShape
    -> Float -- ^ New radius of the circle
    -> IO ()

setRadius c r = sfCircleShape_setRadius c (realToFrac r)

foreign import ccall unsafe "sfCircleShape_setRadius"
    sfCircleShape_setRadius :: CircleShape -> CFloat -> IO ()

--CSFML_GRAPHICS_API void sfCircleShape_setRadius(sfCircleShape* shape, float radius);


-- | Get the radius of a circle.
getRadius
    :: CircleShape
    -> IO Float -- ^ Radius of the circle

getRadius = sfCircleShape_getRadius >=> return . realToFrac

foreign import ccall unsafe "sfCircleShape_getRadius"
    sfCircleShape_getRadius :: CircleShape -> IO CFloat

--CSFML_GRAPHICS_API float sfCircleShape_getRadius(const sfCircleShape* shape);


instance SFShapeResizable CircleShape where

    {-# INLINABLE setPointCount #-}
    setPointCount c count = sfCircleShape_setPointCount c (fromIntegral count)


foreign import ccall unsafe "sfCircleShape_setPointCount"
    sfCircleShape_setPointCount :: CircleShape -> CUInt -> IO ()

--CSFML_GRAPHICS_API void sfCircleShape_setPointCount(sfCircleShape* shape, unsigned int count);


instance SFBounded CircleShape where

    {-# INLINABLE getLocalBounds #-}
    getLocalBounds c = alloca $ \ptr -> sfCircleShape_getLocalBounds_helper c ptr >> peek ptr

    {-# INLINABLE getGlobalBounds #-}
    getGlobalBounds c = alloca $ \ptr -> sfCircleShape_getGlobalBounds_helper c ptr >> peek ptr

foreign import ccall unsafe "sfCircleShape_getLocalBounds_helper"
    sfCircleShape_getLocalBounds_helper :: CircleShape -> Ptr FloatRect -> IO ()

--CSFML_GRAPHICS_API sfFloatRect sfCircleShape_getLocalBounds(const sfCircleShape* shape);

foreign import ccall unsafe "sfCircleShape_getGlobalBounds_helper"
    sfCircleShape_getGlobalBounds_helper :: CircleShape -> Ptr FloatRect -> IO ()

--CSFML_GRAPHICS_API sfFloatRect sfCircleShape_getGlobalBounds(const sfCircleShape* shape);
