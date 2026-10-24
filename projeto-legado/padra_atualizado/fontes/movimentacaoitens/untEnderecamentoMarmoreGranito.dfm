inherited frmEnderecamentoMarmoreGranito: TfrmEnderecamentoMarmoreGranito
  Width = 1024
  Height = 548
  BorderStyle = bsSizeable
  Caption = 'Endere'#231'amento de M'#225'rmore / Granito'
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnCloseQuery = FormCloseQuery
  OnDestroy = FormDestroy
  ExplicitLeft = -192
  ExplicitWidth = 1024
  ExplicitHeight = 548
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 462
    Width = 1008
    ExplicitTop = 462
    ExplicitWidth = 1008
    inherited FlwBotoes: TFlowPanel
      Width = 1004
      ExplicitWidth = 1004
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 109
        Height = 22
        Caption = '[ F10 ] Confirma'
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333330000333333333333333333333333F33333333333
          00003333344333333333333333388F3333333333000033334224333333333333
          338338F3333333330000333422224333333333333833338F3333333300003342
          222224333333333383333338F3333333000034222A22224333333338F338F333
          8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
          33333338F83338F338F33333000033A33333A222433333338333338F338F3333
          0000333333333A222433333333333338F338F33300003333333333A222433333
          333333338F338F33000033333333333A222433333333333338F338F300003333
          33333333A222433333333333338F338F00003333333333333A22433333333333
          3338F38F000033333333333333A223333333333333338F830000333333333333
          333A333333333333333338330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnImprimirEtiquetas: TBitBtnLocked
        Left = 109
        Top = 0
        Width = 196
        Height = 22
        Caption = '[ F8 ] Imprimir Etiquetas Chapas'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FF9F9D9EFF00FFFF00FFFF00FF8281818281818E8A
          8BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F9D9E9F9D9ED4D1D196
          93933B393A545253999797C5C2C4D7D5D5828181FF00FFFF00FFFF00FFFF00FF
          9F9D9E9F9D9EFAFAFAFFFFFFD7D4D59E9C9C4443451C1C1E1C1C1F3534356766
          678281818E8A8BFF00FF918E8F9F9D9EF0EEEFFFFFFFEEEBEBCAC9C99F9D9E8E
          8A8A9793958786866463633C3B3D1F2022201F21747273FF00FF9C9899E9E7E7
          E5E5E5BDBBBBA6A4A4B4B1B1C2C1C1A4A1A19692939290909793959A98988E8A
          8B6B6A6A828181FF00FF959192ADABACA4A1A1B0AFAFC9C9C9D1D3D3EDEDEBF0
          EEF0DCDADAC5C4C4ADABAB9A98999390909793958E8A8BFF00FF918E8FAFADAF
          C9C7C7CECECEC9C9C9E2E2E2D1CFCFA1ABA1BDBCBCCBCECFD5D5D5D3D3D3C6C5
          C5B6B6B6989797FF00FFFF00FF9C999AD0D1D1CFCFCFDCDCDCC9C6C6B5B0B4A5
          D1A7BAC4BCC5A7A1ADA4A3A9A6A7B4B1B2C2C1C1A9A6A7FF00FFFF00FFFF00FF
          9C999AC1BFBFAFADADB1B0B0E3E3E3F6F3F3EEEDEEEDE1DEDCD8D8CCCCCCB4B4
          B4939091FF00FFFF00FFFF00FFFF00FFFF00FF9C999AD8DADACACACB9D9FA0BB
          BFC1D3D5D7D4D9D9D5D5D5C6C5C6AFADADFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFBE5E1F8E0D4E9C9BDE3C7BDE2CCC7DED3CED0CECC959295FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DFFDECEFFCFBDFF
          C4AFFFBAA3FFB199FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFCE9F9DFFDDCEFFCCBCFEC2B0FFBBA4F7A992FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DFFDDCEFFCCBCFE
          C2B0FEB8A3FAB099FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFCE9F9DFAE0D5FFDACCFFCEBDFFC6B1FCB8A3F8AD99FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCE9F9DCE9F9DCE9F9DCE9F9DF3
          AD9DF3AD9DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 1
        OnClick = btnImprimirEtiquetasClick
      end
      object btnMedidasChapas: TBitBtnLocked
        Left = 305
        Top = 0
        Width = 152
        Height = 22
        Caption = '[ F9 ] Medidas das Chapas'
        TabOrder = 2
        OnClick = btnMedidasChapasClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 926
      Top = 2
      ExplicitLeft = 926
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 490
    Width = 1008
    Height = 19
    ExplicitTop = 490
    ExplicitWidth = 1008
    ExplicitHeight = 19
    inherited pnlNomeForm: TPanel
      Left = 837
      Height = 19
      ExplicitLeft = 837
      ExplicitHeight = 19
    end
    inherited pnlInfo: TPanel
      Width = 837
      Height = 19
      ExplicitWidth = 837
      ExplicitHeight = 19
      object ProgressBar1: TProgressBar
        Left = 2
        Top = 2
        Width = 833
        Height = 15
        Align = alClient
        TabOrder = 0
        Visible = False
      end
    end
    inherited pnlBotoesTrace: TPanel
      Height = 19
      ExplicitHeight = 19
      inherited btnIniciarTrace: TSpeedButton
        Height = 19
        ExplicitHeight = 19
      end
      inherited btnPausarTrace: TSpeedButton
        Height = 19
        ExplicitHeight = 19
      end
      inherited btnSalvarTrace: TSpeedButton
        Height = 19
        ExplicitHeight = 19
      end
      inherited btnViewerTrace: TSpeedButton
        Height = 19
        ExplicitHeight = 19
      end
    end
  end
  object pnlHeader: TPanel [2]
    Left = 0
    Top = 0
    Width = 1008
    Height = 34
    Align = alTop
    BevelOuter = bvNone
    ParentBackground = False
    ParentColor = True
    TabOrder = 2
    object lblNotEle: TLabel
      Left = 10
      Top = 13
      Width = 87
      Height = 14
      Alignment = taRightJustify
      Caption = 'Pesq. Documento:'
    end
    object edtDocumento: TEditFocus
      Left = 147
      Top = 5
      Width = 486
      Height = 22
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
    object btnPesDoc: TBitBtnLocked
      Left = 105
      Top = 5
      Width = 41
      Height = 22
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333FF33333333333330003FF3FFFFF3333777003000003333
        300077F777773F333777E00BFBFB033333337773333F7F33333FE0BFBF000333
        330077F3337773F33377E0FBFBFBF033330077F3333FF7FFF377E0BFBF000000
        333377F3337777773F3FE0FBFBFBFBFB039977F33FFFFFFF7377E0BF00000000
        339977FF777777773377000BFB03333333337773FF733333333F333000333333
        3300333777333333337733333333333333003333333333333377333333333333
        333333333333333333FF33333333333330003333333333333777333333333333
        3000333333333333377733333333333333333333333333333333}
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnPesDocClick
    end
  end
  object cxDados: TcxGridCitel [3]
    Left = 0
    Top = 34
    Width = 1008
    Height = 407
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgDados: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgDadosCustomDrawCell
      DataController.DataSource = dtsDados
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = False
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgDadosCODITE: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'FDO_CODITE'
        MinWidth = 64
        Options.Editing = False
      end
      object cxgDadosColumn2: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        DataBinding.FieldName = 'FDO_DESCRI'
        MinWidth = 330
        Options.Editing = False
        Width = 332
      end
      object cxgDadosColumn3: TcxGridDBColumn
        Caption = 'Unidade'
        DataBinding.FieldName = 'UNI_SIGUNI'
        HeaderAlignmentHorz = taCenter
        MinWidth = 64
        Options.Editing = False
      end
      object cxgDadosColumn4: TcxGridDBColumn
        Caption = 'Qtd. Entrada'
        DataBinding.FieldName = 'FDO_QTDITE'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 100
      end
      object cxgDadosColumn5: TcxGridDBColumn
        Caption = 'Saldo'
        DataBinding.FieldName = 'ITE_SALDOS'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
      end
      object cxgDadosNUMLOT: TcxGridDBColumn
        Caption = 'Lote'
        DataBinding.FieldName = 'LOT_NUMLOT'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.CharCase = ecUpperCase
        Properties.MaxLength = 30
        Properties.OnValidate = cxgDadosNUMLOTPropertiesValidate
        MinWidth = 160
        Width = 160
      end
      object cxgDadosQTDCHAPAS: TcxGridDBColumn
        Caption = 'Qtd. Chapas'
        DataBinding.FieldName = 'QTDCHAPA'
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.OnValidate = cxgDadosColumn7PropertiesValidate
        HeaderAlignmentHorz = taRightJustify
        Width = 91
      end
      object cxgDadosSTATUS: TcxGridDBColumn
        DataBinding.FieldName = 'STATUS'
        Visible = False
      end
      object cxgDadosESTPER: TcxGridDBColumn
        Caption = '% Estimado de Perda'
        DataBinding.FieldName = 'ESTPER'
        PropertiesClassName = 'TcxSpinEditProperties'
        Properties.MaxValue = 100.000000000000000000
        HeaderAlignmentHorz = taRightJustify
        Width = 114
      end
    end
    object cxlDados: TcxGridLevel
      GridView = cxgDados
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 441
    Width = 1008
    Height = 21
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    object Shape1: TShape
      Left = 3
      Top = 2
      Width = 16
      Height = 16
      Brush.Color = clMoneyGreen
    end
    object Label1: TLabel
      Left = 25
      Top = 3
      Width = 119
      Height = 14
      Caption = 'Chapas e lotes definidos'
    end
  end
  object dtsDados: TDataSource
    Left = 448
    Top = 260
  end
end
