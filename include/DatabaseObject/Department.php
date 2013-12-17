<?php
class DatabaseObject_Department extends DatabaseObject
{

    public function __construct($db)
    {
        parent::__construct($db, 'departments', 'id');

        $this->add('name');
        $this->add('parentid');
        $this->add('new_parentid');
        $this->add('data');
        $this->add('listorder');
        $this->add('display');
    }

    public static function _GetBaseQuery($db, $options)
    {
        $defaults = array('name' => '',
                          'new_parentid' => array(),
                          'display' => 1,
                          'id' => array());

        foreach($defaults as $k => $v) {
            $options[$k] = array_key_exists($k, $options) ? $options[$k] : $v;
        }

        $select = $db->select();
        $select->from(array('dpt' => 'departments'), array());

        if($options['display'] > 0)
            $select->where('display = ?', $options['display']);

        if(count($options['id']) > 0)
            $select->where('id in (?)', $options['id']);

        if(strlen($options['name']) > 0)
            $select->where('name = ?', $options['name']);

        if(count($options['new_parentid']) > 0)
            $select->where('new_parentid in (?)', $options['new_parentid']);

        return $select;
    }
}
