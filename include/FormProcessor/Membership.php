<?php
class FormProcessor_Membership extends FormProcessor
{
    protected $db = null;
    protected $projectUser = null;

    public function __construct($db, $userId)
    {
        parent::__construct();

        $this->db = $db;
        $this->projectUser = new DatabaseObject_ProjectUser($db);
        $this->projectUser->creator = $userId;
    }

    public function process(Zend_Controller_Request_Abstract $request)
    {
        $this->projectId = $request->getPost('pid');

        if($this->projectId < 0)
            $this->addError('projectid', '项目ID不能为空');
        else
            $this->projectUser->projectid = $this->projectId;

        $this->userId = $request->getPost('uid');

        if($this->userId < 0)
            $this->addError('userid', '用户ID不能为空');
        else
            $this->projectUser->uid = $this->userId;

        if($this->projectUser->userExists())
            $this->addError('exsits', '相同的项目成员');

        if(!$this->hasError())
            $this->projectUser->save(false);

        // return true if no errors have occurred
        return !$this->hasError();
    }
}
