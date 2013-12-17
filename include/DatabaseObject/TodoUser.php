<?php
class DatabaseObject_TodoUser extends DatabaseObject
{
    const DELETE_YES = 'Y';
    const DELETE_NO  = 'N';

    public function __construct($db)
    {
        parent::__construct($db, 'todo_user', 'id');

        $this->add('tid');
        $this->add('uid');
        $this->add('projectid');
        $this->add('opid', 0);
        $this->add('is_star', 0);
        $this->add('is_public', 1);
        $this->add('is_follow', 0);
        $this->add('status', 1);
        $this->add('start_time', null, self::TYPE_TIMESTAMP);
        $this->add('end_time', null, self::TYPE_TIMESTAMP);
        $this->add('deadline');
        $this->add('last_action_at', time(), self::TYPE_TIMESTAMP);
        $this->add('section_id');
        $this->add('closed');
        $this->add('closed_at');
        $this->add('deleted');
        $this->add('goal_id');
        $this->add('due_at', null, self::TYPE_TIMESTAMP);
        $this->add('created_at', time(), self::TYPE_TIMESTAMP);
        $this->add('updated_at', null, self::TYPE_TIMESTAMP);
    }

    public static function _GetBaseQuery($db, $options)
    {
        $defaults = array('section_id' => 0,
                          'closed' => 0,
                          'deleted' => self::DELETE_NO,
                          'goal_id' => 0,
                          'uid' => 0,
                          'status' => 0,
        );

        foreach($defaults as $k => $v) {
            $options[$k] = array_key_exists($k, $options) ? $options[$k] : $v;
        }

        $select = $db->select();
        $select->from(array('tu' => 'todo_user'), array());

        if($options['uid'] > 0)
            $select->where('uid = ?', $options['uid']);

        if($options['status'] > 0)
            $select->where('status = ?', $options['status']);

        if($options['section_id'] > 0)
            $select->where('section_id = ?', $options['section_id']);

        if($options['closed'] > 0)
            $select->where('closed = ?', $options['closed']);

        if(strlen($options['deleted']) > 0)
            $select->where('deleted = ?', $options['deleted']);

        if($options['goal_id'] > 0)
            $select->where('goal_id = ?', $options['goal_id']);

        return $select;
    }

    public static function primeKey($db, $options = array())
    {
        $select = self::_GetBaseQuery($db, $options);
        $select->distinct();
        $select->from(null, 'tu.id');

        if($options['tid'] > 0)
            $select->where('tid = ?', $options['tid']);

        return $db->fetchOne($select);
    }
}