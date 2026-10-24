inherited frmAgrupDuplicatas: TfrmAgrupDuplicatas
  Left = 150
  Top = 89
  Width = 1024
  Height = 720
  Caption = 'Agrupamento de Duplicatas  - Contas a Receber'
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 1024
  ExplicitHeight = 720
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 645
    Width = 1018
    TabOrder = 5
    ExplicitTop = 645
    ExplicitWidth = 1018
    DesignSize = (
      1018
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 1014
      ExplicitWidth = 1014
    end
    inherited btnSair: TBitBtnLocked
      Left = 619
      ExplicitLeft = 619
    end
  end
  inherited pnlStatus: TPanel
    Top = 675
    Width = 1018
    TabOrder = 7
    ExplicitTop = 675
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 864
      Width = 154
      ExplicitLeft = 864
      ExplicitWidth = 154
    end
    inherited pnlInfo: TPanel
      Width = 864
      ExplicitWidth = 864
      object shpMultSel: TShape
        Left = 2
        Top = 2
        Width = 16
        Height = 12
        Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
        Align = alLeft
        Brush.Color = clBlue
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
        ExplicitLeft = 624
        ExplicitTop = 1
        ExplicitHeight = 14
      end
    end
  end
  inherited pgcDados: TPageControl
    Top = 216
    Width = 1018
    Height = 429
    TabOrder = 6
    Visible = False
    ExplicitTop = 216
    ExplicitWidth = 1018
    ExplicitHeight = 429
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1010
      ExplicitHeight = 397
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 1018
    Height = 141
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 80
      Top = 72
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object Label4: TLabel
      Left = 71
      Top = 96
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador:'
    end
    object Label15: TLabel
      Left = 65
      Top = 122
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Vendedor:'
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 121
      Top = 69
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 1
      OnExit = edtCodCliExit
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomCli: TEditFocus
      Left = 197
      Top = 69
      Width = 276
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 2
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodPor: TEditFocus
      Tag = 99
      Left = 121
      Top = 93
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 4
      OnExit = edtCodPorExit
      OnKeyPress = edtCodPorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomPor: TEditFocus
      Left = 197
      Top = 93
      Width = 276
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object GbpEmpresa: TGroupBox
      Left = 114
      Top = 5
      Width = 364
      Height = 58
      Caption = 'Empresa:'
      TabOrder = 0
      object edtCodEmp: TEditFocus
        Tag = 99
        Left = 7
        Top = 30
        Width = 72
        Height = 22
        Alignment = taLeftJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 2
        OnExit = edtCodEmpExit
        OnKeyPress = edtCodEmpKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object rdbOrigem: TRadioButton
        Left = 13
        Top = 13
        Width = 101
        Height = 17
        Caption = 'Origem (Pedido)'
        TabOrder = 0
      end
      object rdbFatu: TRadioButton
        Left = 128
        Top = 13
        Width = 146
        Height = 17
        Caption = 'Faturamento (Documento)'
        Checked = True
        TabOrder = 1
        TabStop = True
      end
      object edtNomEmp: TEditFocus
        Left = 83
        Top = 30
        Width = 276
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 3
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object edtNomVen: TEditFocus
      Left = 197
      Top = 117
      Width = 276
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodven: TEditFocus
      Tag = 99
      Left = 121
      Top = 117
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 6
      OnExit = edtCodvenExit
      OnKeyPress = edtCodvenKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object chkLimFil: TCheckBox
      Left = 482
      Top = 72
      Width = 175
      Height = 17
      Caption = 'Limpar filtros ap'#243's consulta'
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
  end
  object pnlBotoesBaixa: TPanel [4]
    Left = 0
    Top = 645
    Width = 1018
    Height = 30
    Align = alBottom
    BevelInner = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object FlwPnlBotoesBaixa: TFlowPanel
      Left = 2
      Top = 4
      Width = 1326
      Height = 24
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      object btnObsCli: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 132
        Height = 22
        Caption = '[ F2 ] Obs.Cliente'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000100000004000000070000000A0000
          000B0000000D0000000D0000000D0000000C0000000A00000007000000000000
          0000000000000000000000000000000000040E38297E134F37B414593DD21258
          3BDB126441FF105D3DFF0D492FDC0A432AD4063521B804251689000000000000
          000000000000000000000000000000000006278A63FF4EBB98FF3CBB90FF2FB5
          86FF2FBF8DFF2DBD8BFF27AE7DFF24A878FF209A6CFF0D5535FF000000000000
          000000000000000000000000000000000004267B5BD557C09FFF6CDBBCFF65DA
          B7FF45CBA0FF39C697FF37C495FF3AC396FF36A47EFF0F5136DA0000000A0000
          000F0000001000000010000000100000001105110D2F1C5D45A5349875F868CE
          B1FF6AD1B4FF4BC59EFF42BD95FF237F5EFA114731A3030D0929856156C1B886
          75FFB88575FFB78574FFB58374FFB98A7BFFCAA79BFFD5BCB3FFC0B4A9FF4A8E
          77FF40768EFF386E87FF3D7D67FA030B082F0000000500000002C09181FFFFFF
          FFFFFBF5F2FFFAF4F1FFCCA99DFFFAF4F0FFF9F4F0FFF9F4F1FFE9E7E5FF5A7E
          9DFF7DA4CDFF588BC1FF3A5D81FF000000260000000000000000C29485FFFFFF
          FFFFF8F2EDFFF8F1ECFFC7A295FFF8F0EBFFF8F0EAFFF8F3F0FFDFDDDCFF587F
          B2FFBDE0F5FF8BC2EBFF345D97FF010305390000000300000000C39788FFCFAE
          A2FFC9A497FFC9A497FFC9A396FFC7A396FFC7A396FFDECBC4FF4F6791FF5C80
          B0FFCAE8F6FF94C6E9FF375D95FF0F2346B00000000900000000C4998BFFFFFF
          FFFFFAF4F0FFF9F4F0FFCBA798FFF9F3EFFFF9F3EEFFF6F2F0FF285897FF4F7C
          B1FF517CAFFF2C5088FF325D98FF183871F50000000B00000000C69C8DFFFFFF
          FFFFFBF6F2FFFAF5F1FFCBA89AFFFAF4F1FFFAF3F0FFF9F6F4FF3B6FAEFF6C9E
          D1FF5C8CC1FF76A5D3FF5385BEFF1C417DF80000000700000000C18962FFD3A6
          80FFCC996FFFCC996FFFCC986FFFCCAA9DFFCCAA9CFFE2CEC7FFB0B6C4FF5D8D
          C4FF4483C4FF3476BDFF5179ADFF0A192D600000000300000000C5916AFFECD3
          AEFFE8CB9FFFE8CA9FFFD1A177FFFBF7F5FFFBF7F4FFFCF8F5FFDFC9C1FFFBF8
          F6FFF9F7F5FFFAF8F8FFDFCBC3FF0000000D0000000000000000CA9A72FFEDD5
          AFFFECD4AFFFECD3AFFFDBB590FFFFFFFFFFFFFFFFFFFFFFFFFFD5B7ACFFFFFF
          FFFFFFFFFFFFFFFFFFFFC69E90FF00000009000000000000000099785AC2CFA3
          79FFCFA279FFCFA379FFCFA379FFD4ADA0FFD4AD9FFFD4AD9FFFD3AC9FFFD3AC
          9EFFD3AB9EFFD2AB9DFF9B7F74C3000000050000000000000000000000040000
          0006000000070000000700000007000000070000000700000007000000070000
          0008000000080000000700000005000000010000000000000000}
        TabOrder = 0
        OnClick = btnObsCliClick
      end
      object btnContaCorrente: TBitBtnLocked
        Left = 132
        Top = 0
        Width = 132
        Height = 22
        Caption = '[ F6 ] C/C'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0001000000020000000400000005000000060000000600000006000000060000
          0006000000050000000400000002000000010000000000000000000000000000
          0002000000060000000B0000000F000000110000001100000011000000110000
          00110000000F0000000B00000006000000020000000000000000000000000000
          0004654A409BAB7D6DFFAB7D6DFFAB7D6DFFAB7D6DFFAB7D6DFFAB7D6DFFAB7D
          6DFFAB7D6DFFAB7D6DFF654A409B000000040000000000000000000000000000
          0005AC7F6FFFFEFDFCFFFAF6F3FFFAF6F3FFFAF6F3FFFAF6F3FFFAF6F3FFFAF6
          F3FFFAF6F3FFFEFDFCFFAC7F6FFF000000050000000000000000000000000000
          0006AE8170FFFBF7F4FFF7EFE9FFF7EFE9FFF7EFE9FFF7EFE9FFF7EFE9FFF7EF
          E9FFF7EFE9FFFBF7F4FFAE8170FF000000060000000000000000000000000000
          0006AF8372FFFBF7F5FFF7F0EBFFF7F0EBFFF7F0EBFFCBABA0FFCBABA0FFF7F0
          EBFFCBABA0FFFBF7F5FFAF8372FF000000060000000000000000000000000000
          0006B18574FFFBF8F5FFF8F1ECFFF8F1ECFFF8F1ECFFF8F1ECFFF8F1ECFFF8F1
          ECFFF8F1ECFFFBF8F5FFB18574FF000000060000000000000000000000000000
          0006B38877FFFCF9F6FFB46833FFB46833FFF9F3EEFFCBABA0FFCBABA0FFF9F3
          EEFFCBABA0FFFCF9F6FFB38877FF000000060000000000000000000000000000
          0006B58A79FFFCF9F7FFF9F4F0FFF9F4F0FFF9F4F0FFF9F4F0FFF9F4F0FFF9F4
          F0FFF9F4F0FFFCF9F7FFB58A79FF000000060000000000000000000000000000
          0006B78D7BFFFCFAF8FFFAF5F2FFFAF5F2FFFAF5F2FFCBABA0FFCBABA0FFFAF5
          F2FFCBABA0FFFCFAF8FFB78D7BFF000000060000000000000000000000000000
          0006B9907EFFFDFBF9FFFBF7F4FFFBF7F4FFFBF7F4FFFBF7F4FFFBF7F4FFFBF7
          F4FFFBF7F4FFFDFBF9FFB9907EFF000000060000000000000000000000000000
          0006BC9381FFFDFBFAFFFCF8F5FFFCF8F5FFFCF8F5FFCBABA0FFCBABA0FFFCF8
          F5FFCBABA0FFFDFBFAFFBC9381FF000000060000000000000000000000000000
          0005C19A87FFFDFCFBFFFCF9F7FFFCF9F7FFFCF9F7FFFCF9F7FFFCF9F7FFFCF9
          F7FFFCF9F7FFFDFCFBFFC19A87FF000000050000000000000000000000000000
          0004C6A08CFFFEFCFBFFB46833FFB46833FFFDFAF8FFCBABA0FFCBABA0FFFDFA
          F8FFCBABA0FFFEFCFBFFC6A08CFF000000040000000000000000000000000000
          0002C9A491FFFFFEFEFFFEFDFCFFFEFDFCFFFEFDFCFFFEFDFCFFFEFDFCFFFEFD
          FCFFFEFDFCFFFFFEFEFFC9A491FF000000020000000000000000000000000000
          000178635797CCA894FFCCA894FFCCA894FFCCA894FFCCA894FFCCA894FFCCA8
          94FFCCA894FFCCA894FF78635797000000010000000000000000}
        TabOrder = 1
        OnClick = btnContaCorrenteClick
      end
      object btnMarca: TBitBtnLocked
        Left = 264
        Top = 0
        Width = 132
        Height = 22
        Caption = '[ F7 ] Marca Tudo'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
          555555555555555555555555555555555555555555FF55555555555559055555
          55555555577FF5555555555599905555555555557777F5555555555599905555
          555555557777FF5555555559999905555555555777777F555555559999990555
          5555557777777FF5555557990599905555555777757777F55555790555599055
          55557775555777FF5555555555599905555555555557777F5555555555559905
          555555555555777FF5555555555559905555555555555777FF55555555555579
          05555555555555777FF5555555555557905555555555555777FF555555555555
          5990555555555555577755555555555555555555555555555555}
        NumGlyphs = 2
        TabOrder = 2
        OnClick = btnMarcaClick
      end
      object btnDesmarca: TBitBtnLocked
        Left = 396
        Top = 0
        Width = 132
        Height = 22
        Caption = '[ F8 ] Desmarca Tudo'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
          3333333777333777FF3333993333339993333377FF3333377FF3399993333339
          993337777FF3333377F3393999333333993337F777FF333337FF993399933333
          399377F3777FF333377F993339993333399377F33777FF33377F993333999333
          399377F333777FF3377F993333399933399377F3333777FF377F993333339993
          399377FF3333777FF7733993333339993933373FF3333777F7F3399933333399
          99333773FF3333777733339993333339933333773FFFFFF77333333999999999
          3333333777333777333333333999993333333333377777333333}
        NumGlyphs = 2
        TabOrder = 3
        OnClick = btnMarcaClick
      end
      object btnConfirma: TBitBtnLocked
        Left = 528
        Top = 0
        Width = 132
        Height = 22
        Caption = '[ F10 ] Confirma'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FF313131313131313131313131FF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF313131746B6D7A767674
          7575828282313131313131313131FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF313131726E726A66697D797A2929293838384242422828286868683131
          31313131313131FF00FFFF00FFFF00FF3131316F6C6F7470746D6A6D7D797B6C
          6D6D4C4C4C1F1F1F000000000000090909757274777277424141FF00FF313131
          CCCACEC9C4C9999398696669E5E2E5D8D9D9ACACAC8E8E8E525252232323201F
          203D483D3C563C424141313131929193D7D5D9D7D5D8F2F4F68082846D6C6DA4
          A3A4D8D8D8E9EBEBE3EAEAD4D9D9ADACAF6F836F388239424141313131EFEEF2
          E5E5E9F7F6F6CFACACC4A6A99296986A6B6C5152536D6364A78384C4ADAFD3D0
          D1E6E3E5D8D8D8424141313131FCFCFCFEFFFFCA9895B43837934041826263BF
          ACABD0D0D1B588887D12119C3C3D766D6E6E6869626060FF00FF313131FFFFFF
          FFFFFF9F3536BC4242A355557F2A28AC6C6BFFFFFFD1A4A47B14149F35362D2C
          2C2D2C2CFF00FFFF00FF3F3F3F313131CACECF9F3536BD4241AB53539A545389
          5354CAC5C2CC92928217179F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          3131319F3536B84442B64F4FC16968BC6363B85959BD5E5DBF58589F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536B5635FE9D5D4EEDEDDEF
          DDDCEEDAD9F2E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47E7AF3FBF8C5C2C1C5C2C1C5C2C1E7EBEBC47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536C17A78F3F3F3DDD8D7DD
          D8D7DDD8D7E3E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47B79F3F3F3C5C2C1C5C2C1C5C2C1E3E6E5C47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1706ECCC6C6CCC6C6CC
          C6C6CCC6C6CCC6C6B1706EFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 4
        OnClick = btnConfirmaClick
      end
      object btnHistDocumentos: TBitBtnLocked
        Left = 660
        Top = 0
        Width = 132
        Height = 22
        Caption = '&Hist. Documentos'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBD4C00BD4C00
          BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C
          00BD4C00BD4C00BD4C00BD4C00FFF2E2FFEFDDFEEBD8811E00FEE6CBFEE2C6FE
          E0C0E3B08AFEDAB5FED8B0FFD5ABE3A97AFED1A3FECF9EBD4C00BD4C00FFF3E6
          FFF0E1FEEEDC811E00FEE9CFFFE5CAFEE2C4E3B18EFEDDB8FFD9B2FFD8AFE3AB
          7EFED3A5FED0A0BD4C00BD4C00FEF4EBFEF3E6FFF0E1811E00FEEAD4FFE6CEFE
          E3C9E5B490FEDEBCFFDAB7FED8B1E3AB80FED4A7FED1A3BD4C00BD4C00811E00
          811E00811E00811E00E5BDA3E5BCA0E3BA9EE3B899E5B695E5B590E3B28BE5B0
          88E3AD83E3AC81BD4C00BD4C00FFF8F2FFF7EEFFF3E7811E00FFEEDCFFEBD7FE
          E9D0E3B696FEE2C4FEE0BFFEDCB8E3AD86FFD8AFFED5AABD4C00BD4C00FFFBF4
          FFF8F0FEF6EB811E00FFF0E1FFEDDCFEEAD5E5B899FFE5C9FEE2C2FFE0BDE3B0
          88FED9B2FFD7ADBD4C00BD4C00FFFCF8FFFAF4FFF7EF811E00FFF3E5FFEFE0FE
          EDD9E5BA9DFFE7CEFFE3C7FFE1C1E3B18BFEDCB5FED8B1BD4C00BD4C00811E00
          811E00811E00811E00811E00811E00811E00811E00811E00811E00811E00811E
          00811E00811E00BD4C00BD4C00FFFFFEFFFCFAFFFBF6811E00FFF6EDFFF4E6FF
          F2E1811E00FFEBD7FFE9D0FEE6CA811E00FEE0BFFEDDB7BD4C00BD4C00FFFFFF
          FFFEFCFFFCF8811E00FFF8EFFFF4EAFEF3E5811E00FEEEDAFFEAD4FFE7CE811E
          00FFE1C2FEDEBCBD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD
          4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        ParentFont = False
        TabOrder = 5
        OnClick = btnHistDocumentosClick
      end
      object btnRecalculaJuros: TBitBtnLocked
        Left = 792
        Top = 0
        Width = 140
        Height = 22
        Caption = '[ F11 ] Recalcula &Juros'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 13
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
          6666666666666666666666660000666666666666666666666FFFFF6666666666
          000066844446666666666666F88886FF666F6666000068466664466646666668
          86666886F68F6666000064666666646446666668F6666668688F666600006466
          6666664446666668F6666666888F6666000064666666644446666668F6666668
          888F66660000684666664444466666688F666688888666660000664866666666
          66666666886666666666FF66000066666666666668466666666FFFFF666886F6
          00006666444446666648666666888886666688F6000066664444666666646666
          66888866666668F6000066664446666666646666668886F6666668F600006666
          44646666666466666688686FF66668F600006666466644666648666666866688
          6FFF8F6600006666666666444486666666666666888886660000666666666666
          6666666666666666666666660000666666666666666666666666666666666666
          0000}
        NumGlyphs = 2
        ParentFont = False
        TabOrder = 6
        OnClick = btnRecalculaJurosClick
      end
    end
    object btnConfigurar: TBitBtnLocked
      AlignWithMargins = True
      Left = 610
      Top = 4
      Width = 132
      Height = 22
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alRight
      Caption = 'C&onfigurar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FF108ABA1895C1066897FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF188CBA138FBD066A990982B213
        99CA1E9DC90B72A00A6D9A2B96BD2692BCFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF1D8FBA21A5D10999CE078ABC0EB7EB2FCBF61F90BB41B0D34CB4D4288E
        B6FF00FFFF00FFFF00FFFF00FF1073A01880AB35A1C96BD0EA37AFD423B8E60F
        CBFF23D0FF44C7ED5AB6D59CD8E677C0D80D72A1FF00FFFF00FFFF00FF45A7CB
        2F9CC539ACD77DE7FF74EAFF40DDFF15CFFF0DCCFF38D9FF5EE1FF63E5FF28BC
        E91C9DCE188EC0FF00FFFF00FF0878AF1190CB35B2E367D5F479EAFF56C6E141
        A5BD369EBA17B7E502C4FF01C1FE03C2FE03BAF205A0D8FF00FFFF00FF0D75A5
        1698D428A9E052CBF378B7C67F7E7E7F7E7E7F7E7E7F7E7E2DAACC00C5FF09C6
        FE0FC5FA0487BCFF00FFFF00FF0F79AA1598D51CA0DA40C1F07F7E7EE2DAD99E
        9F9F978B8BD8A4A17F7E7E3FD1F884EBFFA1EAFB2683ABFF00FFFF00FF0973A5
        0F86BF1597D32EB5EA7F7E7EE2D9D79D9E9E978B8BD1A1A07F7E7E62DCFA97E6
        F770BCD72F8FB4FF00FFFF00FFFF00FF056695108BC620AAE57F7E7EE2D9D79D
        9E9E978B8BD3A3A07F7E7E4AD8FC4DBBDE015E8EFF00FFFF00FFFF00FFFF00FF
        FF00FF086FA00576AC7F7E7EE6DDD99D9E9E978B8BD7A5A37F7E7E0F82B0117A
        A7FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7F7E7EDDDAD999
        9A9A968A8ACCA3A37F7E7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF7F7E7E9E9E9E898989817E7E9689897F7E7EFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7F7E7ED8D7D7B6
        B7B78F8C8C9F8F8F7F7E7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF7F7E7EDDDCDCE3E2E2AAAAAA8C87877F7E7EFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7F7E7E7F
        7E7E7F7E7E7F7E7EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 1
      OnClick = btnConfigurarClick
    end
    object btnRegraAgrup: TBitBtnLocked
      AlignWithMargins = True
      Left = 746
      Top = 4
      Width = 132
      Height = 22
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alRight
      Caption = '&Regras'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333FFFFF3333333333F797F3333333333F737373FF333333BFB999BFB
        33333337737773773F3333BFBF797FBFB33333733337333373F33BFBFBFBFBFB
        FB3337F33333F33337F33FBFBFB9BFBFBF3337333337F333373FFBFBFBF97BFB
        FBF37F333337FF33337FBFBFBFB99FBFBFB37F3333377FF3337FFBFBFBFB99FB
        FBF37F33333377FF337FBFBF77BF799FBFB37F333FF3377F337FFBFB99FB799B
        FBF373F377F3377F33733FBF997F799FBF3337F377FFF77337F33BFBF99999FB
        FB33373F37777733373333BFBF999FBFB3333373FF77733F7333333BFBFBFBFB
        3333333773FFFF77333333333FBFBF3333333333377777333333}
      NumGlyphs = 2
      TabOrder = 2
      OnClick = btnRegraAgrupClick
    end
    object btnSairAgrup: TBitBtnLocked
      AlignWithMargins = True
      Left = 882
      Top = 4
      Width = 132
      Height = 22
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alRight
      Caption = '[ Esc ] Sair'
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000120B0000120B0000000100000000000000520000006B
        0000006B0800106B0800008C080000940800007B100000731800087B180008A5
        1800089C21001094290010A529001084310010A5310018A5310010A539001884
        4200DE844200218C42002194420018AD420018B5420021B5420021944A00299C
        4A0029BD4A00DE8C52003194520018B5520031C6520031945A00299C5A0031AD
        5A00BD5A6300AD73630029AD630039D66300DEA5840042B59400FFD69C0073A5
        AD00DEBDAD006BA5B5009CBDB500B5C6B500DED6B500FFDEB500D6C6BD00FFE7
        BD00088CC600DECEC60073D6C600E7D6C600EFD6C600F7E7C600FFE7C600088C
        CE000894CE00E7D6CE00109CD600189CD600219CD600299CD60018A5D60021A5
        D60029A5D60031A5D60042ADD600F7E7D600FFE7D600FFEFD60021A5DE0031AD
        DE00E7D6DE00FFEFE700FFF7E7004ACEEF005ADEEF0052CEF7005ADEF70094E7
        F700A5E7F7006BEFF7007BEFF70084F7F7008CF7F7009CF7F700FFFFF700FF00
        FF0063DEFF006BDEFF005AEFFF0073F7FF007BF7FF0084F7FF0094F7FF009CF7
        FF00A5F7FF0073FFFF007BFFFF0084FFFF008CFFFF0094FFFF009CFFFF00A5FF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00593232595959
        5959595959595959595932514E32323232325959595959595959325266655F5F
        5E5A32320203595959593A44685D5E27141819130604085959594144575D651F
        1A1A17150E0905015959424E4465651F1E251A17170E09040059425444696327
        21242432101D0A0D325942562B44606067665D5D0F0B1154415942552A444444
        44446153081F4F5F4D594255305846312E2C445134605B605F3D4255306A4B45
        372F2D444444444444434355336A584B45372F28295C3D5959593F57356A6A58
        4B452323233E3E595959593F366A6A6A6A3B23122259595959595959356A6A6A
        6A4A231B59595959595959592626262626262359595959595959}
      TabOrder = 3
      OnClick = btnSairAgrupClick
    end
  end
  object Panel1: TPanel [5]
    Left = 0
    Top = 216
    Width = 1018
    Height = 429
    Align = alClient
    ParentBackground = False
    TabOrder = 4
    object pnlAux2: TPanel
      Left = 1
      Top = 1
      Width = 1016
      Height = 427
      Align = alClient
      BevelOuter = bvNone
      ParentBackground = False
      TabOrder = 0
      object pnlTotais: TPanel
        Left = 0
        Top = 224
        Width = 1016
        Height = 203
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label21: TLabel
          Left = 15
          Top = 9
          Width = 77
          Height = 14
          Alignment = taRightJustify
          Caption = 'Total duplicatas:'
        end
        object Label9: TLabel
          Left = 5
          Top = 31
          Width = 87
          Height = 14
          Alignment = taRightJustify
          Caption = 'Total Selecionado:'
        end
        object Label7: TLabel
          Left = 196
          Top = 9
          Width = 44
          Height = 14
          Alignment = taRightJustify
          Caption = 'Portador:'
        end
        object Label10: TLabel
          Left = 210
          Top = 31
          Width = 30
          Height = 14
          Alignment = taRightJustify
          Caption = 'Nome:'
        end
        object Label12: TLabel
          Left = 37
          Top = 54
          Width = 54
          Height = 14
          Alignment = taRightJustify
          Caption = 'Nosso Nro:'
        end
        object Label14: TLabel
          Left = 46
          Top = 76
          Width = 45
          Height = 14
          Alignment = taRightJustify
          Caption = 'Hist'#243'rico:'
        end
        object edtTotalDup: TEditFocus
          Left = 94
          Top = 4
          Width = 98
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 0
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtTotalSelecionado: TEditFocus
          Left = 94
          Top = 27
          Width = 98
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 1
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtNomPorBai: TEditFocus
          Left = 244
          Top = 27
          Width = 205
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 2
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCodPorBai: TEditFocus
          Left = 244
          Top = 4
          Width = 205
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 3
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtNosNum: TEditFocus
          Left = 94
          Top = 50
          Width = 355
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 4
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtHistor: TMemoFocus
          Left = 94
          Top = 73
          Width = 355
          Height = 64
          TabStop = False
          Color = 16768952
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 5
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          StringQuebra = '<<csq>>'
        end
        object pnlInfoVenda: TPanel
          Left = 455
          Top = 2
          Width = 559
          Height = 199
          Align = alRight
          BevelOuter = bvNone
          Caption = 'pnlInfoVenda'
          ShowCaption = False
          TabOrder = 6
          object gbEndEntrega: TGroupBox
            Left = 2
            Top = 68
            Width = 555
            Height = 121
            Caption = 'Endere'#231'o de Entrega'
            TabOrder = 0
            object Label57: TLabel
              Left = 37
              Top = 45
              Width = 49
              Height = 14
              Alignment = taRightJustify
              Caption = 'Endere'#231'o:'
            end
            object Label58: TLabel
              Left = 166
              Top = 22
              Width = 36
              Height = 14
              Alignment = taRightJustify
              Caption = 'Cidade:'
            end
            object Label60: TLabel
              Left = 479
              Top = 20
              Width = 36
              Height = 14
              Alignment = taRightJustify
              Caption = 'Estado:'
            end
            object Label62: TLabel
              Left = 64
              Top = 22
              Width = 22
              Height = 14
              Alignment = taRightJustify
              Caption = 'CEP:'
            end
            object Label63: TLabel
              Left = 54
              Top = 68
              Width = 32
              Height = 14
              Alignment = taRightJustify
              Caption = 'Bairro:'
            end
            object Label149: TLabel
              Left = 29
              Top = 91
              Width = 56
              Height = 14
              Alignment = taRightJustify
              Caption = 'Refer'#234'ncia:'
            end
            object edtEndEnt: TEditFocus
              Tag = 99
              Left = 87
              Top = 40
              Width = 460
              Height = 22
              Alignment = taLeftJustify
              CharCase = ecUpperCase
              Color = 16768952
              Ctl3D = True
              Enabled = False
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentCtl3D = False
              ReadOnly = True
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtCidEnt: TEditFocus
              Tag = 99
              Left = 203
              Top = 17
              Width = 44
              Height = 22
              Alignment = taLeftJustify
              CharCase = ecUpperCase
              Color = 16768952
              Ctl3D = True
              Enabled = False
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentCtl3D = False
              ReadOnly = True
              TabOrder = 1
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtCepEnt: TEditFocus
              Tag = 99
              Left = 87
              Top = 17
              Width = 78
              Height = 22
              Alignment = taLeftJustify
              CharCase = ecUpperCase
              Color = 16768952
              Ctl3D = True
              Enabled = False
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentCtl3D = False
              ReadOnly = True
              TabOrder = 2
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtBaiEnt: TEditFocus
              Tag = 99
              Left = 87
              Top = 63
              Width = 460
              Height = 22
              Alignment = taLeftJustify
              CharCase = ecUpperCase
              Color = 16768952
              Ctl3D = True
              Enabled = False
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentCtl3D = False
              ReadOnly = True
              TabOrder = 3
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtRefEnt: TEditFocus
              Tag = 99
              Left = 87
              Top = 86
              Width = 460
              Height = 22
              Alignment = taLeftJustify
              CharCase = ecUpperCase
              Color = 16768952
              Ctl3D = True
              Enabled = False
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentCtl3D = False
              ReadOnly = True
              TabOrder = 4
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtEstado: TEditFocus
              Left = 517
              Top = 17
              Width = 29
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
              Ctl3D = True
              Enabled = False
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentCtl3D = False
              ReadOnly = True
              TabOrder = 5
              NormalColor = 16768952
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtNomCid: TEditFocus
              Left = 248
              Top = 17
              Width = 227
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
              Ctl3D = True
              Enabled = False
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentCtl3D = False
              ReadOnly = True
              TabOrder = 6
              NormalColor = 16768952
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
          end
          object gbNota: TGroupBox
            Left = 2
            Top = 0
            Width = 555
            Height = 66
            Caption = 'Nota'
            TabOrder = 1
            object lblMsg001: TLabel
              Left = 19
              Top = 18
              Width = 67
              Height = 14
              Alignment = taRightJustify
              Caption = 'Mensagem 1: '
            end
            object lblmsg002: TLabel
              Left = 18
              Top = 38
              Width = 64
              Height = 14
              Alignment = taRightJustify
              Caption = 'Mensagem 2:'
            end
            object edtMsg001: TEditFocus
              Left = 85
              Top = 14
              Width = 462
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
              Enabled = False
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 0
              NormalColor = 16768952
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtMsg002: TEditFocus
              Left = 85
              Top = 37
              Width = 462
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
              Enabled = False
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 1
              NormalColor = 16768952
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
          end
        end
      end
      object grdDuplicatas: TcxGrid
        Left = 0
        Top = 0
        Width = 1016
        Height = 224
        Align = alClient
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object grdDuplicatasDBTableView1: TcxGridDBTableView
          OnDblClick = grdDuplicatasDBTableView1DblClick
          OnKeyDown = grdDuplicatasDBTableView1KeyDown
          Navigator.Buttons.CustomButtons = <>
          OnCustomDrawCell = grdDuplicatasDBTableView1CustomDrawCell
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.FocusCellOnTab = True
          OptionsData.Editing = False
          OptionsSelection.CellSelect = False
          OptionsSelection.HideSelection = True
          OptionsView.GroupByBox = False
          OptionsView.Indicator = True
          OnColumnSizeChanged = grdDuplicatasDBTableView1ColumnSizeChanged
          object grdDuplicatasDBTableView1DBColumn1: TcxGridDBColumn
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taLeftJustify
            Properties.ReadOnly = True
            Visible = False
            Width = 20
          end
          object grdDuplicatasDBTableView1CTR_NUMDUP: TcxGridDBColumn
            Caption = 'Duplicata'
            DataBinding.FieldName = 'CTR_NUMDUP'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taLeftJustify
            Properties.ReadOnly = True
            Width = 107
          end
          object grdDuplicatasDBTableView1CTR_ESPDOC: TcxGridDBColumn
            Caption = 'Esp.'
            DataBinding.FieldName = 'CTR_ESPDOC'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.ReadOnly = True
            HeaderAlignmentHorz = taCenter
            Width = 50
          end
          object grdDuplicatasDBTableView1CTR_CODCLI: TcxGridDBColumn
            Caption = 'C'#243'd. Cliente'
            DataBinding.FieldName = 'CTR_CODCLI'
            Visible = False
            Width = 100
          end
          object grdDuplicatasDBTableView1CTR_NOMCLI: TcxGridDBColumn
            Caption = 'Nome Cliente'
            DataBinding.FieldName = 'CTR_NOMCLI'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taLeftJustify
            Properties.ReadOnly = True
            Width = 300
          end
          object grdDuplicatasDBTableView1CTR_FANSOB: TcxGridDBColumn
            Caption = 'Nome Fantasia'
            DataBinding.FieldName = 'CTR_FANSOB'
            Width = 300
          end
          object grdDuplicatasDBTableView1CTR_NOMPOR: TcxGridDBColumn
            Caption = 'Portador'
            DataBinding.FieldName = 'CTR_NOMPOR'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taLeftJustify
            Properties.ReadOnly = True
            Width = 167
          end
          object grdDuplicatasDBTableView1CTR_CODEMP: TcxGridDBColumn
            Caption = 'Empresa'
            DataBinding.FieldName = 'CTR_CODEMP'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.ReadOnly = True
            HeaderAlignmentHorz = taCenter
            Width = 60
          end
          object grdDuplicatasDBTableView1CTR_DTACAD: TcxGridDBColumn
            Caption = 'Emiss'#227'o'
            DataBinding.FieldName = 'CTR_DTACAD'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.ReadOnly = True
            HeaderAlignmentHorz = taCenter
            Width = 62
          end
          object grdDuplicatasDBTableView1CTR_DTAVEN: TcxGridDBColumn
            Caption = 'Vencimento'
            DataBinding.FieldName = 'CTR_DTAVEN'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.ReadOnly = True
            HeaderAlignmentHorz = taCenter
            Width = 75
          end
          object grdDuplicatasDBTableView1CTR_TIPFOR: TcxGridDBColumn
            Caption = 'Fora'
            DataBinding.FieldName = 'CTR_TIPFOR'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taLeftJustify
            Properties.ReadOnly = True
            Width = 118
          end
          object grdDuplicatasDBTableView1CTR_CODCND: TcxGridDBColumn
            Caption = 'Condi'#231#227'o de Pagamento'
            DataBinding.FieldName = 'CONDPAG'
            Width = 124
          end
          object grdDuplicatasDBTableView1CTR_VALDUP: TcxGridDBColumn
            Caption = 'Vlr. Duplicata'
            DataBinding.FieldName = 'CTR_VALDUP'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.ReadOnly = True
            HeaderAlignmentHorz = taRightJustify
            Width = 80
          end
          object grdDuplicatasDBTableView1CTR_JURATR: TcxGridDBColumn
            Caption = 'Vlr. Juros'
            DataBinding.FieldName = 'CTR_JURATR'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.ReadOnly = True
            HeaderAlignmentHorz = taRightJustify
            Width = 80
          end
          object grdDuplicatasDBTableView1CTR_VALCOR: TcxGridDBColumn
            Caption = 'Vlr. Corrigido'
            DataBinding.FieldName = 'CTR_VALCOR'
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.ReadOnly = True
            HeaderAlignmentHorz = taRightJustify
            VisibleForEditForm = bTrue
            Width = 80
          end
          object grdDuplicatasDBTableView1CTR_MARDES: TcxGridDBColumn
            DataBinding.FieldName = 'CTR_MARDES'
            Visible = False
          end
        end
        object grdDuplicatasLevel1: TcxGridLevel
          GridView = grdDuplicatasDBTableView1
        end
      end
    end
  end
  object pnlCabecalho2: TPanel [6]
    Left = 0
    Top = 164
    Width = 1018
    Height = 52
    Align = alTop
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 2
    object lblPeriodo: TLabel
      Left = 77
      Top = 33
      Width = 39
      Height = 14
      Alignment = taRightJustify
      Caption = 'Per'#237'odo:'
    end
    object lblPeriodoa: TLabel
      Left = 374
      Top = 33
      Width = 6
      Height = 14
      Alignment = taRightJustify
      Caption = 'a'
    end
    object lblCndPag: TLabel
      Left = 28
      Top = 9
      Width = 87
      Height = 14
      Caption = 'Cond. Pagamento:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object rdbDtaCad: TRadioButton
      Left = 121
      Top = 30
      Width = 70
      Height = 17
      Caption = 'Cadastro'
      Checked = True
      TabOrder = 2
      TabStop = True
    end
    object rdbDtaVen: TRadioButton
      Left = 195
      Top = 30
      Width = 80
      Height = 17
      Caption = 'Vencimento'
      TabOrder = 3
    end
    object mskDtaIni: TcxDateEdit
      Tag = 99
      Left = 280
      Top = 25
      Properties.ButtonGlyph.SourceDPI = 96
      Properties.ButtonGlyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000000000020000000A0000
        0010000000110000001100000011000000120000001200000012000000120000
        00120000001300000013000000120000000C000000030000000A81594CC2B47C
        69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB27968FFB279
        67FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F6EFFFBF8
        F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7EDE6FFF6ED
        E6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB98472FFFBF8
        F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDCD4FFBA92
        83FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC8978FFFCFA
        F8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EFEAFFEBDD
        D5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E7DFFFCFA
        F9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1ECFFBE97
        86FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC39482FFFCFA
        FAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2EEFFEDDF
        D9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC79887FFFDFB
        FAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5F1FFC19B
        8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D8CFFFDFC
        FCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6F3FFEEE2
        DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA190FFFEFC
        FCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7F6FFC49F
        91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA594FFFEFC
        FCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9
        F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53C3FF8D9E
        ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69DCFF5966
        DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55C4FF93A4
        EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6FDEFF5C6C
        DDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56C6FF96A7
        EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291
        E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A4093C14D55
        C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046B7FF3E44
        B4FF3C41B3FF3A3EB0FF393CAEFF282B80C20000000600000001000000040000
        0006000000060000000600000007000000070000000700000007000000070000
        00070000000800000008000000070000000500000001}
      Properties.ClearKey = 46
      Properties.DateButtons = []
      Properties.MinDate = 2.000000000000000000
      Properties.ValidateOnEnter = False
      Properties.ValidationOptions = []
      StyleFocused.Color = clInfoBk
      TabOrder = 4
      Width = 90
    end
    object mskDtaFin: TcxDateEdit
      Tag = 99
      Left = 384
      Top = 25
      Properties.ButtonGlyph.SourceDPI = 96
      Properties.ButtonGlyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E00000000000000000000000000020000000A0000
        0010000000110000001100000011000000120000001200000012000000120000
        00120000001300000013000000120000000C000000030000000A81594CC2B47C
        69FFB37B69FFB37B68FFB37A68FFB37A68FFB27A68FFB37968FFB27968FFB279
        67FFB27867FFB17867FFB17866FF7F5649C30000000B0000000EB77F6EFFFBF8
        F5FFF8EEE9FFF8EEE8FFF7EFE8FFF7EEE8FFF7EEE8FFF7EDE7FFF7EDE6FFF6ED
        E6FFF6ECE6FFF6ECE6FFF6ECE5FFB47B69FF000000110000000EB98472FFFBF8
        F6FFF8F0EAFFBE9788FFECDDD5FFBD9586FFECDCD4FFBC9383FFECDCD4FFBA92
        83FFEBDAD3FFB99181FFF7EDE7FFB77F6EFF000000110000000EBC8978FFFCFA
        F8FFF9F1EDFFF8F0ECFFF8F0EBFFF9F0EBFFF9F0EAFFF8EFEAFFF8EFEAFFEBDD
        D5FFECDCD5FFEBDCD4FFF8EEE9FFB98472FF000000100000000DC08E7DFFFCFA
        F9FFFAF3EFFF7477C9FF3C3FB7FF343AB1FF2F35ABFF6566B9FFF9F1ECFFBE97
        86FFEDDED6FFBD9585FFF8F1EBFFBC8977FF000000100000000CC39482FFFCFA
        FAFFFBF5F2FF484EC3FF464BC2FF4549C0FF3E44BBFF3035ACFFFAF2EEFFEDDF
        D9FFEDDFD8FFEDDFD8FFF9F2EEFFC08E7CFF0000000F0000000BC79887FFFDFB
        FAFFFBF7F4FF4A52C7FF4950C4FFFBF5F2FF454AC1FF373CB3FFFAF5F1FFC19B
        8BFFEEE0DBFFC09889FFFAF4F0FFC49381FF0000000E0000000BC99D8CFFFDFC
        FCFFFCF8F6FF4F56C8FF4C53C7FF4A51C6FF494FC3FF3F45B9FFFBF6F3FFEEE2
        DCFFEEE2DCFFEEE2DCFFFAF6F2FFC69886FF0000000D0000000ACDA190FFFEFC
        FCFFFCF9F8FF7D82D6FF5058CAFF4E54C7FF4B53C6FF7478CEFFFCF7F6FFC49F
        91FFEFE3DFFFC39D8FFFFBF7F5FFC99D8BFF0000000D00000009CFA594FFFEFC
        FCFFFDFAF9FFFDF9F9FFFDFAF8FFFDF9F8FFFDFAF8FFFCF9F7FFFCF9F7FFFCF9
        F7FFFDF8F7FFFCF9F7FFFCF9F7FFCCA290FF0000000C000000084B53C3FF8D9E
        ECFF687CE3FF6678E2FF6476E1FF6172E0FF5F70DFFF5D6CDEFF5B69DCFF5966
        DBFF5664DAFF5462D9FF616DDCFF3337AAFF0000000B000000084C55C4FF93A4
        EEFF6C80E6FF6A7EE4FF687BE4FF6678E2FF6375E1FF6172E0FF5E6FDEFF5C6C
        DDFF5A69DCFF5766DAFF6472DDFF3538ABFF0000000A000000074D56C6FF96A7
        EFFF95A6EFFF93A4EDFF90A2EDFF8F9FEDFF8B9BEBFF8898EAFF8595EAFF8291
        E7FF7F8DE7FF7D89E5FF7987E5FF3539ACFF00000009000000043A4093C14D55
        C5FF4B53C3FF4A51C1FF484FBFFF464DBEFF444BBBFF4249B9FF4046B7FF3E44
        B4FF3C41B3FF3A3EB0FF393CAEFF282B80C20000000600000001000000040000
        0006000000060000000600000007000000070000000700000007000000070000
        00070000000800000008000000070000000500000001}
      Properties.ClearKey = 46
      Properties.DateButtons = []
      Properties.MinDate = 2.000000000000000000
      Properties.ValidateOnEnter = False
      Properties.ValidationOptions = []
      StyleFocused.Color = clInfoBk
      TabOrder = 5
      Width = 90
    end
    object btnCarrTitulos: TBitBtnLocked
      Left = 481
      Top = 26
      Width = 132
      Height = 21
      Align = alCustom
      Caption = '&Carregar T'#237'tulos'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
        609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
        D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
        9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
        95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
        8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
        A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
        A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
        E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
        B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
        ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
        E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
        BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
        27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
        EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
        C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
        C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
        8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
        CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
        D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
        FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
        CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
        68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 6
      OnClick = btnCarrTitulosClick
    end
    object edtDesCnd: TEditFocus
      Left = 160
      Top = 1
      Width = 313
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodCnd: TEditFocus
      Tag = 99
      Left = 121
      Top = 1
      Width = 35
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 0
      OnExit = edtCodCndExit
      OnKeyPress = edtCodCndKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object chkEnviarEmail: TCheckBox
      Left = 672
      Top = 29
      Width = 197
      Height = 17
      Caption = 'Enviar e-mail do(s) agrupamento(s)'
      TabOrder = 7
    end
  end
  object pnlProjeto: TPanel [7]
    Left = 0
    Top = 141
    Width = 1018
    Height = 23
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object lblProjeto: TLabel
      Left = 29
      Top = 6
      Width = 87
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo do Projeto:'
    end
    object edtDesPrj: TEditFocus
      Left = 197
      Top = 0
      Width = 276
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodPrj: TEditFocus
      Tag = 99
      Left = 121
      Top = 0
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 6
      ParentFont = False
      TabOrder = 0
      OnExit = edtCodPrjExit
      OnKeyPress = edtCodPrjKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 584
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 520
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 695
    Top = 16
  end
end
