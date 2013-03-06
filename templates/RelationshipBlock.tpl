{*Fuzion custom Relationship block starts*}
  {crmAPI entity="relationship" action="get" var="relationships" contact_id=$contactId}
  {assign var='trels' value=','|explode:$rels}
  {if $relationships.values}
    {foreach from=$relationships.values item=rel}
      {foreach from=$trels item=trel}
        {if $rel.relationship_type_id eq $trel}
          {if $relationshiptype neq $rel.relationship_type_id}
          {assign var='relation' value=$rel.relation}
            {assign var='relationdesc'  value=$relationdesc|cat:"<td class='label'>"|cat:$relation|cat:"</td><td 'class='crm-rel_block'>" }
          {/if}
          {assign var='relationshiptype' value= $rel.relationship_type_id}
          {assign var='relid' value = $rel.id}
          {$currentrel}
          {$relArray[$currentrel]}
          {assign var='url' value= ' <a href="/civicrm/contact/view?cid='|cat:$rel.cid|cat:'&reset=1">'|cat:$rel.name|cat:'</a>'}
          {assign var='relationdesc'  value=$relationdesc|cat:$url|cat:";"}
        {/if}
      {/foreach}
    {/foreach}
  {/if}
  <tr>
  {$relationdesc}
  </td>
  </tr>
{*Fuzion custom Relationship block stops*}