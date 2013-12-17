<?php
class FormProcessor_Todo extends FormProcessor
{
    protected $db = null;
    public $todo = null;
    public $user = null;

    public function __construct($db, $userId, $pId, $tId)
    {
        parent::__construct();

        $this->db = $db;
        $this->user = new DatabaseObject_User($db);
        $this->user->load($userId);

        $this->todo = new DatabaseObject_Todo($db);
        $this->todo->load($tId);

        if($this->todo->isSaved()) {
            $this->description = $this->todo->description;
            $this->dueAt = $this->todo->todoUser->due_at;
            $this->closed = $this->todo->todoUser->closed;
            $this->sectionId = $this->todo->todoUser->section_id;
        } else {
            $this->todo->todoUser->goal_id = $pId;
            $this->todo->todoUser->projectid = $pId;
            $this->todo->owner_uid = $userId;
        }

    }

    public function process(Zend_Controller_Request_Abstract $request)
    {
        if($request->getPost('content') && $this->todo->isSaved()) {
            $this->content = $request->getPost('content');
        } elseif (!$this->todo->isSaved()) {
            $this->content = $request->getPost('content');
        } else {
            $this->content = $this->todo->content;
        }

        if($request->getPost('description') && $this->todo->isSaved()) {
            $this->description = $request->getPost('description');
        }

        if(strlen($this->content) == 0)
            $this->addError('content', '请填写内容');

        if($request->getPost('assigner') && $this->todo->isSaved()) {
            $this->assigner = $request->getPost('assigner');
            $this->todo->flag = 'updateAssigner';
        } elseif($this->todo->isSaved()) {
            $this->assigner = $this->todo->assigner;
        } else {
            $this->assigner = $this->user->getId();
        }

        if($request->getPost('due_at') && $this->todo->isSaved()) {
            $this->dueAt = strtotime($request->getPost('due_at'));
            $this->todo->flag = 'updateDueDate';
        }

        if($request->getPost('closed') && $this->todo->isSaved()) {
            $this->closed = $request->getPost('closed');
            $this->todo->flag = 'updateClosed';
        }

        if($request->getPost('section_id') && $this->todo->isSaved()) {
            $this->todo->todoUser->section_id = $request->getPost('section_id');
        }

        if(!$this->hasError()) {
            $this->todo->content = $this->content;
            $this->todo->description = $this->description;
            $this->todo->assigner =  $this->assigner;
            $this->todo->todoUser->due_at = $this->dueAt;
            $this->todo->todoUser->closed = $this->closed;

            $this->todo->save(false);
        }
        // return true if no errors have occurred
        return !$this->hasError();
    }
}
