{*Fuzion custom Relationship block starts*}

  {assign var='trels' value=','|explode:$rels}
  {*this is a bit cludgey but we might be looking at a b or both*}
  {if $rel_contact eq 'contact_id_b'}
    {crmAPI entity="relationship" action="get" var="relationships" contact_id_b =$contactId}
  {elseif $rel_contact eq 'contact_id_a'}
    {crmAPI entity="relationship" action="get" var="relationships" contact_id_a =$contactId}
  {else}
    {crmAPI entity="relationship" action="get" var="relationships" contact_id=$contactId status_id=4}
  {/if}

  {if $relationships.values}
    {foreach from=$relationships.values item=rel}
        {if (!$rel_contact || $rel.$rel_contact eq $contactId)
            && (!$rels || in_array($rel.relationship_type_id, $trels))}
            {assign var='relationshiptype' value= $rel.relationship_type_id}
            {assign var='relid' value = $rel.id}
            {assign var='relation' value=$rel.relation}
            {assign var='relationdesc' value=$relationdesc|cat:"<tr><td class='label'>"|cat:$relation|cat:"</td><td 'class='crm-rel_block'>" }
            {$currentrel}
            {$relArray[$currentrel]}
            {assign var='url' value= ' <a href="/civicrm/contact/view?cid='|cat:$rel.cid|cat:'&reset=1">'|cat:$rel.name|cat:'</a>'}
            {assign var='relationdesc'  value=$relationdesc|cat:$url|cat:' '|cat:$rel.description}
          {/if}
    {/foreach}
  {/if}
  {if $relationdesc}
    <table>
          {$relationdesc|substr:0:-1}
        </td>
      </tr>
    </table>
  {/if}
{*Fuzion custom Relationship block stops*}