object fraFatDigProfissionalVariosFrame: TfraFatDigProfissionalVariosFrame
  Left = 0
  Top = 0
  Width = 750
  Height = 208
  VertScrollBar.Range = 45
  VertScrollBar.Visible = False
  Color = 16770261
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  ParentBackground = False
  ParentColor = False
  ParentFont = False
  TabOrder = 0
  object pnlFundo: TPanel
    Left = 0
    Top = 0
    Width = 750
    Height = 208
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object lblNomPro: TLabel
      Left = 48
      Top = 11
      Width = 58
      Height = 13
      Alignment = taRightJustify
      Caption = 'Profissional:'
    end
    object lblCliDiv: TLabel
      Left = 2
      Top = 55
      Width = 746
      Height = 12
      Align = alBottom
      Alignment = taCenter
      Caption = 
        'N'#227'o h'#225' profissionais vinculados ao cliente. Cadastre-os para efe' +
        'tuar a venda.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -9
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Visible = False
      ExplicitWidth = 328
    end
    object lblComissao: TLabel
      Left = 57
      Top = 32
      Width = 49
      Height = 13
      Alignment = taRightJustify
      Caption = 'Comiss'#227'o:'
    end
    object edtCodPro: TEditFocus
      Tag = 99
      Left = 108
      Top = 7
      Width = 70
      Height = 21
      Alignment = taLeftJustify
      MaxLength = 8
      TabOrder = 0
      OnExit = edtCodProExit
      OnKeyDown = edtCodProKeyDown
      OnKeyPress = edtCodProKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesPro: TEditFocus
      Left = 179
      Top = 7
      Width = 305
      Height = 21
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object btnAdicionaItem: TBitBtnLocked
      Left = 486
      Top = 6
      Width = 75
      Height = 23
      Caption = '&Inserir'
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
      TabOrder = 3
      OnClick = btnAdicionaItemClick
    end
    object dbgItens: TDBGridCitel
      Tag = 99
      Left = 2
      Top = 67
      Width = 746
      Height = 139
      Align = alBottom
      DataSource = dsGrid
      Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 4
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnKeyDown = dbgItensKeyDown
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'DIV_CODDIV'
          Title.Caption = 'C'#243'digo'
          Width = 55
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DIV_NOMDIV'
          Title.Caption = 'Nome do Profissional'
          Width = 320
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ATI_CODATI'
          Title.Caption = 'C'#243'd. Ativ.'
          Width = 55
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ATI_DESATI'
          Title.Caption = 'Descri'#231#227'o da Atividade'
          Width = 158
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'COM_VRCOMI'
          Title.Alignment = taRightJustify
          Title.Caption = 'Comiss'#227'o'
          Width = 60
          Visible = True
        end>
    end
    object edtComissao: TEditFocus
      Tag = 99
      Left = 108
      Top = 29
      Width = 70
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 2
      OnExit = edtComissaoExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
  end
  object dsGrid: TDataSource
    DataSet = cdsGrid
    Left = 304
    Top = 80
  end
  object cdsGrid: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 272
    Top = 80
    object cdsGridDIV_CODDIV: TStringField
      FieldName = 'DIV_CODDIV'
      Size = 8
    end
    object cdsGridDIV_NOMDIV: TStringField
      FieldName = 'DIV_NOMDIV'
      Size = 30
    end
    object cdsGridATI_CODATI: TStringField
      FieldName = 'ATI_CODATI'
      Size = 3
    end
    object cdsGridATI_DESATI: TStringField
      FieldName = 'ATI_DESATI'
    end
    object cdsGridCOM_VRCOMI: TFloatField
      FieldName = 'COM_VRCOMI'
    end
    object cdsGridCOM_PRCOMI: TFloatField
      FieldName = 'COM_PRCOMI'
    end
  end
end
