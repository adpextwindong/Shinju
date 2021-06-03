module Shinju.Script.Task
    ( module Shinju.Script.Task
    ) where

-- Ideas from Declarative Scripting in Haskell by Taim Bauer and Martin Erwig

import Control.Monad.Reader
import Control.Monad.Trans.Except
import Data.Typeable

newtype Task e a = T (ReaderT e IO a)

type Message = String
type Trace = [Tag]
type Tag = String

data TaskException = TaskException Message Trace
    deriving Typeable

runTask :: e -> Task e a -> IO a
runTask e (T t) = runReaderT t e

instance Monad (Task e) where
    return      = T. return
    m >>= k     = T . ReaderT $ \r -> do { a <- runTask r m; runTask r (k a) }
    -- fail        = taskFail --NOTE The paper talks about this but I think its old

taskFail = undefined
