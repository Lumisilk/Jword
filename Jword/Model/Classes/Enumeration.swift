//
//  Enumeration.swift
//  Jword
//
//  Created by usagilynn on 2/8/18.
//  Copyright © 2018 ribilynn. All rights reserved.
//

import Foundation

enum EntryInfo: String {
  // Ke
  case ateji  // 当て字
  case iK     // word containing irregular kanji usage
  case ik     // word containing irregular kana usage
  case io     // irregular okurigana usage
  case oK     // word containing out-dated kanji
  // Re
  case gikun  // 義訓 (meaning as reading) or 熟字訓 (special kanji reading)
  case oik    // old or irregular kana form
  case ok     // out-dated or obsolete kana usage
}

enum SensePos: String {
  // part-of-speech
  case adj_f
  case adj_i
  case adj_ix
  case adj_ku
  case adj_na
  case adj_nari
  case adj_no
  case adj_pn
  case adj_shiku
  case adj_t
  case adv
  case adv_to
  case aux
  case aux_adj
  case aux_v
  case conj
  case cop_da
  case ctr
  case exp
  case int
  case n
  case n_adv
  case n_pr
  case n_pref
  case n_suf
  case n_t
  case num
  case pn
  case pref
  case prt
  case suf
  case unc
  case v1
  case v1_s
  case v2a_s
  case v2b_k
  case v2d_s
  case v2g_k
  case v2g_s
  case v2h_k
  case v2h_s
  case v2k_k
  case v2k_s
  case v2m_s
  case v2n_s
  case v2r_k
  case v2r_s
  case v2s_s
  case v2t_k
  case v2t_s
  case v2w_s
  case v2y_k
  case v2y_s
  case v2z_s
  case v4b
  case v4h
  case v4k
  case v4m
  case v4r
  case v4s
  case v4t
  case v5aru
  case v5b
  case v5g
  case v5k
  case v5k_s
  case v5m
  case v5n
  case v5r
  case v5r_i
  case v5s
  case v5t
  case v5u
  case v5u_s
  case vi
  case vk
  case vn
  case vr
  case vs
  case vs_c
  case vs_i
  case vs_s
  case vt
  case vz
}

enum SenseInfo: String {
  // filed
  case Buddh
  case MA
  case Shinto
  case anat
  case archit
  case astron
  case baseb
  case biol
  case bot
  case bus
  case chem
  case comp
  case econ
  case engr
  case finc
  case food
  case geol
  case law
  case ling
  case mahj
  case math
  case med
  case mil
  case music
  case physics
  case shogi
  case sports
  case sumo
  case zool
  
  // misc
  case abbr
  case arch
  case chn
  case col
  case derog
  case fam
  case fem
  case hon
  case hum
  case id
  case joc
  case m_sl
  case male
  case obs
  case obsc
  case on_mim
  case poet
  case pol
  case proverb
  case quote
  case rare
  case sens
  case sl
  case uk
  case vulg
  case yoji
  
  // dialect
  case hob
  case ksb
  case ktb
  case kyb
  case kyu
  case nab
  case osb
  case rkb
  case thb
  case tsb
  case tsug
}

enum SenseSource: String {
  case afr
  case ain
  case alg
  case amh
  case ara
  case arn
  case bnt
  case bre
  case bul
  case bur
  case chi
  case chn
  case cze
  case dan
  case dut
  case eng
  case epo
  case est
  case fil
  case fin
  case fre
  case geo
  case ger
  case glg
  case grc
  case gre
  case haw
  case heb
  case hin
  case hun
  case ice
  case ind
  case ita
  case khm
  case kor
  case kur
  case lat
  case mal
  case mao
  case may
  case mnc
  case mol
  case mon
  case nor
  case per
  case pol
  case por
  case rum
  case rus
  case san
  case scr
  case slo
  case slv
  case som
  case spa
  case swe
  case tah
  case tam
  case tha
  case tib
  case tur
  case urd
  case vie
  case yid
}

