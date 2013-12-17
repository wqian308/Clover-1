<?php
class CustomControllerAclManager extends Zend_Controller_Plugin_Abstract
{
    // default user role if not logged or (or invalid role found)
    private $_defaultRole = 'guest';

    // the action to dispatch if a user doesn't have sufficient privileges
    private $_authController = array('controller' => 'account',
                                     'action' => 'login');

    public function __construct()
    {
        $this->auth = Zend_Auth::getInstance();
        $this->acl = new Zend_Acl();

        // add the different user roles
        $this->acl->addRole(new Zend_Acl_Role($this->_defaultRole));
        $this->acl->addRole(new Zend_Acl_Role('member'));
        $this->acl->addRole(new Zend_Acl_Role('administrator'), 'member');

        // add the resources we want to have control over
        $this->acl->add(new Zend_Acl_Resource('account'));
        $this->acl->add(new Zend_Acl_Resource('blogmanager'));
        $this->acl->add(new Zend_Acl_Resource('admin'));

        $this->acl->add(new Zend_Acl_Resource('project'));
        $this->acl->add(new Zend_Acl_Resource('user'));
        $this->acl->add(new Zend_Acl_Resource('todo'));
        $this->acl->add(new Zend_Acl_Resource('membership'));
        $this->acl->add(new Zend_Acl_Resource('follower'));
        // allow access to everything for all users by default
        // except for the account management and administration areas
        $this->acl->allow();
        $this->acl->deny(null, 'account');
        //$this->acl->deny(null, 'blogmanager');
        $this->acl->deny(null, 'admin');
        $this->acl->deny(null, 'project');
        $this->acl->deny(null, 'user');
        $this->acl->deny(null, 'todo');
        $this->acl->deny(null, 'membership');
        $this->acl->deny(null, 'follower');
        // add an exception so guests can log in or register
        // in order to gain privilege
        $this->acl->allow('guest', 'account', array('login',
                                                    'fetchpassword',
                                                    'register',
                                                    'registercomplete'));

        // allow members access to the account management area
        $this->acl->allow('member', 'account');
        $this->acl->allow('member', 'blogmanager');
        $this->acl->allow('member', 'project');
        $this->acl->allow('member', 'user');
        $this->acl->allow('member', 'todo');
        $this->acl->allow('member', 'membership');
        $this->acl->allow('member', 'follower');
        // allows administrators access to the admin area
        $this->acl->allow('administrator', 'admin');
    }

    /**
     * preDispatch
     *
     * Before an action is dispatched, check if the current user
     * has sufficient privileges. If not, dispatch the default
     * action instead
     *
     * @param Zend_Controller_Request_Abstract $request
     */
    public function preDispatch(Zend_Controller_Request_Abstract $request)
    {//print_r($request->getCookie());exit;var_dump($this->auth->hasIdentity());exit;
        if(!$this->auth->hasIdentity() && $request->getCookie('identity'))
            $this->auth->getStorage()->write(unserialize($request->getCookie('identity')));
        // check if a user is logged in and has a valid role,
        // otherwise, assign them the default role (guest)
        if ($this->auth->hasIdentity())
            $role = $this->auth->getIdentity()->userType;
        else
            $role = $this->_defaultRole;

        if (!$this->acl->hasRole($role))
            $role = $this->_defaultRole;

        // the ACL resource is the requested controller name
        $resource = $request->controller;

        // the ACL privilege is the requested action name
        $privilege = $request->action;

        // if we haven't explicitly added the resource, check
        // the default global permissions
        if (!$this->acl->has($resource))
            $resource = null;

        // access denied - reroute the request to the default action handler
        if (!$this->acl->isAllowed($role, $resource, $privilege)) {
            $request->setControllerName($this->_authController['controller']);
            $request->setActionName($this->_authController['action']);
        }
    }
}
?>