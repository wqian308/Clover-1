<?php
class FormProcessor_Follower extends FormProcessor
{
    protected $db = null;
    protected $follower = null;

    public function __construct($db, $userId)
    {
        parent::__construct();

        $this->db = $db;
        $this->follower = new DatabaseObject_Followers($db);
        $this->follower->creator = $userId;
    }

    public function process(Zend_Controller_Request_Abstract $request)
    {
        $this->projectId = $request->getPost('pid');

        if($this->projectId < 0)
            $this->addError('projectid', '项目ID不能为空');
        else
            $this->follower->projectid = $this->projectId;

        $this->userId = $request->getPost('uid');

        if($this->userId < 0)
            $this->addError('userid', '用户ID不能为空');
        else
            $this->follower->uid = $this->userId;

        $this->todoId = $request->getPost('tid');

        if($this->todoId < 0)
            $this->addError('todoId', '任务ID不能为空');
        else
            $this->follower->tid = $this->todoId;

        if($this->follower->userExists())
            $this->addError('exsits', '相同的任务成员');

        if(!$this->hasError())
            $this->follower->save(false);

        // return true if no errors have occurred
        return !$this->hasError();
    }
}
