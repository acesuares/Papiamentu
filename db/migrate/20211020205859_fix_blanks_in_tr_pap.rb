class FixBlanksInTrPap < ActiveRecord::Migration[6.0]
  def up
    execute("UPDATE words SET tr_pap_cw=name WHERE ISNULL(tr_pap_cw) OR tr_pap_cw=''")
    execute("UPDATE words SET tr_pap_aw=name WHERE ISNULL(tr_pap_aw) OR tr_pap_aw=''")
  end
end
