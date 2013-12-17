<?php
class DatabaseObject_Client extends DatabaseObject
{
    public function __construct($db)
    {
        parent::__construct($db, 'clients', 'id');

        $this->add('name');
        $this->add('logo');
        $this->add('oweruid');
        $this->add('timeline');
        $this->add('status');
    }
    /**
     * Get clients
     *
     * @param Zend_Db_Adapter $db
     * @param Array $options
     * @return array
     */
    public static function GetClients($db, $options = array())
    {
        //initialize the options
        $defaults = array('offset' => 0,
                          'limit' => 0,
                          'order' => 'c.timeline',);

        foreach($defaults as $k => $v) {
            $options[$k] = array_key_exists($k, $options) ? $options[$k] : $v;
        }

        $select = self::_GetBaseQuery($db, $options);
        // set the fields to select
        $select->from(null, 'c.*');

        if($options['limit'] > 0)
            $select->limit($options['limit'], $options['offset']);

        $select->order($options['order']);

        return $db->fetchAssoc($select);
    }

    private static function _GetBaseQuery($db, $options)
    {
        //initialize the options
        $defaults = array(
            'id' => array(),
            'status' => ''
        );

        foreach($defaults as $k => $v) {
            $options[$k] = array_key_exists($k, $options) ? $options[$k] : $v;
        }

        $select = $db->select();
        $select->from(array('c' => 'clients', array()));

        if(count($options['id']) > 0)
            $select->where('c.id in (?)', $options['id']);

        if(strlen($options['status']) > 0)
            $select->where('status = ?', $options['status']);

        return $select;
    }
}