<?php
class SectionController extends CustomControllerAction
{
    public function init()
    {
        parent::init();

        $this->identity = Zend_Auth::getInstance()->getIdentity();
    }

    public function editAction()
    {
        $request = $this->getRequest();

        if($request->isPost()) {
            $fp = new FormProcessor_Section($this->db, $request->getPost('section_id'));
            if($fp->process($request))
                $this->sendResults();
            else
                $this->sendErrors($fp->getErrors());
        }

        $this->sendErrors(array('GET', '不处理GET请求'));
    }

}
