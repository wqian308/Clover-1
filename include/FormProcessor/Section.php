<?php
class FormProcessor_Section extends FormProcessor
{
    protected $db = null;
    public $section = null;

    public function __construct($db, $sectionId)
    {
        parent::__construct();

        $this->db = $db;

        $this->section = new DatabaseObject_Section($db);
        $this->section->load($sectionId);

        if($this->section->isSaved())
            $this->section->updated_at = time();
    }

    public function process(Zend_Controller_Request_Abstract $request)
    {
        if(!$this->section->isSaved()) {
            $this->goalId = $request->getPost('pid');

            if($this->goalId < 0)
                $this->addError('goalid', '项目ID不能为空');
            else
                $this->section->goal_id = $this->goalId;
        }

        if(!$request->getPost('orders')) {
            $this->name = $request->getPost('name');

            if(strlen($this->name) < 0)
                $this->addError('name', '阶段名称不能为空');
            else
                $this->section->name = $this->name;
        }

        if($request->getPost('orders')) {
            $this->orders = $request->getPost('orders');

            if(count($this->orders) <= 1)
                $this->addError('orders', '阶段数量小于排序数量');
            elseif(!$errors = DatabaseObject_Section::SetOrders($this->db, $this->orders))
                $this->addError('errors', '排序出错');
            else
                return !$this->hasError();
        }

        if(!$this->hasError())
            $this->section->save(false);

        // return true if no errors have occurred
        return !$this->hasError();
    }
}
