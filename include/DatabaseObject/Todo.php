<?php
class DatabaseObject_Todo extends DatabaseObject
{
    public $todoUser = null;
    public $comment = null;
    public $flag = null;
    public $follower = null;

    public function __construct($db)
    {
        parent::__construct($db, 'todo', 'id');

        $this->add('content');
        $this->add('description');
        $this->add('timeline', time(), self::TYPE_TIMESTAMP);
        $this->add('owner_uid');
        $this->add('assigner');
        $this->add('comment_count', 0);

        $this->todoUser = new DatabaseObject_TodoUser($db);
        $this->comment = new DatabaseObject_Comment($db);
        $this->follower = new DatabaseObject_Followers($db);
    }


    public static function GetTodos($db, $options = array())
    {
        $select = DatabaseObject_TodoUser::_GetBaseQuery($db, $options);
        $select->from(null, 'tu.*');
        $select->joinRight(array('t' => 'todo'),
                          'tu.tid = t.id',
                          't.*');

        //echo $select->assemble();exit;
        return $db->fetchAssoc($select);
    }

    protected function preInsert()
    {
        if(is_null($this->todoUser->section_id)) {
            $this->todoUser->section_id = DatabaseObject_Section::GetDefaultSectionId($this->_db,
                                                                                      array('goal_id' => $this->todoUser->goal_id,
                                                                                            'unfiled' => 0));
        }

        $this->follower->projectid = $this->todoUser->goal_id;
        $this->follower->uid = $this->oweruid;
        $this->follower->creator = $this->oweruid;

        return true;
    }

    protected function postInsert()
    {
        $this->todoUser->tid = $this->getId();
        $this->todoUser->uid = (int) $this->owner_uid;
        $this->todoUser->status = 1;
        $this->todoUser->save(false);


        $this->follwer->tid = $this->getId();
        $this->follwer->save(false);

        $this->comment->creator = $this->owner_uid;
        $this->comment->goal_id = $this->todoUser->goal_id;
        $this->comment->tid = $this->getId();
        $this->comment->type = DatabaseObject_Comment::TYPE_CHANGE;
        $this->comment->body = '创建任务';
        $this->comment->save(false);

        return true;
    }

    protected function preUpdate()
    {
        $this->comment->creator = Zend_Auth::getInstance()->getIdentity()->userId;
        $this->comment->type = DatabaseObject_Comment::TYPE_CHANGE;
        $this->comment->goal_id = $this->todoUser->goal_id;
        $this->comment->tid = $this->getId();

        return true;
    }

    protected function postUpdate()
    {
        $flag = $this->flag;

        switch ($flag) {
            case 'updateAssigner':
                $this->comment->body = 'update assigner';
                break;
            case 'updateDueDate':
                $this->comment->body = 'update due date';
                break;
            case 'updateClosed':
                $this->comment->body = 'update closed';
                break;
        }

        if(strlen($flag) > 0)
            $this->comment->save(false);

        if($flag == 'updateAssigner') {
            $this->follower->projectid = $this->todoUser->goal_id;
            $this->follower->tid = $this->getId();
            $this->follower->uid = $this->assigner;
            $this->follower->creator = Zend_Auth::getInstance()->getIdentity()->userId;

            if(!$this->follower->userExists())
                $this->follower->save(false);
        }


        $this->todoUser->save(false);
        return true;
    }

    protected function postLoad()
    {
        $todoUserId = DatabaseObject_TodoUser::primeKey($this->_db, array('tid' => $this->getId()));

        $this->todoUser->load($todoUserId);

        return true;
    }

    public function toArray()
    {
        $array = parent::toArray();
        $array = array_merge($array, $this->todoUser->toArray());

        return $array;
    }

    public function isOperate($userId)
    {
        if($this->owner_uid == $userId)
            return true;
        elseif($this->assigner == $userId)
            return true;
        else
            return false;
    }
}