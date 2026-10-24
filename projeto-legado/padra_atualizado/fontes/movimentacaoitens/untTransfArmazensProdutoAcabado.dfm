inherited frmTransfArmazensProdutoAcabado: TfrmTransfArmazensProdutoAcabado
  Width = 1024
  Height = 766
  BorderStyle = bsSizeable
  Caption = 'Transfer'#234'ncia entre Armaz'#233'ns Produto Acabado'
  Position = poScreenCenter
  ExplicitWidth = 1024
  ExplicitHeight = 766
  PixelsPerInch = 96
  TextHeight = 14
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 539
    Width = 1008
    Height = 5
    Cursor = crVSplit
    Align = alBottom
    ExplicitLeft = 32
    ExplicitTop = 534
  end
  inherited pnlBotoes: TPanel
    Top = 685
    Width = 1008
    TabOrder = 2
    ExplicitTop = 685
    ExplicitWidth = 1008
    inherited FlwBotoes: TFlowPanel
      Width = 1004
      ExplicitWidth = 1004
      inherited btnConfirma: TBitBtnLocked
        Width = 115
        Align = alLeft
        Caption = '[ F10 ] Confirma'
        ModalResult = 0
        ExplicitWidth = 115
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 929
      Top = 2
      Anchors = [akTop, akRight]
      ExplicitLeft = 929
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 711
    Width = 1008
    TabOrder = 3
    ExplicitTop = 711
    ExplicitWidth = 1008
    inherited pnlNomeForm: TPanel
      Left = 837
      ExplicitLeft = 837
    end
    inherited pnlInfo: TPanel
      Width = 837
      ExplicitWidth = 837
    end
  end
  object cxgItens: TcxGridCitel [3]
    Left = 0
    Top = 57
    Width = 1008
    Height = 482
    Align = alClient
    BevelInner = bvNone
    BevelOuter = bvNone
    TabOrder = 1
    OnEnter = cxgItensEnter
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgItensView: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      OnEditKeyPress = cxgItensViewEditKeyPress
      DataController.DataSource = dtsGrid
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = ' '
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = True
      CorZebra = clMoneyGreen
      object cxgItensViewCODITE: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODITE'
        Options.Editing = False
        Width = 49
      end
      object cxgItensViewDESITE: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'DESITE'
        Options.Editing = False
        Width = 479
      end
      object cxgItensViewCODBAR: TcxGridDBColumn
        Caption = 'C'#243'digo de Barras'
        DataBinding.FieldName = 'ITE_CODBAR'
        Options.Editing = False
        Width = 90
      end
      object cxgItensViewSALORI: TcxGridDBColumn
        Caption = 'Armaz'#233'm Origem'
        DataBinding.FieldName = 'SALORI'
        Options.Editing = False
        Width = 89
      end
      object cxgItensViewSALORIDIS: TcxGridDBColumn
        Caption = 'Saldo Dispon'#237'vel Armaz'#233'm Origem'
        DataBinding.FieldName = 'SALORIDIS'
        Options.Editing = False
        Width = 170
      end
      object cxgItensViewARMORI: TcxGridDBColumn
        Caption = 'Armaz'#233'm Origem'
        DataBinding.FieldName = 'ARMORI'
        Visible = False
        Options.Editing = False
        Width = 80
      end
      object cxgItensViewDESAMZORI: TcxGridDBColumn
        Caption = 'Desc. Armaz. Ori.'
        DataBinding.FieldName = 'DESAMZORI'
        Visible = False
        Options.Editing = False
        Width = 100
      end
      object cxgItensViewAMZDES: TcxGridDBColumn
        Caption = 'Armaz'#233'm Destino'
        DataBinding.FieldName = 'ARMDES'
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.OnButtonClick = cxgItensViewDESAMZDESPropertiesButtonClick
        Width = 91
      end
      object cxgItensViewTAQtdItem: TcxGridDBColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'QTDITE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.0000'
        Properties.OnEditValueChanged = cxgItensViewTAQtdItemPropertiesEditValueChanged
        HeaderAlignmentHorz = taRightJustify
        Width = 80
      end
      object cxgItensViewTAQtdMaxDes: TcxGridDBColumn
        DataBinding.FieldName = 'MAXDES'
        Visible = False
        Options.Editing = False
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxgItensView
    end
  end
  object pnlItem: TPanel [4]
    Left = 0
    Top = 0
    Width = 1008
    Height = 57
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    OnEnter = pnlItemEnter
    OnExit = pnlItemExit
    object Label1: TLabel
      Left = 63
      Top = 30
      Width = 56
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Produto:'
    end
    object lblOrigem: TLabel
      Left = 26
      Top = 5
      Width = 93
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Armaz'#233'm origem:'
    end
    object btnConfirmar: TBitBtnLocked
      Left = 554
      Top = 27
      Width = 81
      Height = 22
      Caption = '&Confirma'
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
      TabOrder = 4
      OnClick = btnConfirmarClick
    end
    object edtDesAmz: TEditFocus
      Left = 175
      Top = 2
      Width = 373
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
    object edtCodIte: TEditFocus
      Left = 120
      Top = 28
      Width = 52
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
      MaxLength = 5
      ParentFont = False
      TabOrder = 2
      OnExit = edtCodIteExit
      OnKeyPress = edtCodIteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttAlfanumerico
    end
    object edtDesIte: TEditFocus
      Left = 175
      Top = 27
      Width = 373
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
    object edtCodAmz: TEditFocus
      Tag = 99
      Left = 121
      Top = 2
      Width = 52
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 0
      OnExit = edtCodAmzExit
      OnKeyPress = edtCodAmzKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object prgProgresso: TProgressBar [5]
    Left = 0
    Top = 669
    Width = 1008
    Height = 16
    Align = alBottom
    Smooth = True
    TabOrder = 4
    Visible = False
  end
  object pnlCabec: TPanel [6]
    Left = 0
    Top = 544
    Width = 1008
    Height = 125
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 5
    object cxGridCitel1: TcxGridCitel
      Left = 1
      Top = 1
      Width = 264
      Height = 123
      Align = alLeft
      BevelInner = bvNone
      BevelOuter = bvNone
      TabOrder = 0
      OnEnter = cxgItensEnter
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxgArmazensView: TcxGridDBTableViewCitel
        Navigator.Buttons.CustomButtons = <>
        DataController.DataSource = dtsGridArmazens
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = '#,##0.00'
            Kind = skSum
            Column = cxgArmazensViewSALDOS
          end>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsView.NoDataToDisplayInfoText = ' '
        OptionsView.ColumnAutoWidth = True
        OptionsView.Footer = True
        OptionsView.GroupByBox = False
        Zebra = True
        Destaque = True
        CorZebra = clMoneyGreen
        object cxgArmazensViewDESARM: TcxGridDBColumn
          Caption = 'Armaz'#233'ns'
          DataBinding.FieldName = 'LOT_NUMLOT'
          Width = 136
        end
        object cxgArmazensViewSALDOS: TcxGridDBColumn
          Caption = 'Saldo'
          DataBinding.FieldName = 'LOT_SALDOS'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '#,##0.00'
        end
      end
      object cxGridLevel1: TcxGridLevel
        GridView = cxgArmazensView
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 200
    Top = 312
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 168
    Top = 312
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 120
    Top = 456
  end
  object dtsItens: TDataSource
    DataSet = cdsItens
    Left = 8
  end
  object cdsItens: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    AfterScroll = cdsItensAfterScroll
    Left = 192
    Top = 392
    object cdsItensCODITE: TStringField
      DisplayWidth = 20
      FieldName = 'CODITE'
    end
    object cdsItensARMORI: TStringField
      FieldName = 'ARMORI'
      Size = 30
    end
    object cdsItensARMDES: TStringField
      FieldName = 'ARMDES'
      OnValidate = cdsItensARMDESValidate
      Size = 30
    end
    object cdsItensQTDITE: TFloatField
      FieldName = 'QTDITE'
    end
    object cdsItensSALORI: TFloatField
      FieldName = 'SALORI'
    end
    object cdsItensSALDES: TFloatField
      FieldName = 'SALDES'
    end
    object cdsItensMAXORI: TFloatField
      FieldName = 'MAXORI'
    end
    object cdsItensMAXDES: TFloatField
      FieldName = 'MAXDES'
    end
    object cdsItensREPORI: TFloatField
      FieldName = 'REPORI'
    end
    object cdsItensREPDES: TFloatField
      FieldName = 'REPDES'
    end
    object cdsItensDESITE: TStringField
      FieldName = 'DESITE'
      Size = 70
    end
    object cdsItensSALDOS: TFloatField
      FieldName = 'SALDOS'
    end
    object cdsItensPRECUS: TFloatField
      FieldName = 'PRECUS'
    end
    object cdsItensLOCORI: TStringField
      FieldName = 'LOCORI'
    end
    object cdsItensLOCDES: TStringField
      FieldName = 'LOCDES'
    end
    object cdsItensDESLFO: TStringField
      FieldName = 'DESLFO'
      Size = 50
    end
    object cdsItensDESLFD: TStringField
      FieldName = 'DESLFD'
      Size = 50
    end
    object cdsItensCODMAR: TStringField
      FieldName = 'CODMAR'
      Size = 6
    end
    object cdsItensDESMAR: TStringField
      FieldName = 'DESMAR'
      Size = 30
    end
    object cdsItensSIGUNI: TStringField
      FieldName = 'SIGUNI'
      Size = 6
    end
    object cdsItensSALORIRES: TFloatField
      FieldName = 'SALORIRES'
    end
    object cdsItensSALORIDIS: TFloatField
      FieldName = 'SALORIDIS'
    end
    object cdsItensSALDESRES: TFloatField
      FieldName = 'SALDESRES'
    end
    object cdsItensSALDESDIS: TFloatField
      FieldName = 'SALDESDIS'
    end
    object cdsItensDESAMZLOCORI: TStringField
      FieldName = 'DESAMZLOCORI'
      Size = 150
    end
    object cdsItensDESAMZLOCDES: TStringField
      FieldName = 'DESAMZLOCDES'
      Size = 150
    end
    object cdsItensDESAMZORI: TStringField
      FieldName = 'DESAMZORI'
    end
    object cdsItensDESAMZDES: TStringField
      FieldName = 'DESAMZDES'
    end
    object cdsItensDESLOCORI: TStringField
      FieldName = 'DESLOCORI'
      Size = 50
    end
    object cdsItensDESLOCDES: TStringField
      FieldName = 'DESLOCDES'
      Size = 50
    end
    object cdsItensCODBAR: TStringField
      FieldName = 'CODBAR'
    end
    object cdsItensTOTCUS: TAggregateField
      FieldName = 'TOTCUS'
      Active = True
      DisplayName = ''
      Expression = 'SUM(PRECUS * QTDITE)'
    end
  end
  object dtsGrid: TDataSource
    DataSet = cdsItens
    Left = 224
    Top = 392
  end
  object dtsGridArmazens: TDataSource
    Left = 232
    Top = 432
  end
end
