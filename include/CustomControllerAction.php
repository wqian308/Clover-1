<?php
    class CustomControllerAction extends Zend_Controller_Action
    {
        public $db;
        public $messenger;
        public $bootstrap;

        public function init()
        {
            $this->bootstrap = $this->getInvokeArg('bootstrap');
            $this->db = $this->bootstrap->db;
            $this->logger = $this->bootstrap->log;
            Zend_Registry::set('logger', $this->logger);

            $this->messenger = $this->_helper->_flashMessenger;
        }

        public function getUrl($action = null, $controller = null)
        {
            $url = $this->_helper->url->simple($action, $controller);

            return $url;
        }

        public function getCustomUrl($options, $route = null)
        {
            return $this->_helper->url->url($options, $route);
        }

        public function preDispatch()
        {
            $auth = Zend_Auth::getInstance();
            if ($auth->hasIdentity()) {
                $this->view->authenticated = true;
                $this->view->identity = $auth->getIdentity();
            }
            else
                $this->view->authenticated = false;
        }

        public function postDispatch()
        {
            $this->view->messages = $this->messenger->getMessages();
            $this->view->isXmlHttpRequest = $this->getRequest()->isXmlHttpRequest();
/*
            $corsConfigs = $this->bootstrap->getOption('cors');
            $origin = in_array($this->getRequest()->getServer('HTTP_ORIGIN'),
                               explode('|',$corsConfigs['origin'])) ? $this->getRequest()->getServer('HTTP_ORIGIN') : '';

            $this->getResponse()->setHeader('Access-Control-Allow-Origin', $origin);
            $this->getResponse()->setHeader('Access-Control-Allow-Methods', $corsConfigs['method']);
            $this->getResponse()->setHeader('Access-Control-Allow-Credentials', $corsConfigs['credential']);
*/
        }

        public function sendErrors($data = array())
        {
            $obj = array();
            $obj[ 'err_code' ] = '1';
            $obj[ 'err_msg' ] = 'Errors';
            $obj['data'] = $data;

            $this->sendJson($obj);
        }

        public function sendResults($data = array())
        {
            $obj = array();
            $obj[ 'err_code' ] = '0';
            $obj[ 'err_msg' ] = 'Success';
            $obj[ 'data' ] = $data;

            $this->sendJson($obj);
        }

        public function sendJson($data)
        {
            die($this->_helper->json->sendJson($data));
            /*
            $this->_helper->viewRenderer->setNoRender();
            $this->getResponse()->setHeader('content-type', 'application/json');
            Zend_Json::encode($data);
            */
        }
    }
?>