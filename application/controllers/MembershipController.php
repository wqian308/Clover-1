<?php
class MembershipController extends CustomControllerAction
{
    public function init()
    {
        parent::init();

        $this->identity = Zend_Auth::getInstance()->getIdentity();
    }

    public function editAction()
    {
        $request = $this->getRequest();

        $fp = new FormProcessor_Membership($this->db, $this->identity->userId);

        if($request->isPost()) {
            if($fp->process($request))
                $this->sendResults();
            else
                $this->sendErrors($fp->getErrors());
        }

        $this->sendErrors(array('get' => 'GET请求不做任何处理'));
    }
}
