<?php

require_once 'relationshipblock.civix.php';

/**
 * Implementation of hook_civicrm_config
 */
function relationshipblock_civicrm_config(&$config) {
  _relationshipblock_civix_civicrm_config($config);
}

/**
 * Implementation of hook_civicrm_xmlMenu
 *
 * @param $files array(string)
 */
function relationshipblock_civicrm_xmlMenu(&$files) {
  _relationshipblock_civix_civicrm_xmlMenu($files);
}

/**
 * Implementation of hook_civicrm_install
 */
function relationshipblock_civicrm_install() {
  return _relationshipblock_civix_civicrm_install();
}

/**
 * Implementation of hook_civicrm_uninstall
 */
function relationshipblock_civicrm_uninstall() {
  return _relationshipblock_civix_civicrm_uninstall();
}

/**
 * Implementation of hook_civicrm_enable
 */
function relationshipblock_civicrm_enable() {
  return _relationshipblock_civix_civicrm_enable();
}

/**
 * Implementation of hook_civicrm_disable
 */
function relationshipblock_civicrm_disable() {
  return _relationshipblock_civix_civicrm_disable();
}

/**
 * Implementation of hook_civicrm_upgrade
 *
 * @param $op string, the type of operation being performed; 'check' or 'enqueue'
 * @param $queue CRM_Queue_Queue, (for 'enqueue') the modifiable list of pending up upgrade tasks
 *
 * @return mixed  based on op. for 'check', returns array(boolean) (TRUE if upgrades are pending)
 *                for 'enqueue', returns void
 */
function relationshipblock_civicrm_upgrade($op, CRM_Queue_Queue $queue = NULL) {
  return _relationshipblock_civix_civicrm_upgrade($op, $queue);
}

/**
 * Implementation of hook_civicrm_managed
 *
 * Generate a list of entities to create/deactivate/delete when this module
 * is installed, disabled, uninstalled.
 */
function relationshipblock_civicrm_managed(&$entities) {
  return _relationshipblock_civix_civicrm_managed($entities);
}

/**
 * Implementation of hook_civicrm_managed
 *
 * Generate a list of entities to create/deactivate/delete when this module
 * is installed, disabled, uninstalled.
 */
function relationshipblock_civicrm_pageRun(&$page) {
  //@todo check pagename & return if not contact summary page 
  if(($contactID = $page->getVar('_contactId')) != FALSE) {
    try{
      $contactType = civicrm_api3('contact', 'getvalue', array('id' => $contactID, 'return' => 'contact_type'));

    }
    catch(Exception $e) {
      // oohhh we have an error
    }
  }
  else {
    return;
  }

  if($contactType == 'Organization') {
    $relationshipsOfInterest = array(10,11,12,13,14,15,18,20,21,23,24,25,26,29,30,31,32,33,34,38);
  }
  else {
    $relationshipsOfInterest = array(4,10,11,12,13,14,15,18,20,21,23,24,25,26,29,30,31,32,33,34,38);
  }
  $page->assign('rels', implode(',', $relationshipsOfInterest));

  CRM_Core_Region::instance('contact-basic-info-left')->add(array(
    'template' => "RelationshipBlock.tpl"
  ));
}
