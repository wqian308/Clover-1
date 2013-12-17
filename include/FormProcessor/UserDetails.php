<?php
class FormProcessor_UserDetails extends FormProcessor
{
    protected $db = null;
    public $user = null;

    public function __construct($db, $userId)
    {
        parent::__construct();

        $this->db = $db;
        $this->user = new DatabaseObject_User($db);
        $this->user->load($userId);

        $this->email = $this->user->email;
    }

    public function process(Zend_Controller_Request_Abstract $request)
    {
        // validate the e-mail address
        $this->email = $this->sanitize($request->getPost('email'));
        $validator = new Zend_Validate_EmailAddress();

        if (strlen($this->email) == 0)
            $this->addError('email', 'Please enter your e-mail address');
        else if (!$validator->isValid($this->email))
            $this->addError('email', 'Please enter a valid e-mail address');
        // check if a new password has been entered and if so validate it
        $this->password = $this->sanitize($request->getPost('password'));
        $this->password_confirm = $this->sanitize($request->getPost('password_confirm'));

        if (strlen($this->password) > 0 || strlen($this->password_confirm) > 0) {
            if (strlen($this->password) == 0)
                $this->addError('password', 'Please enter the new password');
            else if (strlen($this->password_confirm) == 0)
                $this->addError('password_confirm', 'Please confirm your new password');
            else if ($this->password != $this->password_confirm)
                $this->addError('password_confirm', 'Please retype your password');
            else
                $this->user->password = $this->password;
        }

        // if no errors have occurred, save the user
        if (!$this->hasError()) {
            $this->user->save();
        }

        // return true if no errors have occurred
        return !$this->hasError();
    }
}
?>