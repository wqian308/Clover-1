<?php
class FormProcessor_Comment extends FormProcessor
{
    protected $db = null;
    public $comment = null;

    public function __construct($db, $userId)
    {
        parent::__construct();

        $this->db = $db;

        $this->comment = new DatabaseObject_Comment($db);
        $this->comment->creator = $userId;
        $this->comment->type = DatabaseObject_Comment::TYPE_COMMENT;
    }

    public function process(Zend_Controller_Request_Abstract $request)
    {
        $this->goalId = $request->getPost('pid');

        if($this->goalId < 0)
            $this->addError('goalid', '项目ID不能为空');
        else
            $this->comment->goal_id = $this->goalId;

        $this->todoId = $request->getPost('tid');

        if($this->todoId < 0)
            $this->addError('todoId', '任务ID不能为空');
        else
            $this->comment->tid = $this->todoId;


        $this->body = $request->getPost('body');

        if(strlen($this->body) < 0)
            $this->addError('body', '评论不能为空');
        else
            $this->comment->body = $this->body;

        if(!$this->hasError())
            $this->comment->save(false);

        // return true if no errors have occurred
        return !$this->hasError();
    }
}
