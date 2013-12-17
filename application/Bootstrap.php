<?php

class Bootstrap extends Zend_Application_Bootstrap_Bootstrap
{
    public function _initView()
    {
        $paths = $this->getOption('paths');
        // setup the view renderer
        $vr = new Zend_Controller_Action_Helper_ViewRenderer();
        $vr->setView(new Templater($paths));
        $vr->setViewSuffix('tpl');
        Zend_Controller_Action_HelperBroker::addHelper($vr);
    }

}

