<?php
class TodoController extends CustomControllerAction
{
    public function init()
    {
        parent::init();

        $this->identity = Zend_Auth::getInstance()->getIdentity();
    }

    public function editAction()
    {
        $request = $this->getRequest();
        $tId = $request->getParam('tid');
        $pId = $request->getParam('pid');

        $fp = new FormProcessor_Todo($this->db, $this->identity->userId, $pId, $tId);

        if($request->isPost()) {
            if($fp->process($request))
                $this->sendResults($this->getDetails($fp->todo->getId(), $pId));
            else
                $this->sendErrors($fp->getErrors());
        }

        if($tId > 0)
            $this->sendResults($this->getDetails($tId, $pId));
        else
            $this->sendErrors(array('tid' => '任务ID不能为空'));

    }

    public function deleteAction()
    {
        $request = $this->getRequest();

        $tId = $request->getQuery('tid');
        $todo = new DatabaseObject_Todo($this->db);
        $todo->load($tId);
        $todo->todoUser->deleted = 1;

        if($todo->save())
            $this->sendResults();
        else
            $this->sendErrors();
    }

    private function getDetails($tId, $pId)
    {
        $todo = new DatabaseObject_Todo($this->db);
        $todo->load($tId);

        $user = new DatabaseObject_User($this->db);
        $user->load($todo->assigner);

        $details = $todo->toArray();
        $details['comments'] = $this->getComments($tId, $pId);
        $details['assigner'] = $user->toArray();

        return $details;
    }

    private function getComments($tId, $pId)
    {
        $comments = $this->_getComments($pId, $tId);//DatabaseObject_Comment::GetComments($this->db, array('tid' => $tId));
        $commentsCount = count($comments);
        $url = '';

        return array('count' => $commentsCount,
                     'items' => $comments,
                     'url' => $url);
    }

    private function _getComments($pId, $tId)
    {
        $comments = array();
        $comments = DatabaseObject_Comment::GetComments($this->db, array('tid' => $tId));

        if(count($comments) > 0) {
            foreach($comments as &$comment) {
                $user = new DatabaseObject_User($this->db);
                $user->load($comment['creator']);
                $comment['creator'] = $user->toArray();
                $comment['attachments'] = strlen($comment['attachments']) > 0 ? $comments['attachments'] : array();
            }

            return $comments;
        }

        return $comments;
    }
}
