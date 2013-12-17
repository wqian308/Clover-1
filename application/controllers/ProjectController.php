<?php
class ProjectController extends CustomControllerAction
{
    public function init()
    {
        parent::init();

        $this->identity = Zend_Auth::getInstance()->getIdentity();
    }

    public function indexAction()
    {
        $request = $this->getRequest();
        $projectId = $request->getQuery('pid');

        $options = array('goal_id' => $projectId);

        $todos = DatabaseObject_Todo::GetTodos($this->db, $options);
        $sections = DatabaseObject_Section::GetSections($this->db, $options);

        $lists = array();

        if(count($todos) > 0) {
            foreach($todos as $todo) {
                $lists[$todo['section_id']]['tasks'][] = $todo;
            }
            $lists = $this->_setTodoAttribute($lists);
        }

        foreach($sections as &$section) {
            $section['tasks'] = array_key_exists($section['id'], $lists) ? $lists[$section['id']]['tasks'] : array();
            $section['step'] = $section['name'];
            $section['sid'] = $section['id'];
        }

        $this->sendResults(array_values($sections));
    }

    public function listsAction()
    {
        $lists = array();

        $options = '{"creator":1,"departmentid":2,"client_id":3,"archived":4,"private":5,"oweruid":6}';
        $options = Zend_Json::decode($options);
        $options = array();

        $projects = DatabaseObject_Project::GetProjects($this->db, $options);
        $clients = DatabaseObject_Client::GetClients($this->db);

        if(empty($projects)) {
            $this->sendResults($lists);
        }

        foreach($projects as $project) {
            $lists[$project['cid']]['data'][] = $project;
            if(!array_key_exists('cusname', $lists[$project['cid']]))
                $lists[$project['cid']]['cusname'] = $clients[$project['cid']]['name'];
        }

        $lists = $this->_setProjectAttribute($lists);
        $this->sendResults(array_values($lists));
    }

    public function editAction()
    {
        $request = $this->getRequest();
        $projectId = $request->getParam('pid');

        $fp = new FormProcessor_Project($this->db, $this->identity->userId, $projectId);

        if($request->isPost()) {print_r($request->getPost());exit;//die('Sucess!');
            if($fp->process($request))
                $this->sendResults();
            else
                $this->sendErrors($fp->getErrors());
        }

        $initData['clients'] = array_values(DatabaseObject_Client::GetClients($this->db));
        $initData['business'] = DatabaseObject_Business::GetBusiness($this->db);
        $initData['tempaltes'] = DatabaseObject_Project::GetTemplateList($this->db);
        $initData['user'] = current(DatabaseObject_User::GetUsers($this->db, array('id' => array($this->identity->userId))));

        if($fp->project->isSaved()) {
            $initData['poject'] = $fp->project->toArray();
            unset($initData['tempaltes']);
        }

        $this->sendResults($initData);
    }

    public function deleteAction()
    {
        $request = $this->getRequest();
        $projectId = $request->getQuery('pid');

        $errors = array();
        if(!isset($projectId))
            $errors['projectid'] = '项目ID不能为空';

        $project = new DatabaseObject_Project($this->db);
        $project->load($projectId);

        if(!$project->isOperate($this->identity->userId)) {
            $errors['user'] = '不是项目负责人和创建人不能删除该项目';
        }

        if(count($errors) > 0) {
            $this->sendErrors($errors);
        } else {
            $project->deleted = DatabaseObject_Project::DELETE_YES;
            $project->save(false);
            $this->sendResults();
        }
    }

    private function _setProjectAttribute($lists)
    {
        foreach($lists as &$list) {
            foreach($list['data'] as &$data) {
                    $data['stepnum'] = DatabaseObject_Section::GetSectionsCount($this->db, array('goal_id' => $data['id']));
                    $data['curnum'] = 1;
                    $data['href'] = "pro_edit.html?pid=222";
                    $data['people'] = $this->getProjectUsers($data['id']);
            }
        }

        return $lists;
    }

    private function _setTodoAttribute($lists)
    {
        foreach($lists as &$list) {
            foreach($list['tasks'] as &$task) {
                $task['name'] = $task['content'];
                $task['date'] = date('m/d',strtotime($task['created_at']));
                $task['img'] = '../statics2/pic/default_h2.png';
                $task['check'] = false;
                $task['url'] = 'url';
            }
        }

        return $lists;
    }

    private function getProjectUsers($projectid)
    {
        $options = array();
        $options['id'] = DatabaseObject_ProjectUser::GetUserIds($this->db, array('projectid' => $projectid));
        $users = DatabaseObject_User::GetUsers($this->db, $options);

        return $users;
    }
}
