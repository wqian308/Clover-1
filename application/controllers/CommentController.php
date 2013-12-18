<?php
class CommentController extends CustomControllerAction
{
    public function init()
    {
        parent::init();

        $this->identity = Zend_Auth::getInstance()->getIdentity();
    }

    public function editAction()
    {
        $request = $this->getRequest();

        $fp = new FormProcessor_Comment($this->db, $this->identity->userId);

        if($request->isPost()) {
            if($fp->process($request)){
                $this->sendResults($this->getDetails($fp));
            } else {
                $this->sendErrors($fp->getErrors());
            }
        }

        $this->sendErrors(array('tid' => '任务ID不能为空'));

    }

    public function deleteAction()
    {
        $request = $this->getRequest();
        $commentId = $request->getQuery('comment_id');

        $errors = array();

        if(!isset($commentId))
            $errors['commentid'] = '评论ID不能为空';

        $comment = new DatabaseObject_Comment($this->db);
        $comment->load($commentId);

        if(!$comment->isOprate($this->identity->userId))
            $errors['user'] = '不能删除其他人的评论及日志';

        if(!$comment->delete())
            $errors['delete'] = '未能正常删除';

        if(count($errors) > 0) {
            $this->sendErrors($errors);
        }
        else {
            $this->sendResults();
        }
    }

    private function getDetails($fp)
    {
        $user = new DatabaseObject_User($this->db);
        $user->load($fp->comment->creator);
        $array = $fp->comment->toArray();
        $array['creator'] = $user->toArray();
        $array['created_at'] = date('m/d H:i', $array['created_at']);
        return $array;
    }
}
