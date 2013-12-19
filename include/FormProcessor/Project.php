<?php
class FormProcessor_Project extends FormProcessor
{
            static $tags = array(
            'a'      => array('href', 'target', 'name'),
            'img'    => array('src', 'alt'),
            'b'      => array(),
            'strong' => array(),
            'em'     => array(),
            'i'      => array(),
            'ul'     => array(),
            'li'     => array(),
            'ol'     => array(),
            'p'      => array(),
            'br'     => array()
         );

    protected $db = null;
    public $project = null;
    public $user = null;

    public function __construct($db, $userId, $projectId)
    {
        parent::__construct();

        $this->db = $db;

        $this->user = new DatabaseObject_User($db);
        $this->user->load($userId);

        $this->project = new DatabaseObject_Project($db);
        $this->project->load($projectId);

        if($this->project->isSaved()) {
            $this->name = $this->project->name;
            $this->description = $this->project->desp;
            $this->createTemplateId = $this->project->create_template_id;
            $this->status = (int) $this->project->status;
            $this->oweruid = $this->project->oweruid;
            $this->timeline = $this->project->timeline;
            $this->clientId = $this->project->cid;
            $this->price = $this->project->price;
            $this->businessId = $this->project->business_id;
            $this->type = $this->project->type;
            $this->creator = $this->project->creator;
            $this->private = $this->project->private;
            $this->update_at = DatabaseObject_Project::TYPE_TIMESTAMP;
        } else {
            $this->project->timeline = date('Y-m-d H:i:s', time());
            $this->project->creator = $userId;
            $this->project->status = 1;
            $this->project->type = DatabaseObject_Project::TYPE_PROJECT;
            $this->project->departmentid = $this->user->new_departmentid;
        }
    }

    public function process(Zend_Controller_Request_Abstract $request)
    {
        // validate the projectname
        $this->name = trim($request->getPost('name'));

        if (strlen($this->name) == 0)
            $this->addError('name', 'Please enter a name');

        $this->clientId = $request->getPost('client_id');
        $this->description = $this->cleanHtml($request->getPost('description'));

        $this->price = $request->getPost('price');
        if(strlen($this->price) == 0)
            $this->price = 0;//$this->addError('price', 'Please enter a price');

        $this->private = $request->getPost('private');
        $this->oweruid = $request->getPost('oweruid');

        if(!$this->project->isSaved()) {
            $this->project->create_template_id = $request->getPost('create_template_id');
            $this->project->business_id = $request->getPost('business_id');
        }
        // if no errors have occurred, save the project
        if (!$this->hasError()) {
            $this->project->name = $this->name;
            $this->project->cid = $this->clientId;
            $this->project->desp = $this->description;
            $this->project->price = $this->price;
            $this->project->private = $this->private;
            $this->project->oweruid = $this->oweruid;
            //print_r($this->project->toArray());exit;
            $this->project->save(false);
        }

        // return true if no errors have occurred
        return !$this->hasError();
    }

    protected function cleanHtml($html)
    {
        $chain = new Zend_Filter();
        $chain->addFilter(new Zend_Filter_StripTags(self::$tags));
        $chain->addFilter(new Zend_Filter_StringTrim());

        $html = $chain->filter($html);

        $tmp = $html;
        while (1) {
            // Try and replace an occurrence of javascript:
            $html = preg_replace('/(<[^>]*)javascript:([^>]*>)/i',
                                 '$1$2',
                                 $html);

            // If nothing changed this iteration then break the loop
            if ($html == $tmp)
                break;

            $tmp = $html;
        }

        return $html;
    }
}
