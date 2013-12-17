<?php
class DatabaseObject_Project extends DatabaseObject
{
    const TYPE_PROJECT = 'project';
    const TYPE_TEMPLATE = 'template';

    const DELETE_YES = 'Y';
    const DELETE_NO  = 'N';

    public static $maps = array('cid' => 'client_id',
                                 'desp' => 'description');

    public $projectUser = null;

    public function __construct($db)
    {
        parent::__construct($db, 'projects', 'id');

        $this->add('name');
        $this->add('worknumber', 1);
        $this->add('desp');
        $this->add('status');
        $this->add('deleted');
        $this->add('oweruid');
        $this->add('timeline');
        $this->add('cid');
        $this->add('prid', 0);
        $this->add('phases');
        $this->add('phase');
        $this->add('price');
        $this->add('create_template_id');
        $this->add('business_id');
        $this->add('type', 'project');
        $this->add('pravite', 0);
        $this->add('archived', 0);
        $this->add('creator');
        $this->add('created_at', time(), self::TYPE_TIMESTAMP);
        $this->add('updated_at', null, self::TYPE_TIMESTAMP);
		$this->add('departmentid');

        $this->projectUser = new DatabaseObject_ProjectUser($this->_db);
    }

    public static function GetProjects($db, $options = array())
    {
        $defaults = array('creator' => 0,
                          'oweruid' => 0,);

        foreach($defaults as $k => $v) {
            $options[$k] = array_key_exists($k, $options) ? $options[$k] : $v;
        }

        $select = self::_GetBaseQuery($db, $options);
        $select->from(null, 'p.*');

        if($options['creator'] > 0)
            $select->where('creator = ?', $options['creator']);

        if($options['oweruid'] > 0)
            $select->where('oweruid = ?', $options['oweruid']);

        $select->where('deleted = ?', self::DELETE_NO);
        //echo $select->assemble();exit;
        return $db->fetchAssoc($select);
    }

    protected function preInsert()
    {
        $this->projectUser->uid = $this->oweruid;
        $this->projectUser->creator = $this->oweruid;
    }

    protected function postInsert()
    {
        $return = false;

        if($this->create_template_id > 0)
            $return = $this->templateTodoProcess();
        else
            $return = $this->createSection();

        $this->projectUser->projectid = $this->getId();
        $this->projectUser->save(false);

        return $return;
    }

    protected function createSection()
    {
        $section = new DatabaseObject_Section($this->_db);
        $section->goal_id = $this->getId();
        $section->name = 'unfiled';
        $section->unfiled = 0;

        return $section->save(false);
    }

    protected function templateTodoProcess()
    {
        $goalId = $this->create_template_id;
        $sections = DatabaseObject_Section::GetSections($this->_db, array('goal_id' => $goalId));
        foreach($sections as $section) {
            $newSection = new DatabaseObject_Section($this->_db);
            $newSection->goal_id = $this->getId();
            $newSection->name = $section['name'];
            $newSection->unfiled = $section['unfiled'];
            $newSection->save(false);
            $todos[$newSection->getId()] = DatabaseObject_Todo::GetTodos($this->_db, array('goal_id' => $goalId, 'section_id' => $section['id']));
        }

        foreach($todos as $sid => $vals) {
            if(!empty($vals)){
                foreach($vals as $v) {
                    $newTodo = new DatabaseObject_Todo($this->_db);
                    $newTodo->content = $v['content'];
                    $newTodo->owner_uid = $this->oweruid;
                    $newTodo->assigner = $this->oweruid;
                    $newTodo->todoUser->goal_id = $this->getId();
                    $newTodo->todoUser->projectid = $this->getId();
                    $newTodo->todoUser->section_id = $sid;
                    $newTodo->save(false);
                }
            }
        }

        return true;
    }

    public static function GetTemplateList($db)
    {
        $options['type'] = 'template';

        $select = self::_GetBaseQuery($db, $options);
        $select->from(null, 'p.*');

        return $db->fetchAll($select);
    }

    private static function _GetBaseQuery($db, $options)
    {
        $defaults = array('price' => 0,
                          'create_template_id' => 0,
                          'business_id' => 0,
                          'type' => 'project',
                          'private' => 0,
                          'archived' => 0,
                          'oweruid' => 0,);

        foreach($defaults as $k => $v) {
            $options[$k] = array_key_exists($k, $options) ? $options[$k] : $v;
        }

        $select = $db->select();
        $select->from(array('p' => 'projects', array()));

        if($options['price'] > 0)
            $select->where('price > ?', $options['price']);

        if($options['create_template_id'] > 0)
            $select->where('create_template_id = ?', $options['create_template_id']);

        if($options['business_id'] > 0)
            $select->where('business_id = ?', $options['business_id']);

        if(!is_null($options['type']))
            $select->where('type = ?', $options['type']);

        if($options['private'] > 0)
            $select->where('private = ?', $options['private']);

        if($options['archived'] > 0)
            $select->where('archived = ?', $options['archived']);

        if($options['oweruid'] > 0)
            $select->where('oweruid = ?', $options['oweruid']);

        return $select;
    }

    public function toArray()
    {
        $array = array();

        foreach($this->getSelectFields() as $value) {
            if(array_key_exists($value, self::$maps))
                $array[self::$maps[$value]] = $this->$value;

            $array[$value] = $this->$value;
        }

        $array[$this->_idField] = $this->_id;
        return $array;
    }

    public function isOperate($userId)
    {
        if($this->oweruid == $userId)
            return true;
        elseif($this->creator == $userId)
            return true;
        else
            return false;
    }
}
