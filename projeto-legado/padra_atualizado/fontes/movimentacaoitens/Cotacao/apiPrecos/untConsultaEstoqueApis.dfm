inherited frmConsultaEstoqueApis: TfrmConsultaEstoqueApis
  Width = 414
  Height = 468
  Caption = 'Consulta Rede Ancora'
  Position = poMainFormCenter
  ExplicitWidth = 414
  ExplicitHeight = 468
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 395
    Width = 408
    TabOrder = 4
    ExplicitTop = 395
    ExplicitWidth = 408
    inherited FlwBotoes: TFlowPanel
      Width = 404
      ExplicitWidth = 404
      object BitBtnLocked1: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 105
        Height = 23
        Caption = '&Limpar Filtros'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00020000000900000012000000180000001A0000001A00000018000000100000
          0005000000010000000000000000000000000000000000000000000000020000
          000D3524146A936338E5A56B3AFFA36938FFA16736FF9D6233FB633E20B70805
          022800000006000000010000000000000000000000000000000000000008442F
          1D78C18B59FEE1AC76FFE4C296FFB5793BFFB5793CFFB5793CFFAD7239FF7E50
          2AD80302042A00000006000000010000000000000000000000000000000DB07D
          4EF3E6B17AFFE9B47DFFE9B47DFFE7C79DFFB67A3DFFB57A3DFFB57A3DFF6953
          7BFF090E5ED50001052800000006000000010000000000000000000000086A4E
          329DEFD7B3FFE9B47DFFE9B47DFFE9B47DFFEACDA4FFB57B3EFF735C86FF313F
          CCFF2935B8FF0B1161D501010627000000050000000100000000000000010000
          000C745538A5F2DDBBFFE9B47DFFE9B47DFFE9B47DFFD1CEE1FF3443CEFF3443
          CDFF3443CEFF2C39BAFF0D1463D4010106260000000500000001000000000000
          00020000000B76583BA4F5E2C1FFE9B47DFFB5A9B8FF829FF1FFB1C9F5FF3949
          D1FF3A4AD1FF3A49D1FF303FBDFF111767D30101062500000005000000000000
          0000000000010000000B785B3DA3E9E1D2FF87A3F2FF87A4F1FF87A3F2FFB9D0
          F7FF3E50D5FF3E50D5FF3F50D5FF3545C2FF141B6AD201010622000000000000
          000000000000000000010000000A2C386FA2C9E2F9FF8CA8F3FF8DA8F3FF8CA8
          F3FFC0D8F9FF4457D9FF4356D9FF4456D9FF3949C2FF141A61C2000000000000
          000000000000000000000000000100000009303D74A1CFE7FBFF92ADF3FF91AD
          F4FF92ADF4FFC6DEFAFF495EDBFF495DDCFF475AD7FF232F8BF0000000000000
          00000000000000000000000000000000000100000008334177A0D4ECFCFF97B2
          F5FF97B2F4FF97B3F5FFCCE4FBFF4A5FDAFF3141A4F6090C214A000000000000
          000000000000000000000000000000000000000000010000000736457A9FD8F0
          FDFF9DB7F5FF9CB7F5FFD9F1FEFF6B81CAF50B0E234700000006000000000000
          0000000000000000000000000000000000000000000000000001000000063947
          7D9EDBF3FEFFDBF3FFFF677FCFF513192C440000000500000001000000000000
          0000000000000000000000000000000000000000000000000000000000010000
          00053543728E4F63AACD151A2D40000000040000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0001000000030000000400000002000000000000000000000000}
        TabOrder = 0
        OnClick = BitBtnLocked1Click
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 328
      ExplicitLeft = 328
    end
  end
  inherited pnlStatus: TPanel
    Top = 423
    Width = 408
    TabOrder = 5
    ExplicitTop = 423
    ExplicitWidth = 408
    inherited pnlNomeForm: TPanel
      Left = 237
      ExplicitLeft = 237
    end
    inherited pnlInfo: TPanel
      Width = 237
      ExplicitWidth = 237
    end
  end
  object pnlCodBar: TPanel [2]
    Left = 0
    Top = 65
    Width = 408
    Height = 36
    Align = alTop
    ParentColor = True
    TabOrder = 0
    object Label5: TLabel
      Left = 8
      Top = 10
      Width = 87
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo de Barras:'
    end
    object edtCodEan: TEditFocus
      Left = 101
      Top = 7
      Width = 121
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlCodFab: TPanel [3]
    Left = 0
    Top = 101
    Width = 408
    Height = 36
    Align = alTop
    ParentColor = True
    TabOrder = 1
    object Label2: TLabel
      Left = 4
      Top = 10
      Width = 90
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo de F'#225'brica:'
    end
    object lblAddmarca: TLabel
      Left = 227
      Top = 10
      Width = 42
      Height = 14
      Caption = '+ Marca:'
    end
    object edtCodFab: TEditFocus
      Left = 100
      Top = 8
      Width = 121
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtMarca: TEditFocus
      Left = 275
      Top = 8
      Width = 121
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ParentShowHint = False
      ShowHint = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object GroupBox1: TGroupBox [4]
    Left = 0
    Top = 194
    Width = 408
    Height = 79
    Align = alTop
    Caption = 'Dados do Produto:'
    TabOrder = 3
    object lblNome: TLabel
      Left = 46
      Top = 16
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nome:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblCodFab: TLabel
      Left = 11
      Top = 44
      Width = 70
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'd. F'#225'brica:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblMarca: TLabel
      Left = 45
      Top = 58
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Marca:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblRetNome: TLabel
      Left = 86
      Top = 16
      Width = 319
      Height = 28
      AutoSize = False
      WordWrap = True
    end
    object lblRetCodFab: TLabel
      Left = 86
      Top = 44
      Width = 3
      Height = 14
    end
    object lblRetMarca: TLabel
      Left = 86
      Top = 58
      Width = 3
      Height = 14
    end
  end
  object btnBuscar: TBitBtnLocked [5]
    Left = 0
    Top = 170
    Width = 408
    Height = 24
    Align = alTop
    Caption = '&Buscar Produto'
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000004A220966AC5116F07B380FAB0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00004D230A69B85617FFBB5617FFAE4F16F30000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004D24
      0A69BC5819FFBB5718FFB95318FC401D08570000000000000000000000000000
      000000000000281406368A4315B7B3571AF0B35818F0854012B466300E89BD59
      19FFBC5919FFBA5719FC401E0857000000000000000000000000000000000000
      00005A2D0F78C05F1FFFC06021FFCD8250FFCD824FFFBE5D1FFFBE5A1BFFBD5A
      19FFBB5819FC401E095700000000000000000000000000000000000000003018
      083FC0601FFCCD804CFFF7EAE2FFFFFFFFFFFFFFFFFFF7EAE2FFCA7A46FFBC5A
      1BFF622F0D84000000000000000000000000000000000000000000000000944B
      18C3C36929FFF6E9E0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6E8DFFFC063
      23FF854012B4000000000000000000000000000000000000000000000000B75D
      20F0D18958FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCF84
      54FFAD541AEA000000000000000000000000000000000000000000000000B85E
      20F0D18A59FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD085
      55FFAE541AEA000000000000000000000000000000000000000000000000964D
      1BC3C5692BFFF7EBE2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6E8DFFFC164
      26FF854214B40000000000000000000000000000000000000000000000003019
      093FC36525FFCF844FFFF7EBE2FFFFFFFFFFFFFFFFFFF7EBE2FFCD804CFFBF5E
      1FFF361B08480000000000000000000000000000000000000000000000000000
      00005E31127BC36625FFC46726FFCF8551FFCF8350FFC46523FFC16020FF5D2E
      0F7B000000000000000000000000000000000000000000000000000000000000
      0000000000003019093F874518B1AD591EE4AD591EE4864517B13018083F0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000}
    TabOrder = 2
    OnClick = btnBuscarClick
  end
  object pnlApis: TPanel [6]
    Left = 0
    Top = 0
    Width = 408
    Height = 65
    Align = alTop
    Caption = 'pnlApis'
    TabOrder = 6
    object Label3: TLabel
      Left = 1
      Top = 1
      Width = 406
      Height = 14
      Align = alTop
      Caption = 'Integra'#231#245'es dispon'#237'veis para consulta:'
      ExplicitWidth = 186
    end
    object chkConsultaAPI: TCheckListBox
      Left = 1
      Top = 15
      Width = 406
      Height = 49
      OnClickCheck = chkConsultaAPIClickCheck
      Align = alBottom
      Columns = 2
      ItemHeight = 14
      TabOrder = 0
    end
  end
  object Panel5: TPanel [7]
    Left = 0
    Top = 273
    Width = 408
    Height = 122
    Align = alClient
    Caption = 'Panel5'
    TabOrder = 7
    ExplicitTop = 262
    ExplicitHeight = 133
    object cxVerticalGrid1: TcxVerticalGrid
      Left = 1
      Top = 1
      Width = 295
      Height = 120
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      BorderStyle = cxcbsNone
      Align = alLeft
      OptionsView.RowHeaderWidth = 189
      OptionsData.Editing = False
      TabOrder = 0
      ExplicitHeight = 131
      Version = 1
      object cxTitleEstoque: TcxEditorRow
        Properties.Caption = 'Fornecedor'
        Properties.HeaderAlignmentHorz = taCenter
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.DataBinding.ValueType = 'String'
        Properties.Value = 'Estoque'
        Styles.Header = cxStyle1
        Styles.Content = cxStyle2
        ID = 0
        ParentID = -1
        Index = 0
        Version = 1
      end
      object rowAncora: TcxEditorRow
        Properties.Caption = 'Ancora'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.EditProperties.DisplayFormat = '0.00'
        Properties.DataBinding.ValueType = 'String'
        Properties.Value = ''
        Styles.Header = cxStyle1
        Visible = False
        ID = 1
        ParentID = -1
        Index = 1
        Version = 1
      end
      object RowPitStop: TcxEditorRow
        Properties.Caption = 'Pit Stop'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.EditProperties.DisplayFormat = '0.00'
        Properties.DataBinding.ValueType = 'String'
        Properties.Value = ''
        Styles.Header = cxStyle1
        Visible = False
        ID = 2
        ParentID = -1
        Index = 2
        Version = 1
      end
      object rowSkyPecas: TcxEditorRow
        Properties.Caption = 'Sky Pe'#231'as'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.EditProperties.DisplayFormat = '0.00'
        Properties.DataBinding.ValueType = 'String'
        Properties.Value = ''
        Styles.Header = cxStyle1
        Visible = False
        ID = 3
        ParentID = -1
        Index = 3
        Version = 1
      end
      object rowDelta: TcxEditorRow
        Properties.Caption = 'Delta'
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.EditProperties.DisplayFormat = '0.00'
        Properties.DataBinding.ValueType = 'String'
        Properties.Value = ''
        Styles.Header = cxStyle1
        Visible = False
        ID = 4
        ParentID = -1
        Index = 4
        Version = 1
      end
    end
    object cxVerticalGrid2: TcxVerticalGrid
      Left = 296
      Top = 1
      Width = 104
      Height = 120
      Margins.Left = 1
      Margins.Top = 1
      Margins.Right = 1
      Margins.Bottom = 1
      BorderStyle = cxcbsNone
      Align = alLeft
      OptionsView.RowHeaderWidth = 38
      OptionsView.ShowHeaders = False
      OptionsData.Editing = False
      TabOrder = 1
      ExplicitHeight = 131
      Version = 1
      object cxTitlePreco: TcxEditorRow
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.DataBinding.ValueType = 'String'
        Properties.Value = 'Pre'#231'o'
        Styles.Content = cxStyle1
        ID = 0
        ParentID = -1
        Index = 0
        Version = 1
      end
      object cxPrecoAncora: TcxEditorRow
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.EditProperties.DisplayFormat = '0.00'
        Properties.DataBinding.ValueType = 'String'
        Properties.Options.Editing = False
        Properties.Value = ''
        Visible = False
        ID = 1
        ParentID = -1
        Index = 1
        Version = 1
      end
      object cxPrecoPitStop: TcxEditorRow
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.EditProperties.DisplayFormat = '0.00'
        Properties.DataBinding.ValueType = 'String'
        Properties.Options.Editing = False
        Properties.Value = ''
        Visible = False
        ID = 2
        ParentID = -1
        Index = 2
        Version = 1
      end
      object cxPrecoSkyPecas: TcxEditorRow
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.EditProperties.DisplayFormat = '0.00'
        Properties.DataBinding.ValueType = 'String'
        Properties.Options.Editing = False
        Properties.Value = ''
        Visible = False
        ID = 3
        ParentID = -1
        Index = 3
        Version = 1
      end
      object cxPrecoDelta: TcxEditorRow
        Properties.EditPropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.EditProperties.Alignment.Horz = taRightJustify
        Properties.EditProperties.DisplayFormat = '0.00'
        Properties.DataBinding.ValueType = 'String'
        Properties.Options.Editing = False
        Properties.Value = ''
        Visible = False
        ID = 4
        ParentID = -1
        Index = 4
        Version = 1
      end
    end
  end
  object pnlQuantidade: TPanel [8]
    Left = 0
    Top = 137
    Width = 408
    Height = 33
    Align = alTop
    ParentColor = True
    TabOrder = 8
    Visible = False
    object Label1: TLabel
      Left = 39
      Top = 10
      Width = 55
      Height = 14
      Alignment = taRightJustify
      Caption = 'Quantidade'
    end
    object spdQuantidade: TSpinEdit
      Left = 100
      Top = 6
      Width = 121
      Height = 23
      MaxValue = 99999
      MinValue = 1
      TabOrder = 0
      Value = 1
    end
  end
  object cxStyleRepository1: TcxStyleRepository
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
    object cxStyle2: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
  end
end
