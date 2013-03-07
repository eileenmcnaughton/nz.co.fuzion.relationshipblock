{*Fuzion custom Relationship block starts*}

  {*this is a bit cludgey*}
  {if $rel_contact eq 'contact_id_b'}
    {crmAPI entity="relationship" action="get" var="relationships" contact_id_b =$contactId}
  {/else}
    {crmAPI entity="relationship" action="get" var="relationships" contact_id=$contactId}
  {/if}

  {assign var='trels' value=','|explode:$rels}
  {if $relationships.values}
    {foreach from=$relationships.values item=rel}
      {foreach from=$trels item=trel}
        {if !$rel_contact || $rel.$rel_contact eq $contactId}
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
        {/if}
      {/foreach}
    {/foreach}
  {/if}
  {if $relationdesc}
    <table>
      <tr>
          {$relationdesc|substr:0:-1}
        </td>
      </tr>
    </table>
  {/if}
{*Fuzion custom Relationship block stops*}