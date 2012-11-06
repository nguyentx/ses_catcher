class CoreObjects < ActiveRecord::Migration
  def change

	create_table :emails do |t|
		t.string		:address
		t.string		:status
		t.timestamps
	end

  end
end
