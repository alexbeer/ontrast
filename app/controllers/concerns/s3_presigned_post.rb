module S3PresignedPost
  def s3_presigned_post(path = '')
    key = "#{Rails.env}/#{path}/#{SecureRandom.uuid}_${filename}"
    bucket = Aws::S3::Bucket.new('ontrast')
    presigned_post = bucket.presigned_post(key: key, success_action_status: '201', acl: 'public-read')

    { url: presigned_post.url.to_s, fields: presigned_post.fields }
  end
end
