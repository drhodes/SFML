{-# LANGUAGE CPP, ForeignFunctionInterface #-}
module SFML.Graphics.Rect
(
    SFFloatRect(..)
,   SFIntRect(..)
,   Rect(..)
,   floatRectContains
,   intRectContains
)
where


import Foreign.C.Types
import Foreign.Marshal.Alloc (alloca)
import Foreign.Marshal.Utils (with)
import Foreign.Ptr (Ptr)
import Foreign.Storable
import System.IO.Unsafe

#include <SFML/Graphics/Rect.h>


sizeInt = #{size int}
sizeFloat = #{size float}


-- | Utility class for manipulating rectangles.
data SFFloatRect = SFFloatRect
    { fleft   :: Float
    , ftop    :: Float
    , fwidth  :: Float
    , fheight :: Float
    }


instance Storable SFFloatRect where
    sizeOf _ = 4 * sizeFloat
    alignment _ = alignment (undefined :: CFloat)
    
    peek ptr = do
        l <- #{peek sfFloatRect, left} ptr
        t <- #{peek sfFloatRect, top} ptr
        w <- #{peek sfFloatRect, width} ptr
        h <- #{peek sfFloatRect, height} ptr
        return $ SFFloatRect l t w h
    
    poke ptr (SFFloatRect l t w h) = do
        #{poke sfFloatRect, left} ptr l
        #{poke sfFloatRect, top} ptr t
        #{poke sfFloatRect, width} ptr w
        #{poke sfFloatRect, height} ptr h


-- | Utility class for manipulating rectangles.
data SFIntRect = SFIntRect
    { ileft   :: Int
    , itop    :: Int
    , iwidth  :: Int
    , iheight :: Int
    }


instance Storable SFIntRect where
    sizeOf _ = 4 * sizeInt
    alignment _ = alignment (undefined :: CInt)
    
    peek ptr = do
        l <- #{peek sfIntRect, left} ptr
        t <- #{peek sfIntRect, top} ptr
        w <- #{peek sfIntRect, width} ptr
        h <- #{peek sfIntRect, height} ptr
        return $ SFIntRect l t w h
    
    poke ptr (SFIntRect l t w h) = do
        #{poke sfIntRect, left} ptr l
        #{poke sfIntRect, top} ptr t
        #{poke sfIntRect, width} ptr w
        #{poke sfIntRect, height} ptr h


-- | Check if a point is inside a rectangle's area.
floatRectContains
    :: Float -- ^ X coordinate of the point to test
    -> Float -- ^ Y coordinate of the point to test
    -> SFFloatRect -- ^ Rectangle to test
    -> Bool

floatRectContains x y r = unsafeDupablePerformIO $ fmap (/=0) . with r $ \ptr -> sfFloatRect_contains ptr x y

foreign import ccall unsafe "sfFloatRect_contains"
    sfFloatRect_contains :: Ptr SFFloatRect -> Float -> Float -> IO CInt

--CSFML_GRAPHICS_API sfBool sfFloatRect_contains(const sfFloatRect* rect, float x, float y);


-- | Check if a point is inside a rectangle's area.
intRectContains
    :: Int -- ^ X coordinate of the point to test
    -> Int -- ^ Y coordinate of the point to test
    -> SFIntRect -- ^ Rectangle to test
    -> Bool

intRectContains x y r = unsafeDupablePerformIO $ fmap (/=0) . with r $ \ptr -> sfIntRect_contains ptr x y

foreign import ccall unsafe "sfIntRect_contains"
    sfIntRect_contains :: Ptr SFIntRect -> Int -> Int -> IO CInt

--CSFML_GRAPHICS_API sfBool sfIntRect_contains(const sfIntRect* rect, int x, int y);


class Rect a where
    -- | Check intersection between two rectangles.
    intersectRect
        :: a -- ^ First rectangle to test
        -> a -- ^ Second rectangle to test
        -> Maybe a -- ^ Overlapping rect


instance Rect SFFloatRect where
    
    intersectRect r1 r2 = unsafeDupablePerformIO $
        alloca $ \ptr1 ->
        alloca $ \ptr2 ->
        alloca $ \ptrOut -> do
        poke ptr1 r1
        poke ptr2 r2
        result <- sfFloatRect_intersects ptr1 ptr2 ptrOut
        case result of
            0 -> return Nothing
            _ -> peek ptrOut >>= return . Just


foreign import ccall unsafe "sfFloatRect_intersects"
    sfFloatRect_intersects :: Ptr SFFloatRect -> Ptr SFFloatRect -> Ptr SFFloatRect -> IO CInt

--CSFML_GRAPHICS_API sfBool sfFloatRect_intersects(const sfFloatRect* rect1, const sfFloatRect* rect2, sfFloatRect* intersection);


instance Rect SFIntRect where
    
    intersectRect r1 r2 = unsafeDupablePerformIO $
        alloca $ \ptr1 ->
        alloca $ \ptr2 ->
        alloca $ \ptrOut -> do
        poke ptr1 r1
        poke ptr2 r2
        result <- sfIntRect_intersects ptr1 ptr2 ptrOut
        case result of
            0 -> return Nothing
            _ -> peek ptrOut >>= return . Just


foreign import ccall unsafe "sfIntRect_intersects"
    sfIntRect_intersects :: Ptr SFIntRect -> Ptr SFIntRect -> Ptr SFIntRect -> IO CInt

--CSFML_GRAPHICS_API sfBool sfIntRect_intersects(const sfIntRect* rect1, const sfIntRect* rect2, sfIntRect* intersection);
