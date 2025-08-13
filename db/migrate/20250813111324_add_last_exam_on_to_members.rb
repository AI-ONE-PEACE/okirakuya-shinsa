class AddLastExamOnToMembers < ActiveRecord::Migration[7.1]
  def change
    add_column :members, :last_exam_on, :date
    add_index  :members, :last_exam_on
  end
end
