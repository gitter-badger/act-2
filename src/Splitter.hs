{-# LANGUAGE RecordWildCards #-}
module Splitter where

import Syntax
import RefinedAst
import Data.Map.Strict    (Map) -- abandon in favor of [(a,b)]?


data Implementation = Implementation
  {_contractBinaries :: Map Id Code,
   _storageLayout :: Map Id Layout
  }

type Code = (String, String)

data Layout = Layout {
  slot :: Int,
  offset :: Int,
  label :: Id,
  encoding :: Encoding,
  length :: Int
  }

data Encoding = Inplace | Mapping | DynamicArray | Bytes

data KSpec = KSpec {
  k :: KTerm,
  program :: String,
  jumpDests :: String,
  callData :: String,
  output :: ReturnExp,
  statusCode :: StatusCode,
  kreturn :: String
--  accounts :: Map Contract
}-- deriving (Ord, Eq, Read)

instance Show KSpec where
  show KSpec { .. }  = error "TODO"

data KTerm = Execute | Halt
  deriving (Ord, Eq, Read)

instance Show KTerm where
  show Execute = "execute"
  show Halt = "halt"

data StatusCode
  = EVMC_SUCCESS
  | EVMC_REVERT
  | EVMC_OOG
  deriving (Show, Ord, Eq, Read)
-- kaseSplit :: Behaviour -> SolcContract -> [KSpec]
-- kaseSplit = error "TODO"
