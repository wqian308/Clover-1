<?php
class DatabaseObject_Followers extends DatabaseObject
{
    public $projectUser = null;

    public function __construct($db)
    {
        parent::__construct($db, 'followers', 'id');

        $this->add('projectid');
        $this->add('tid');
        $this->add('uid');
        $this->add('creator');
        $this->add('created_at', time(), self::TYPE_TIMESTAMP);

        $this->projectUser = new DatabaseObject_ProjectUser($db);
    }

    protected function preInsert()
    {
        $this->projectUser->projectid = $this->projectid;
        $this->projectUser->uid = $this->uid;
        $this->projectUser->creator = $this->creator;

        return true;
    }

    protected function postInsert()
    {
        if(!$this->projectUser->userExists()) {
            $this->projectUser->save(false);
        }

        return true;
    }

    public static function GetUserIds($db, $options = array())
    {
        $select = self::_GetBaseQuery($db, $options);
        $select->from(null, 'pu.uid');

        return $db->fetchAll($select);
    }

    public function userExists()
    {
        $query = sprintf('select count(*) as num from %s where tid = %d and uid = %d',
                         $this->_table,
                         $this->tid,
                         $this->uid);

        $result = $this->_db->fetchOne($query);

        return $result > 0;
    }

    private static function _GetBaseQuery($db, $options)
    {
        $defaults = array('projectid' => 0,
                          'creator' => 0);

        foreach($defaults as $k => $v) {
            $options[$k] = array_key_exists($k, $options) ? $options[$k] : $v;
        }

        $select = $db->select();
        $select->from(array('pu' => 'project_users'), array());

        if($options['projectid'] > 0)
            $select->where('projectid = ?', $options['projectid']);

        if($options['creator'] > 0)
            $select->where('creator = ?', $options['creator']);

        return $select;
    }
}