<?php
class UserController extends CustomControllerAction
{
    public function init()
    {
        parent::init();

        $this->identity = Zend_Auth::getInstance()->getIdentity();
    }

    public function searchAction()
    {
        $request = $this->getRequest();
        $options = array('like' => $request->getQuery('like'));
        $users = DatabaseObject_User::GetUsers($this->db, $options);

        $this->sendResults($users);
    }

    public function detailsAction()
    {
        $user = new DatabaseObject_User($this->db);
        $user->load($this->identity->userId);

        $this->sendResults($user->toArray());
    }
}
?>