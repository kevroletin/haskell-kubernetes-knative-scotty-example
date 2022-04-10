{-# LANGUAGE OverloadedStrings #-}

module Main where

import            Lib
import            Data.Maybe         (fromMaybe)
import            Data.Monoid        ((<>))
import qualified  Data.Text.Lazy as T
import            System.Environment (lookupEnv)
import            System.IO          (hPrint, stderr)
import            Web.Scotty         (ActionM, ScottyM, scotty, body, middleware)
import            Web.Scotty.Trans   (html, get, post)
import            Control.Monad.IO.Class (liftIO)
import            Network.Wai.Middleware.RequestLogger

main :: IO ()
main = scotty 3000 $ do
  middleware logStdoutDev
  get "/" htmlHello
  post "/" printReqBody

printReqBody :: ActionM()
printReqBody = do
  b <- body
  liftIO (hPrint stderr b)

htmlHello :: ActionM()
htmlHello = html $ mconcat ["<!DOCTYPE html><html><head><title>"
                           ,"Haskell Kubernetes"
                           ,"</title></head><body><h1>"
                           ,"Hello World"
                           , "</h1></body></html>"]
