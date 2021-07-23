require 'rails_helper'


RSpec.describe PostsController, type: :controller do

	let(:user) { create :user }
	let(:params) {{ user_id: user }}

	before { sign_in user }

	describe '#new' do
		subject { get :new, params: params }
		context 'when user signed in' do
			it { is_expected.to render_template(:new) }
			it 'assigns new post' do
				subject
				expect(assigns(:post)).to be_a_new Post
			end
		end
	end

	describe "#index" do
		subject { get :index, params: params}
		let!(:post) { create :post, user: user }

		it 'assigns @posts' do
			subject
			expect(assigns(:posts)).to eq([post])
		end

		it { is_expected.to render_template(:index) }
	end

	describe "#show" do
		let(:post) { create :post, user: user }
		let(:params) {{ user_id: user, id: post}}
		subject { get :show, params: params }

		it 'assigns post' do
			subject
			expect(assigns(:post)).to eq(post)
		end
		it { is_expected.to render_template(:show) }

		context 'when user try to see someone elses posts' do
			let(:post) { create :post }
			it { expect {subject}.to raise_error(ActiveRecord::RecordNotFound) }
		end
	end

	describe "#edit" do
		let(:post) { create :post, user: user }
		let(:params) {{ user_id: user, id: post }}
		subject { get :edit, params: params }

		it 'assigns post' do
			subject
			expect(assigns(:post)).to eq(post)
		end
		it{ is_expected.to render_template(:edit) }
	end

	describe "#create" do
		let(:params) do 
			{ 
				user_id: user.id, 
				post: attributes_for(:post) 
			}
		end
		subject { post :create, params: params }

		it 'create post' do
			expect {subject}.to change{ Post.count }.by(1)
			is_expected.to redirect_to(user_post_path(assigns(:user), assigns(:post)))
		end

		context 'when invalid params' do
			let(:params) do
				{ 
					user_id: user.id, post: { image: nil } 
				}
			end

			it { is_expected.to render_template(:new) }
			it { expect { subject }.not_to change { Post.count } }
		end
	end


	describe "#update" do
		let(:post) { create :post, user: user }
		let(:params) {{ user_id: user, id: post, post: { description: 'Some description' }}}
		subject { process :update, method: :put, params: params }

		it { is_expected.to redirect_to(user_post_path(assigns(:user), assigns(:post))) }

		it 'update post' do
			expect {subject}.to change{ post.reload.description }.to('Some description')			
		end

		context 'with bad params' do
			let(:params){{user_id: user, id: post, post: { description: '' }}}
			it 'does not update post' do
				expect {subject}.not_to change{ post.reload.description }
				is_expected.to redirect_to(user_post_path(assigns(:user), assigns(:post))) 
			end
		end
	end

	describe "#destroy" do
		let(:post) { create :post, user: user }
		let(:params) {{ user_id: user, id: post }}
		subject { process :destroy, method: :delete, params: params }

		it 'delete post' do
			is_expected.to render_template(:index)
			expect(assigns(:post)).to eq(post)
			expect ( Post.count == 0 )
		end
	end
end
