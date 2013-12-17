<?php
class DatabaseObject_Business extends DatabaseObject
{
    public function __construct($db)
    {
        parent::__construct($db, 'business', 'id');

        $this->add('name');
        $this->add('created_at', time(), self::TYPE_TIMESTAMP);
        $this->add('updated_at', null, self::TYPE_TIMESTAMP);
    }

    public static function GetBusiness($db, $options = array())
    {
        //initialize the options
        $defaults = array('limit' => 0,
                          'offset' => 0,
                          'order' => 'b.created_at',);

        foreach($defaults as $k => $v) {
            $options[$k] = array_key_exists($k, $options) ? $options[$k] : $v;
        }

        $select = self::_GetBaseQuery($db, $options);
        $select->from(null, 'b.*');

        if($options['limit'] > 0)
            $select->limit($options['limit'], $options['offset']);

        $select->order($options['order']);

        return $db->fetchAll($select);
    }

    private static function _GetBaseQuery($db, $options) {
        //initialize the options
        $defaults = array('id' => array());

        foreach($defaults as $k => $v) {
            $options[$k] = array_key_exists($k, $options) ? $options[$k] : $v;
        }

        $select = $db->select();
        $select->from(array('b' => 'business'), array());

        if(count($options['id']) > 0)
            $select->where('id in (?)', $options['id']);

        return $select;
    }
}