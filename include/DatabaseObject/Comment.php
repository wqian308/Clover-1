<?php
class DatabaseObject_Comment extends DatabaseObject
{
    const TYPE_CHANGE = 'Change';
    const TYPE_COMMENT = 'Comment';

    public $follower = null;

    public function __construct($db)
    {
        parent::__construct($db, 'comments', 'id');

        $this->add('creator');
        $this->add('created_at', time(), self::TYPE_TIMESTAMP);
        $this->add('body');
        $this->add('type', self::TYPE_CHANGE);
        $this->add('goal_id');
        $this->add('tid');
        $this->add('attachments');

        $this->follower = new DatabaseObject_Followers($db);
    }

    public static function GetComments($db, $options = array())
    {
        $select = self::_GetBaseQuery($db, $options);
        $select->from(null, '*');

        return $db->fetchAll($select);
    }

    protected function postInsert()
    {
        if($this->type == self::TYPE_COMMENT) {
            $this->follower->projectid = $this->goal_id;
            $this->follower->tid = $this->tid;
            $this->follower->uid = $this->creator;
            $this->follower->creator = $this->creator;

            $this->follower->save(false);
        }
    }

    public static function GetCommentsCount($db, $options)
    {
        $select = self::_GetBaseQuery($db, $options);
        $select->from(null, 'count(*)');

        return $db->fetchOne($select);
    }

    private static function _GetBaseQuery($db, $options)
    {
        $defaults = array('goal_id' => 0,
                          'tid' => 0,
                          'creator' => 0,
                          'type' => '');

        foreach($defaults as $k => $v) {
            $options[$k] = array_key_exists($k, $options) ? $options[$k] : $v;
        }

        $select = $db->select();
        $select->from(array('ct' => 'comments'), array());

        if($options['goal_id'] > 0)
            $select->where('goal_id = ?', $options['goal_id']);

        if($options['tid'] > 0)
            $select->where('tid = ?', $options['tid']);

        if($options['creator'] > 0)
            $select->where('creator = ?', $options['creator']);

        if(strlen($options['type']) > 0)
            $select->where('type = ?', $options['type']);

        return $select;
    }

}