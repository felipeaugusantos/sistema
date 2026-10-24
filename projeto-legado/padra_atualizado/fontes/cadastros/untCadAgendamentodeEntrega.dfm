inherited frmCadAgendamentodeEntrega: TfrmCadAgendamentodeEntrega
  Width = 676
  Height = 522
  Caption = 'Agendamento de Entrega'
  OnDestroy = FormDestroy
  ExplicitWidth = 676
  ExplicitHeight = 522
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 452
    Width = 670
    Height = 25
    ExplicitTop = 452
    ExplicitWidth = 670
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 589
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 589
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 85
        Height = 21
        Align = alLeft
        ExplicitWidth = 85
        ExplicitHeight = 21
      end
      inherited btnGravar: TBitBtnLocked
        Left = 85
        Width = 85
        Height = 21
        Align = alLeft
        ExplicitLeft = 85
        ExplicitWidth = 85
        ExplicitHeight = 21
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 170
        Width = 85
        Height = 21
        Align = alLeft
        ExplicitLeft = 170
        ExplicitWidth = 85
        ExplicitHeight = 21
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 255
        Width = 85
        Height = 21
        Align = alLeft
        ExplicitLeft = 255
        ExplicitWidth = 85
        ExplicitHeight = 21
      end
      inherited btnCancela: TBitBtnLocked
        Left = 340
        Width = 85
        Height = 21
        Align = alLeft
        ExplicitLeft = 340
        ExplicitWidth = 85
        ExplicitHeight = 21
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 425
        Width = 85
        Height = 21
        Align = alLeft
        ExplicitLeft = 425
        ExplicitWidth = 85
        ExplicitHeight = 21
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 591
      Height = 21
      Align = alRight
      ExplicitLeft = 591
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 477
    Width = 670
    ExplicitTop = 477
    ExplicitWidth = 670
    inherited pnlNomeForm: TPanel
      Left = 472
      Width = 198
      ExplicitLeft = 472
      ExplicitWidth = 198
    end
    inherited pnlInfo: TPanel
      Width = 472
      ExplicitWidth = 472
    end
  end
  inherited pgcDados: TPageControl
    Left = 1263
    Top = 116
    Width = 105
    Height = 55
    Align = alNone
    ExplicitLeft = 1263
    ExplicitTop = 116
    ExplicitWidth = 105
    ExplicitHeight = 55
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 97
      ExplicitHeight = 23
    end
  end
  object pnlTopo: TPanel [3]
    Left = 0
    Top = 0
    Width = 670
    Height = 149
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 4
    object lbl4: TLabel
      Left = 87
      Top = 5
      Width = 75
      Height = 14
      Alignment = taRightJustify
      Caption = 'Transportadora'
    end
    object lbl1: TLabel
      Left = 401
      Top = 5
      Width = 26
      Height = 14
      Alignment = taRightJustify
      Caption = 'Placa'
    end
    object Label1: TLabel
      Left = 11
      Top = 5
      Width = 33
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo'
    end
    object Label2: TLabel
      Left = 488
      Top = 5
      Width = 22
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data'
    end
    object Label3: TLabel
      Left = 575
      Top = 5
      Width = 23
      Height = 14
      Alignment = taRightJustify
      Caption = 'Hora'
    end
    object Bevel1: TBevel
      Left = -1
      Top = 49
      Width = 695
      Height = 8
      Shape = bsTopLine
    end
    object Label4: TLabel
      Left = 8
      Top = 57
      Width = 89
      Height = 14
      Caption = 'Chave de Acesso '
    end
    object Label5: TLabel
      Left = 8
      Top = 101
      Width = 54
      Height = 14
      Caption = 'Documento'
    end
    object Label6: TLabel
      Left = 174
      Top = 101
      Width = 25
      Height = 14
      Caption = 'S'#233'rie'
    end
    object Label30: TLabel
      Left = 220
      Top = 101
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor'
    end
    object Label7: TLabel
      Left = 116
      Top = 101
      Width = 38
      Height = 14
      Caption = 'Esp'#233'cie'
    end
    object dbeCodTra: TDBEditFocus
      Tag = 99
      Left = 87
      Top = 21
      Width = 50
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ARC_CODTRA'
      DataSource = dtsAgeRec
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 0
      OnKeyPress = dbeCodTraKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      PanelInfo = pnlInfo
      TipoTexto = ttNumerico
    end
    object edtNomTra: TEditFocus
      Left = 139
      Top = 21
      Width = 257
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
    object dbePlaca_: TDBEditFocus
      Tag = 99
      Left = 401
      Top = 21
      Width = 82
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ARC_PLACA_'
      DataSource = dtsAgeRec
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 2
      OnExit = dbePlaca_Exit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 8
      Top = 21
      Width = 74
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ARC_CODIGO'
      DataSource = dtsAgeRec
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeDtaEnt: TDBEditFocus
      Tag = 99
      Left = 488
      Top = 21
      Width = 82
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ARC_DTAENT'
      DataSource = dtsAgeRec
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeHraEnt: TDBEditFocus
      Tag = 99
      Left = 575
      Top = 21
      Width = 82
      Height = 22
      CharCase = ecUpperCase
      DataField = 'ARC_HRAENT'
      DataSource = dtsAgeRec
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtAcesso: TEditFocus
      Tag = 99
      Left = 8
      Top = 72
      Width = 523
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 44
      TabOrder = 6
      OnKeyPress = edtAcessoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
    end
    object edtNumDoc: TEditFocus
      Tag = 99
      Left = 8
      Top = 116
      Width = 103
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 44
      TabOrder = 7
      OnKeyPress = edtAcessoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtSerie: TEditFocus
      Tag = 99
      Left = 174
      Top = 116
      Width = 37
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 44
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 217
      Top = 116
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 10
      OnKeyPress = edtCodForKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomFor: TEditFocus
      Left = 290
      Top = 116
      Width = 241
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 11
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtEspDoc: TEditFocus
      Tag = 99
      Left = 116
      Top = 116
      Width = 48
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 44
      TabOrder = 8
      Text = 'NF'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object Panel2: TPanel [4]
    Left = 0
    Top = 149
    Width = 670
    Height = 303
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object cxgDocumentos: TcxGridCitel
      Left = 0
      Top = 0
      Width = 670
      Height = 303
      Align = alClient
      TabOrder = 0
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxgDocumentosTableView: TcxGridDBTableViewCitel
        OnKeyUp = cxgDocumentosTableViewKeyUp
        Navigator.Buttons.CustomButtons = <>
        DataController.Filter.Options = [fcoCaseInsensitive]
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.ApplyChanges = fracDelayed
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
        OptionsView.GroupByBox = False
        Zebra = True
        Destaque = True
        CorZebra = clMoneyGreen
        object cxgDocumentosTableViewADC_NUMDOC: TcxGridDBColumn
          Caption = 'Documento'
          DataBinding.FieldName = 'ADC_NUMDOC'
          Width = 105
        end
        object cxgDocumentosTableViewADC_ESPDOC: TcxGridDBColumn
          Caption = 'Especie'
          DataBinding.FieldName = 'ADC_ESPDOC'
          Width = 63
        end
        object cxgDocumentosTableViewADC_SERIE_: TcxGridDBColumn
          Caption = 'S'#233'rie'
          DataBinding.FieldName = 'ADC_SERIE_'
          Width = 52
        end
        object cxgDocumentosTableViewADC_CODFOR: TcxGridDBColumn
          Caption = 'C'#243'd. Fornecedor'
          DataBinding.FieldName = 'ADC_CODFOR'
          Width = 94
        end
        object cxgDocumentosTableViewFOR_NOMFOR: TcxGridDBColumn
          Caption = 'Fornecedor'
          DataBinding.FieldName = 'FOR_NOMFOR'
          Width = 277
        end
      end
      object cxgDocumentosLevel: TcxGridLevel
        GridView = cxgDocumentosTableView
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 704
    Top = 32
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 732
    Top = 32
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 732
    Top = 4
  end
  object dtsAgeRec: TDataSource
    Left = 764
    Top = 4
  end
end
