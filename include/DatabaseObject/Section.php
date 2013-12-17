<?php
class DatabaseObject_Section extends DatabaseObject
{
    public function __construct($db)
    {
        parent::__construct($db, 'sections', 'id');

        $this->add('goal_id');
        $this->add('name');
        $this->add('unfiled', 1, self::TYPE_BOOLEAN);
        $this->add('created_at', time(), self::TYPE_TIMESTAMP);
        $this->add('updated_at', null, self::TYPE_TIMESTAMP);
        $this->add('ranking');
    }

    public static function GetSections($db, $options = array())
    {
        $defaults = array('rank' => 's.ranking');

        foreach($defaults as $k => $v) {
            $options[$k] = array_key_exists($k, $options) ? $options[$k] : $v;
        }

        $select = self::_GetBaseQuery($db, $options);
        $select->from(null, 's.*');

        $select->order($options['rank']);

        return $db->fetchAssoc($select);
    }

    protected function preInsert()
    {
        // now determine the ranking of the new sections
        $query = sprintf(
            'select coalesce(max(ranking), 0) + 1 from %s where goal_id = %d',
            $this->_table,
            $this->goal_id
        );

        $this->ranking = $this->_db->fetchOne($query);
        return true;
    }

    public static function SetOrders($db, $orders)
    {
        if(!is_array($orders))
            return false;

        $orders = array_unique($orders);

        $rank = 1;
        foreach($orders as $sectionId) {
            $db->update('sections',
                        array('ranking' => $rank),
                        'id = ' . $sectionId);

            $rank++;
        }

        return true;
    }
    public static function GetSectionsCount($db, $options)
    {
        $select = self::_GetBaseQuery($db, $options);
        $select->reset('columns');
        $select->from(null, 'count(*)');

        return $db->fetchOne($select);
    }

    public static function GetDefaultSectionId($db, $options = array()) {
        $select = self::_GetBaseQuery($db, $options);
        $select->from(null, 's.id');

        if(isset($options['unfiled']))
            $select->where('unfiled = ?', (int) $options['unfiled']);

        return (int) $db->fetchOne($select);
    }

    public static function _GetBaseQuery($db, $options)
    {
        //initialize the options
        $defaults = array('id' => array(),
                          'goal_id' => 0,);

        foreach($defaults as $k => $v) {
            $options[$k] = array_key_exists($k, $options) ? $options[$k] : $v;
        }

        $select = $db->select();
        $select->from(array('s' => 'sections', array()));

        if(count($options['id']) > 0)
            $select->where('id in (?)', $options['id']);

        if($options['goal_id'] > 0)
            $select->where('goal_id = ?', $options['goal_id']);

        return $select;
    }
}