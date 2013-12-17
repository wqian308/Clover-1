<?php
class DatabaseObject_ProjectUser extends DatabaseObject
{
    public function __construct($db)
    {
        parent::__construct($db, 'project_users', 'id');

        $this->add('projectid');
        $this->add('uid');
        $this->add('creator');
        $this->add('created_at', time(), self::TYPE_TIMESTAMP);
    }

    public static function GetUserIds($db, $options = array())
    {
        $select = self::_GetBaseQuery($db, $options);
        $select->from(null, 'pu.uid');

        return $db->fetchAll($select);
    }

    public function userExists()
    {
        $query = sprintf('select count(*) as num from %s where projectid = %d and uid = %d',
                         $this->_table,
                         $this->projectid,
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