<?php
class AccountController extends CustomControllerAction
{
    public function init()
    {
        parent::init();
    }

    public function indexAction()
    {
        $this->logger->warn('TEST ERRORS');
        exit;
    }

    public function registerAction()
    {
        $request = $this->getRequest();

        $fp = new FormProcessor_UserRegistration($this->db);
        $validate = $request->isXmlHttpRequest();

        if ($request->isPost()) {
            if ($validate) {
                $fp->validateOnly(true);
                $fp->process($request);
            }
            else if ($fp->process($request)) {
                $session = new Zend_Session_Namespace('registration');
                $session->user_id = $fp->user->getId();
                $this->_redirect($this->getUrl('registercomplete'));
            }
        }

        if ($validate) {
            $json = array(
                'errors' => $fp->getErrors()
            );
            $this->sendJson($json);
        }
        else {
            $this->breadcrumbs->addStep('Create an Account');
            $this->view->fp = $fp;
        }
    }

    public function registercompleteAction()
    {
        // retrieve the same session namespace used in register
        $session = new Zend_Session_Namespace('registration');

        // load the user record based on the stored user ID
        $user = new DatabaseObject_User($this->db);
        if (!$user->load($session->user_id)) {
            $this->_forward('register');
            return;
        }

        $this->breadcrumbs->addStep('Create an Account',
                                    $this->getUrl('register'));
        $this->breadcrumbs->addStep('Account Created');
        $this->view->user = $user;
    }

    public function loginAction()
    {
        // if a user's already logged in, send them to their account home page
        $auth = Zend_Auth::getInstance();

        if ($auth->hasIdentity()){
            $prompt['logged'] = '已经登陆';#'already logged!';
            $this->sendResults($prompt);
        }
        //$this->_redirect($this->getUrl());

        $request = $this->getRequest();

        // determine the page the user was originally trying to request
        $redirect = $request->getPost('redirect');
        if (strlen($redirect) == 0)
            $redirect = $request->getServer('REQUEST_URI');
        if (strlen($redirect) == 0)
            $redirect = $this->getUrl();

        // initialize errors
        $errors = array();

        // process login if request method is post
        if ($request->isPost()) {

            // fetch login details from form and validate them
            $username = $request->getPost('username');
            $password = $request->getPost('password');

            if (strlen($username) == 0)
                $errors['username'] = '用户名不能为空';#'Required field must not be blank';
            if (strlen($password) == 0)
                $errors['password'] = '密码不能为空';#'Required field must not be blank';

            if (count($errors) == 0) {

                // setup the authentication adapter
                $adapter = new Zend_Auth_Adapter_DbTable($this->db,
                                                         'user',
                                                         'email',
                                                         'password',
                                                         'md5(?)');

                $adapter->setIdentity($username);
                $adapter->setCredential($password);

                // try and authenticate the user
                $result = $auth->authenticate($adapter);

                if ($result->isValid()) {
                    $user = new DatabaseObject_User($this->db);
                    $user->load($adapter->getResultRowObject()->id);

                    // record login attempt
                    $user->loginSuccess();

                    // create identity data and write it to session
                    $identity = $user->createAuthIdentity();
                    $auth->getStorage()->write($identity);
                    //Set Cookie
                    $cookieConfigs = $this->bootstrap->getOption('cookie');
                    $cookie = new Zend_Http_Header_SetCookie('identity',
                                                             serialize($identity),
                                                             time() * $cookieConfigs['expire'],
                                                             $cookieConfigs['path'],
                                                             $cookieConfigs['domain']);
                    //$this->getResponse()->setRawHeader($cookie);
                    // send user to page they originally request
                    //$this->_redirect($redirect);
                    $prompt['login'] = '登陆成功';#'Sucess login!';
                    $this->sendResults($prompt);
                }
                // record failed login attempt
                $this->sendErrors(DatabaseObject_User::LoginFailure($username,
                                                                        $result->getCode()));
            }
        }
        $errors['unlogin'] = '未登陆';#'Not login in';
        $this->sendErrors($errors);
    }

    public function logoutAction()
    {

        Zend_Auth::getInstance()->clearIdentity();

        //$cookieConfigs = $this->bootstrap->getOption('cookie');
        //$cookie = new Zend_Http_Header_SetCookie('identity', '', time() - 3600, $cookieConfigs['path'], $cookieConfigs['domain']);
        //$this->getResponse()->setRawHeader($cookie);
        //$this->getResponse()->sendHeaders();

        $prompt['logout'] = 'logout bye';
        $this->sendResults($prompt);
    }

    public function detailsAction()
    {
        $auth = Zend_Auth::getInstance();

        $fp = new FormProcessor_UserDetails($this->db,
                                            $auth->getIdentity()->userId);

        if ($this->getRequest()->isPost()) {
            if ($fp->process($this->getRequest())) {
                $auth->getStorage()->write($fp->user->createAuthIdentity());
                $this->_redirect($this->getUrl('detailscomplete'));
            }
        }

        $this->sendResults($fp->user->toArray());
    }

    public function detailscompleteAction()
    {
        $user = new DatabaseObject_User($this->db);
        $user->load(Zend_Auth::getInstance()->getIdentity()->user_id);

        $this->breadcrumbs->addStep('Your Account Details',
                                    $this->getUrl('details'));
        $this->breadcrumbs->addStep('Details Updated');
        $this->view->user = $user;
    }
}
