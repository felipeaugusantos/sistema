inherited frmImpBoletoIndiv: TfrmImpBoletoIndiv
  Left = 101
  Top = 134
  Width = 1233
  Height = 612
  BorderStyle = bsSizeable
  Caption = 'Relat'#243'rio de Impress'#227'o de Boletos (Individual)'
  Position = poMainFormCenter
  ExplicitWidth = 1233
  ExplicitHeight = 612
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 333
    Width = 1217
    ExplicitTop = 333
    ExplicitWidth = 996
    DesignSize = (
      1217
      0)
    inherited FlwBotoes: TFlowPanel
      Width = 1213
      ExplicitWidth = 992
    end
    inherited btnSair: TBitBtnLocked
      Left = 619
      ExplicitLeft = 619
    end
  end
  inherited pnlStatus: TPanel
    Top = 557
    Width = 1217
    ExplicitTop = 557
    ExplicitWidth = 996
    inherited pnlNomeForm: TPanel
      Left = 1046
      ExplicitLeft = 825
    end
    inherited pnlInfo: TPanel
      Width = 1046
      ExplicitWidth = 825
    end
  end
  inherited pgcDados: TPageControl
    Top = 108
    Width = 1217
    Height = 225
    Visible = False
    ExplicitTop = 108
    ExplicitWidth = 996
    ExplicitHeight = 225
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 988
      ExplicitHeight = 193
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 1217
    Height = 108
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 3
    ExplicitWidth = 996
    object Label1: TLabel
      Left = 17
      Top = 13
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object Label2: TLabel
      Left = 218
      Top = 82
      Width = 39
      Height = 14
      Alignment = taRightJustify
      Caption = 'Per'#237'odo:'
    end
    object Label3: TLabel
      Left = 351
      Top = 82
      Width = 7
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = #224
    end
    object Label4: TLabel
      Left = 5
      Top = 36
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object Label9: TLabel
      Left = 25
      Top = 82
      Width = 26
      Height = 14
      Caption = 'Filtro:'
    end
    object ColorLabel1: TColorLabel
      Left = 78
      Top = 82
      Width = 120
      Height = 14
      Caption = '(V)encimento (C)adastro'
      CorDestaque = clRed
    end
    object Label5: TLabel
      Left = 8
      Top = 59
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador:'
    end
    object Label13: TLabel
      Left = 462
      Top = 82
      Width = 79
      Height = 14
      Caption = 'Boleto p/ e-mail?'
    end
    object ColorLabel2: TColorLabel
      Left = 568
      Top = 82
      Width = 96
      Height = 14
      Caption = '(S)im (N)'#227'o (T)odos'
      CorDestaque = clRed
    end
    object lbl2: TLabel
      Left = 500
      Top = 59
      Width = 41
      Height = 14
      Caption = 'Esp'#233'cie:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object shpEmp: TShape
      Left = 58
      Top = 32
      Width = 8
      Height = 22
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 58
      Top = 9
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 0
      OnChange = edtCodCliChange
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 66
      Top = 32
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 4
      OnChange = edtCodCliChange
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomCli: TEditFocus
      Left = 131
      Top = 9
      Width = 321
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
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
    object edtNomEmp: TEditFocus
      Left = 131
      Top = 32
      Width = 321
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
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
    object edtFiltro: TEditFocus
      Tag = 99
      Left = 58
      Top = 78
      Width = 18
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 10
      Text = 'V'
      OnChange = edtCodCliChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object rdgBoletos: TRadioGroup
      Left = 462
      Top = 7
      Width = 108
      Height = 45
      Caption = 'Boletos impressos:'
      Columns = 2
      ItemIndex = 1
      Items.Strings = (
        'Sim'
        'N'#227'o')
      TabOrder = 2
      OnClick = rdgBoletosClick
    end
    object edtCodPor: TEditFocus
      Tag = 99
      Left = 58
      Top = 55
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 6
      OnChange = edtCodCliChange
      OnKeyPress = edtCodPorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesPor: TEditFocus
      Left = 131
      Top = 55
      Width = 321
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
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
    object edtEnvBol: TEditFocus
      Tag = 99
      Left = 546
      Top = 79
      Width = 20
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 13
      Text = 'T'
      OnChange = edtCodCliChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object edtEspDoc: TEditFocus
      Left = 546
      Top = 55
      Width = 55
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 2
      TabOrder = 8
      OnChange = edtCodCliChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object chkLimFil: TCheckBox
      Left = 680
      Top = 55
      Width = 164
      Height = 17
      Caption = 'Limpar filtros ap'#243's consulta'
      Checked = True
      State = cbChecked
      TabOrder = 9
    end
    object btnConsultar: TBitBtnLocked
      Left = 680
      Top = 79
      Width = 106
      Height = 21
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
      TabOrder = 14
      OnClick = btnConsultarClick
    end
    object mskDtaIni: TcxDateEdit
      Tag = 99
      Left = 258
      Top = 79
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
      TabOrder = 11
      Width = 90
    end
    object mskDtaFin: TcxDateEdit
      Tag = 99
      Left = 362
      Top = 79
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
      TabOrder = 12
      Width = 90
    end
    object rdgTipEmp: TRadioGroup
      Left = 576
      Top = 7
      Width = 177
      Height = 45
      Caption = 'Tipo Empresa'
      Columns = 2
      ItemIndex = 1
      Items.Strings = (
        'Origem'
        'Faturamento')
      TabOrder = 3
    end
  end
  object pnlAux2: TPanel [4]
    Left = 0
    Top = 108
    Width = 1217
    Height = 225
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 4
    ExplicitWidth = 996
    object cxgDuplicatas: TcxGrid
      Left = 0
      Top = 0
      Width = 1217
      Height = 225
      Align = alClient
      BevelInner = bvLowered
      BorderWidth = 2
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      ExplicitWidth = 996
      object cxgDuplicatasDados: TcxGridDBTableView
        OnKeyDown = cxgDuplicatasDadosKeyDown
        Navigator.Buttons.CustomButtons = <>
        Navigator.Buttons.First.Visible = True
        Navigator.Buttons.PriorPage.Visible = True
        Navigator.Buttons.Prior.Visible = True
        Navigator.Buttons.Next.Visible = True
        Navigator.Buttons.NextPage.Visible = True
        Navigator.Buttons.Last.Visible = True
        Navigator.Buttons.Insert.Visible = True
        Navigator.Buttons.Append.Visible = False
        Navigator.Buttons.Delete.Visible = True
        Navigator.Buttons.Edit.Visible = True
        Navigator.Buttons.Post.Visible = True
        Navigator.Buttons.Cancel.Visible = True
        Navigator.Buttons.Refresh.Visible = True
        Navigator.Buttons.SaveBookmark.Visible = True
        Navigator.Buttons.GotoBookmark.Visible = True
        Navigator.Buttons.Filter.Visible = True
        FilterBox.CustomizeDialog = False
        OnCellDblClick = cxgDuplicatasDadosCellDblClick
        OnCustomDrawCell = cxgDuplicatasDadosCustomDrawCell
        DataController.DataSource = dtsConsulta
        DataController.Summary.DefaultGroupSummaryItems = <
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxgDuplicatasCTR_VALDUP
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgDuplicatasCTR_VALDUP
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
            Column = cxgDuplicatasCTR_VALCOR
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgDuplicatasCTR_VALCOR
          end>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = ',0.00;(,0.00)'
            Kind = skSum
            DisplayText = 'Total'
          end
          item
            Kind = skCount
            DisplayText = 'Qtd. Cheques'
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgDuplicatasCTR_VALDUP
          end
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgDuplicatasCTR_VALCOR
          end>
        DataController.Summary.SummaryGroups = <>
        DataController.OnSortingChanged = cxgDuplicatasDadosDataControllerSortingChanged
        FilterRow.InfoText = 'Clique aqui para filtrar as duplicatas'
        FilterRow.Visible = True
        FilterRow.ApplyChanges = fracImmediately
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.NoDataToDisplayInfoText = 'N'#227'o h'#225' duplicatas para serem exibidas'
        OptionsView.Footer = True
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object cxgDuplicatasCTR_NUMDUP: TcxGridDBColumn
          Caption = 'Duplicata'
          DataBinding.FieldName = 'CTR_NUMDUP'
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          Width = 108
        end
        object cxgDuplicatasCTR_ESPDOC: TcxGridDBColumn
          Caption = 'Esp.'
          DataBinding.FieldName = 'CTR_ESPDOC'
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          Width = 34
        end
        object cxgDuplicatasCTR_CODEMP: TcxGridDBColumn
          Caption = 'Emp.'
          DataBinding.FieldName = 'CTR_CODEMP'
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          Width = 36
        end
        object cxgDuplicatasCTR_CODVEN: TcxGridDBColumn
          Caption = 'Vend.'
          DataBinding.FieldName = 'CTR_CODVEN'
          Width = 43
        end
        object cxgDuplicatasVENDEDOR: TcxGridDBColumn
          Caption = 'Nome do Vendedor'
          DataBinding.FieldName = 'VENDEDOR'
          Width = 196
        end
        object cxgDuplicatasCTR_CODCLI: TcxGridDBColumn
          Caption = 'Cliente'
          DataBinding.FieldName = 'CTR_CODCLI'
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          Width = 67
        end
        object cxgDuplicatasCLI_NOMCLI: TcxGridDBColumn
          Caption = 'Nome do Cliente'
          DataBinding.FieldName = 'CLI_NOMCLI'
          Width = 234
        end
        object cxgDuplicatasCTR_DTACAD: TcxGridDBColumn
          Caption = 'Cadastro'
          DataBinding.FieldName = 'CTR_DTACAD'
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          Width = 65
        end
        object cxgDuplicatasCTR_DTAVEN: TcxGridDBColumn
          Caption = 'Vencimento'
          DataBinding.FieldName = 'CTR_DTAVEN'
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          Width = 69
        end
        object cxgDuplicatasCTR_BOLETO: TcxGridDBColumn
          Caption = 'Boleto'
          DataBinding.FieldName = 'CTR_BOLETO'
          OnCustomDrawCell = cxgDuplicatasCTR_BOLETOCustomDrawCell
          GroupSummaryAlignment = taCenter
          HeaderAlignmentHorz = taCenter
          HeaderGlyphAlignmentHorz = taCenter
          Width = 43
        end
        object cxgDuplicatasCTR_VALDUP: TcxGridDBColumn
          Caption = 'Valor duplicata'
          DataBinding.FieldName = 'CTR_VALDUP'
          FooterAlignmentHorz = taRightJustify
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Width = 76
        end
        object cxgDuplicatasCTR_VALCOR: TcxGridDBColumn
          Caption = 'Valor corrigido'
          DataBinding.FieldName = 'CTR_VALCOR'
          Width = 76
        end
        object cxgDuplicatasCTR_MARDES: TcxGridDBColumn
          DataBinding.FieldName = 'CTR_MARDES'
          Visible = False
          VisibleForCustomization = False
        end
        object cxgDuplicatasCTR_DTAANT: TcxGridDBColumn
          DataBinding.FieldName = 'CTR_DTAANT'
          Visible = False
          VisibleForCustomization = False
        end
        object cxgDuplicatasCTR_JURALT: TcxGridDBColumn
          DataBinding.FieldName = 'CTR_JURALT'
          Visible = False
          VisibleForCustomization = False
        end
        object cxgDuplicatasCTR_MULALT: TcxGridDBColumn
          DataBinding.FieldName = 'CTR_MULALT'
          Visible = False
          VisibleForCustomization = False
        end
        object cxgDuplicatasCTR_CORANT: TcxGridDBColumn
          DataBinding.FieldName = 'CTR_CORANT'
          Visible = False
          VisibleForCustomization = False
        end
        object cxgDuplicatasCND_DESCRI: TcxGridDBColumn
          Caption = 'Cond. Pgto.'
          DataBinding.FieldName = 'COND_PGTO'
          Width = 150
        end
      end
      object cxgDuplicatasNivel: TcxGridLevel
        GridView = cxgDuplicatasDados
      end
    end
  end
  object pnlAux1: TPanel [5]
    Left = 0
    Top = 333
    Width = 1217
    Height = 199
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 5
    ExplicitWidth = 996
    object pnlDadosDup: TPanel
      Left = 0
      Top = 0
      Width = 1217
      Height = 199
      Align = alClient
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 0
      ExplicitWidth = 996
      object Label7: TLabel
        Left = 34
        Top = 7
        Width = 44
        Height = 14
        Alignment = taRightJustify
        Caption = 'Portador:'
      end
      object Label10: TLabel
        Left = 48
        Top = 30
        Width = 30
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nome:'
      end
      object Label12: TLabel
        Left = 24
        Top = 76
        Width = 54
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nosso Nro:'
      end
      object Label14: TLabel
        Left = 321
        Top = 18
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Hist'#243'rico:'
      end
      object Label8: TLabel
        Left = 292
        Top = 53
        Width = 74
        Height = 14
        Alignment = taRightJustify
        Caption = 'Agrupamentos:'
      end
      object Label11: TLabel
        Left = 44
        Top = 53
        Width = 34
        Height = 14
        Alignment = taRightJustify
        Caption = 'Banco:'
      end
      object lblCartei: TLabel
        Left = 37
        Top = 99
        Width = 41
        Height = 14
        Alignment = taRightJustify
        Caption = 'Carteira:'
        Visible = False
      end
      object lblPerMul: TLabel
        Left = 338
        Top = 122
        Width = 28
        Height = 14
        Alignment = taRightJustify
        Caption = 'Multa:'
        Visible = False
      end
      object lblPerMor: TLabel
        Left = 22
        Top = 122
        Width = 56
        Height = 14
        Alignment = taRightJustify
        Caption = 'Mora di'#225'ria:'
        Visible = False
      end
      object spbAmpliar: TSpeedButton
        Left = 574
        Top = 3
        Width = 23
        Height = 22
        Hint = 'Ampliar imagem'
        Flat = True
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000020000000E0B14308329448DFB1D2F58A5000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000020000000E0D1937883C6DB2FF5BB1F9FF325196F4000000000000
          00000000000100000004000000090000000D0000000F0000000F0000000C0000
          00070000000E0F1D3C864A7CBCFF73C4FFFF467CC3FF17254485000000000000
          0002000000081C130F465A3B31BC7C5043F87F5244FF7B4E42FA57382FC11E14
          1059112142875686C2FF88D0FFFF5186C7FF142343880000000F000000010302
          02104A332C91946B5DFDC6ACA1FFE4D1C6FFEDDDD2FFE2D0C5FFC0A599FF855C
          50FF6E6B7EFF98D4F8FF5B8ECBFF152545840000000D00000002000000076046
          3DA6B39288FFE9DAD0FFDAC0A1FFCBA87AFFC49B66FFCCAA7EFFDCC2A5FFE5D2
          C6FF9A766AFF736A77FF162747850000000E00000002000000002A201D4AAE88
          7CFFEFE6DFFFCDA67CFFCDA36EFFE4C693FFEFD9ABFFEAD2A8FFD4B284FFD0AE
          88FFE7D5CAFF885F53FF25181464000000070000000000000000755B53ACDFCE
          C9FFDDC1A8FFC99966FFE8C085FFE9C388FF8F4B24FFF1D8B1FFF3DDB8FFD6B3
          8AFFDBBEA6FFC5ACA2FF5A3D33C10000000C0000000000000000A9877CE9F8F4
          F2FFC79873FFDEAB77FFEFCDABFFF1D2B5FF8F4524FFEDC99EFFF1D4B2FFECCF
          AEFFC89B77FFE6D6CEFF7C5448F10000000F0000000000000000C09C90FFFDFD
          FCFFBE875FFFEDCFB9FF682612FF8A3F22FF8C4024FF8F4225FF924427FFF1CE
          AEFFC08B67FFF1E6DFFF8B6154FF0000000F0000000000000000AF9186E6F9F5
          F4FFC69474FFE8CDC3FFF9E8E4FFF6DED2FF8B3C23FFF1CEB6FFEBB78FFFE7BC
          9AFFC59172FFEBDFD9FF866055EE0000000D0000000000000000876F68B0E7D9
          D4FFE2C6B7FFC89072FFFAEFF2FFF9E7E4FF6A2213FFF1C8B2FFEBB08AFFCA8F
          6FFFDCBBAAFFD3C0B7FF6B4F46BC00000009000000000000000026201E36CCAF
          A7FAFBF8F7FFCF9F88FFC78E72FFE9CDC6FFEDC7B5FFDD9F79FFC88967FFCE9D
          84FFF5EFEBFFB39387FF2A201D52000000040000000000000000000000036454
          4F84D9C2BAFFFDFBFAFFE2C6B8FFCB977EFFC08163FFCB977DFFE0C4B4FFFAF6
          F5FFC9B0A7FF6B564EA700000009000000010000000000000000000000000202
          020762534D81CEB2A9FAEADDD8FFF9F5F4FFFFFFFFFFF9F5F4FFE9DCD7FFC8AC
          A2FC62504B900404031000000002000000000000000000000000000000000000
          000000000003241F1D3486726BADB69B91E6CCADA1FFB99C92E988736CB22822
          1F3E000000060000000100000000000000000000000000000000}
        ParentShowHint = False
        ShowHint = True
        OnClick = spbAmpliarClick
      end
      object edtCodPorBai: TEditFocus
        Left = 81
        Top = 3
        Width = 203
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
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
      object edtNomPorBai: TEditFocus
        Left = 81
        Top = 26
        Width = 203
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
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
      object edtNosNum: TEditFocus
        Left = 81
        Top = 72
        Width = 203
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
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
      object edtObsAg1: TEditFocus
        Left = 369
        Top = 49
        Width = 203
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
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
      object edtObsAg2: TEditFocus
        Left = 369
        Top = 72
        Width = 203
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
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
      object edtObsAg3: TEditFocus
        Left = 369
        Top = 95
        Width = 203
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
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
      object edtHistor: TMemoFocus
        Left = 369
        Top = 3
        Width = 203
        Height = 45
        TabStop = False
        Color = 16768952
        ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 6
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
      end
      object edtNomeBanco: TEditFocus
        Left = 81
        Top = 49
        Width = 203
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
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
      object pnlTotais: TPanel
        Left = 2
        Top = 143
        Width = 1213
        Height = 54
        Align = alBottom
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 16770261
        TabOrder = 8
        ExplicitWidth = 992
        object Label6: TLabel
          Left = 248
          Top = 9
          Width = 192
          Height = 14
          Alignment = taRightJustify
          Caption = 'Quantidade de duplicatas selecionadas:'
        end
        object Label21: TLabel
          Left = 6
          Top = 9
          Width = 149
          Height = 14
          Alignment = taRightJustify
          Caption = 'Quantidade total de Duplicatas:'
        end
        object Label15: TLabel
          Left = 667
          Top = 9
          Width = 228
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor total original das duplicatas selecionadas:'
        end
        object Label16: TLabel
          Left = 659
          Top = 32
          Width = 236
          Height = 14
          Alignment = taRightJustify
          Caption = 'Valor total corrigido das duplicatas selecionadas:'
        end
        object edtTotalDuplicatas: TEditFocus
          Left = 155
          Top = 5
          Width = 79
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
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
        object edtQtdSelecionadas: TEditFocus
          Left = 440
          Top = 5
          Width = 79
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
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
        object edtTotalSelecionadas: TEditFocus
          Left = 898
          Top = 5
          Width = 85
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
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
        object edtTotalSelCor: TEditFocus
          Left = 898
          Top = 28
          Width = 85
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
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
      object edtCartei: TEditFocus
        Left = 81
        Top = 95
        Width = 203
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 9
        Visible = False
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtPerMul: TEditFocus
        Left = 369
        Top = 118
        Width = 203
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 10
        Visible = False
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtPerMor: TEditFocus
        Left = 81
        Top = 118
        Width = 203
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#39'#234'#39's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 11
        Visible = False
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
  object pnlBotoesBaixa: TPanel [6]
    Left = 0
    Top = 532
    Width = 1217
    Height = 25
    Align = alBottom
    BevelInner = bvLowered
    Color = 16770261
    TabOrder = 6
    ExplicitWidth = 996
    object FlwpnlBotoesBaixa: TFlowPanel
      Left = 2
      Top = 2
      Width = 1047
      Height = 21
      Align = alClient
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      ExplicitWidth = 826
      object btnSelTodos: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 125
        Height = 22
        Caption = '[ F4 ] Selecionar Todos'
        TabOrder = 0
        OnClick = btnSelTodosClick
      end
      object btnIniBus: TBitBtnLocked
        Left = 125
        Top = 0
        Width = 111
        Height = 22
        Caption = '[ F5 ] Inicia Busca'
        TabOrder = 1
        OnClick = btnIniBusClick
      end
      object btnLocProx: TBitBtnLocked
        Left = 236
        Top = 0
        Width = 125
        Height = 22
        Caption = '[ F6 ] Localiza Pr'#243'xima'
        TabOrder = 2
        OnClick = btnLocProxClick
      end
      object btnConfirma: TBitBtnLocked
        Left = 361
        Top = 0
        Width = 111
        Height = 22
        Caption = '[ F10 ] Confirma'
        TabOrder = 3
        OnClick = btnConfirmaClick
      end
    end
    object btnConfigurar: TBitBtnLocked
      Left = 1049
      Top = 2
      Width = 95
      Height = 21
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
      ExplicitLeft = 828
    end
    object btnSairBaixa: TBitBtnLocked
      Left = 1144
      Top = 2
      Width = 71
      Height = 21
      Align = alRight
      Caption = '[ Esc ] Sair'
      TabOrder = 2
      OnClick = btnSairBaixaClick
      ExplicitLeft = 923
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Top = 216
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 328
    Top = 216
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 32
    Top = 184
  end
  object qryConsulta: TUniQuery
    Connection = frmModulo.Database
    Constraints = <>
    Left = 168
    Top = 216
  end
  object dspConsulta: TUniDataSetProvider
    DataSet = qryConsulta
    Options = []
    Left = 200
    Top = 216
  end
  object cdsConsulta: TUniClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspConsulta'
    Left = 232
    Top = 216
  end
  object dtsConsulta: TDataSource
    DataSet = cdsConsulta
    Left = 264
    Top = 216
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 136
    Top = 216
    PixelsPerInch = 96
    object cxsSelecionado: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clAqua
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clDefault
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
  end
end
