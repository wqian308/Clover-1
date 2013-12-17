<?php
class DatabaseObject_User extends DatabaseObject
{
    static $userTypes = array('member'        => 'Member',
                              'administrator' => 'Administrator');

    public $_newPassword = null;

    public function __construct($db)
    {
        parent::__construct($db, 'user', 'id');

        $this->add('name');
        $this->add('pinyin');
        $this->add('email');
        $this->add('password');
        $this->add('avatar_small');
        $this->add('avatar_normal');
        $this->add('level');
        $this->add('timeline', time(), self::TYPE_TIMESTAMP);
        $this->add('settings');
        $this->add('is_closed');
        $this->add('mobile');
        $this->add('tel');
        $this->add('eid');
        $this->add('weibo');
        $this->add('desp');
        $this->add('groups');
        $this->add('departmentid');
        $this->add('new_departmentid');
        $this->add('sex');
        $this->add('birthday');
        $this->add('last_action_at', null, self::TYPE_TIMESTAMP);
        $this->add('user_type','member');
    }

    public static function GetUsers($db, $options = array())
    {
        $defaults = array('like' => '');

        foreach($defaults as $k => $v) {
            $options[$k] = array_key_exists($k, $options) ? $options[$k] : $v;
        }

        $select = self::_GetBaseQuery($db, $options);
        $select->from(null, 'u.*');
        $select->joinLeft(array('dpt' => 'departments'),
                          'u.new_departmentid = dpt.id',
                          'dpt.name as department_name');

        if(strlen($options['like']) > 0) {
            $select->where('u.name like ?', $options['like'] . '%')
                   ->orWhere('email like ?', $options['like'] . '%');
        }
        //print_r($select->assemble());exit;
        return $db->fetchAll($select);
    }

    public function loadByUsername($username)
    {
        $username = trim($username);
        if (strlen($username) == 0)
            return false;

        $query = sprintf('select %s from %s where username = ?',
                         join(', ', $this->getSelectFields()),
                         $this->_table);

        $query = $this->_db->quoteInto($query, $username);

        return $this->_load($query);
    }

    public function loadById($userId)
    {
        $userId = (int) $userId;
        if (strlen($username) <= 0)
            return false;

        $query = sprintf('select %s from %s where id = ?',
                         join(', ', $this->getSelectFields()),
                         $this->_table);

        $query = $this->_db->quoteInto($query, $userId);

        return $this->_load($query);
    }

    public function sendEmail($tpl)
    {
        $templater = new Templater();
        $templater->user = $this;

        // fetch the e-mail body
        $body = $templater->render('email/' . $tpl);

        // extract the subject from the first line
        list($subject, $body) = preg_split('/\r|\n/', $body, 2);
        #设置SMTP发送邮件
        $configs = array('auth' => 'login',
                         'username' => 'uniclick@126.com',
                         'password' => 'junfei',
                         'port' => '25');
        $ts = new Zend_Mail_Transport_Smtp('smtp.126.com',$configs);
        // now set up and send the e-mail
        $mail = new Zend_Mail();

        // set the to address and the user's full name in the 'to' line
        $mail->addTo($this->profile->email,
                     trim($this->profile->first_name . ' ' .
                          $this->profile->last_name));

        // get the admin 'from' details from the config
        $mail->setFrom(Zend_Registry::get('config')->email->from->email,
                       Zend_Registry::get('config')->email->from->name);

        // set the subject and body and send the mail
        $mail->setSubject(trim($subject));
        $mail->setBodyText(trim($body));
        $mail->send($ts);

    }

    public function createAuthIdentity()
    {
        $identity = new stdClass;
        $identity->userId = $this->getId();
        $identity->userName = $this->name;
        $identity->userType = $this->user_type;
        $identity->departmentid = $this->new_departmentid;
        return $identity;
    }

    public function loginSuccess()
    {
        $this->last_action_at = time();
        $this->save();

        $message = sprintf('Successful login attempt from %s user %s',
                           $_SERVER['REMOTE_ADDR'],
                           $this->username);

        $logger = Zend_Registry::get('logger');
        $logger->notice($message);
    }
    public static function LoginFailure($username, $code = '')
    {
        $errors = array();

        switch ($code) {
        case Zend_Auth_Result::FAILURE_IDENTITY_NOT_FOUND:
            $reason = '未知的用户名';#'Unknown username';
            $errors['username'] = $reason;
            break;
        case Zend_Auth_Result::FAILURE_IDENTITY_AMBIGUOUS:
            $reason = '该用户名存在多个用户';#'Multiple users found with this username';
            $errors['multiple'] = $reason;
            break;
        case Zend_Auth_Result::FAILURE_CREDENTIAL_INVALID:
            $reason = '密码无效';#'Invalid password';
            $errors['password'] = $reason;
            break;
        default:
            $reason = '';
        }

        $message = sprintf('Failed login attempt from %s user %s',
                           $_SERVER['REMOTE_ADDR'],
                           $username);

        if (strlen($reason) > 0)
            $message .= sprintf(' (%s)', $reason);

        $logger = Zend_Registry::get('logger');
        $logger->warn($message);

        return $errors;
    }

    public function usernameExists($username)
    {
        $query = sprintf('select count(*) as num from %s where username = ?',
                         $this->_table);

        $result = $this->_db->fetchOne($query, $username);

        return $result > 0;
    }

    static public function IsValidUsername($username)
    {
        $validator = new Zend_Validate_Alnum();
        return $validator->isValid($username);
    }

    public function __set($name, $value)
    {
        switch ($name) {
        case 'password':
            $value = md5($value);
            break;

        case 'user_type':
            if (!array_key_exists($value, self::$userTypes))
                $value = 'member';
            break;
        }

        return parent::__set($name, $value);
    }

    public static function GetUsersCount($db, $options)
    {
        $select = self::_GetBaseQuery($db, $options);
        $select->from(null, 'count(*)');

        return $db->fetchOne($select);
    }

    public static function _GetBaseQuery($db, $options)
    {
        $defaults = array('name' => '',
                          'pinyin' => '',
                          'email' => '',
                          'new_departmentid' => 0,
                          'is_closed' => 0,
                          'id' => array());

        foreach($defaults as $k => $v) {
            $options[$k] = array_key_exists($k, $options) ? $options[$k] : $v;
        }

        $select = $db->select();
        $select->from(array('u' => 'user'), array());

        if(strlen($options['name']) > 0)
            $select->where('u.name = ?', $options['name']);

        if(strlen($options['pinyin']) > 0)
            $select->where('pinyin = ?', $options['pinyin']);

        if(strlen($options['email']) > 0)
            $select->where('email = ?', $options['email']);

        if($options['new_departmentid'] > 0)
            $select->where('new_departmentid = ?', $options['new_departmentid']);

        if($options['is_closed'] > 0)
            $select->where('is_closed = ?', $options['is_closed']);

        if(count($options['id']) > 0)
            $select->where('u.id in (?)', $options['id']);

        return $select;
    }

    public function toArray()
    {
        $array = parent::toArray();
        $department = new DatabaseObject_Department($this->_db);
        $department->load($array['new_departmentid']);

        $array['department_name'] = $department->name;
        unset($array['password']);

        return $array;
    }
}
