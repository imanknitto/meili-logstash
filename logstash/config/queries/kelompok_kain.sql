SELECT
  kk.id_kelompok,
  MAX(kelompok_kain) AS kelompok_kain,
  MAX(img_url) AS img_url,
  MAX(logo_url) AS logo_url,
  MAX(thumbnail_url) AS thumbnail_url,
  MAX(thumbnail_high_url) AS thumbnail_high_url,
  MAX(kategori) AS kategori,
  MAX(slug) AS slug,
  MAX(deskripsi_id) AS deskripsi_id,
  MAX(deskripsi_en) AS deskripsi_en,
  MAX(perawatan_id) AS perawatan_id,
  MAX(perawatan_en) AS perawatan_en,
  MAX(kegunaan_id) AS kegunaan_id,
  MAX(kegunaan_en) AS kegunaan_en,
  MAX(keunggulan_id) AS keunggulan_id,
  MAX(keunggulan_en) AS keunggulan_en,
  MAX(video_url) AS video_url,
  MAX(video_poster_url) AS video_poster_url,
  MAX(is_active) AS is_active,
  MAX(created_at) AS created_at,
  MAX(updated_at) AS updated_at,
  # titles
  MAX(IF(kktitles.lang = 'id', kktitles.title, NULL)) AS title_id,
  MAX(IF(kktitles.lang = 'en', kktitles.title, NULL)) AS title_en,
  # meta tags
  MAX(IF(kktags.lang = 'id' AND kktags.name = 'title', kktags.content, NULL)) AS meta_title_id,
  MAX(IF(kktags.lang = 'en' AND kktags.name = 'title', kktags.content, NULL)) AS meta_title_en,
  MAX(IF(kktags.lang = 'id' AND kktags.name = 'description', kktags.content, NULL)) AS meta_description_id,
  MAX(IF(kktags.lang = 'en' AND kktags.name = 'description', kktags.content, NULL)) AS meta_description_en,
  # meta tags for children
  MAX(meta_title_child_id) AS meta_title_child_id,
  MAX(meta_title_child_en) AS meta_title_child_en,
  MAX(meta_description_child_id) AS meta_description_child_id,
  MAX(meta_description_child_en) AS meta_description_child_en,
  # timestamp for logstash
  UNIX_TIMESTAMP(updated_at) AS unix_ts_in_secs
FROM
  kelompok_kain kk
  LEFT JOIN kelompok_kain_titles kktitles ON kktitles.kelompok_kain_id = kk.id_kelompok
  LEFT JOIN kelompok_kain_tags kktags ON kktags.kelompok_kain_id = kk.id_kelompok
WHERE (
    UNIX_TIMESTAMP(updated_at) > :sql_last_value
    AND updated_at < NOW()
  )
GROUP BY
  kk.id_kelompok
ORDER BY
  updated_at ASC
