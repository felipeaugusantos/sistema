inherited frmCalNivGirEstFornecMarkup: TfrmCalNivGirEstFornecMarkup
  Width = 604
  Height = 526
  BorderStyle = bsSizeable
  Caption = 'Infome o Markup para os grupos de produtos'
  ExplicitWidth = 604
  ExplicitHeight = 526
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 443
    Width = 588
    ExplicitTop = 443
    ExplicitWidth = 588
    DesignSize = (
      588
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 584
      TabOrder = 2
      ExplicitWidth = 584
    end
    inherited btnSair: TBitBtnLocked
      Left = 508
      ExplicitLeft = 508
    end
    object btnConfirma: TBitBtnLocked
      Left = 4
      Top = 3
      Width = 75
      Height = 22
      Caption = '&Confirma'
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
  end
  inherited pnlStatus: TPanel
    Top = 471
    Width = 588
    ExplicitTop = 471
    ExplicitWidth = 588
    inherited pnlNomeForm: TPanel
      Left = 417
      ExplicitLeft = 417
    end
    inherited pnlInfo: TPanel
      Width = 417
      ExplicitWidth = 417
    end
  end
  object pnlFiltros: TPanel [2]
    Left = 0
    Top = 0
    Width = 588
    Height = 241
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    object Label5: TLabel
      Left = 9
      Top = 7
      Width = 106
      Height = 14
      Caption = 'Data de Entrada Inicial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 9
      Top = 42
      Width = 102
      Height = 14
      Caption = 'Data de Entrada Final'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblEmpresa: TLabel
      Left = 9
      Top = 82
      Width = 42
      Height = 14
      Caption = 'Empresa'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 9
      Top = 124
      Width = 56
      Height = 14
      Caption = 'Fornecedor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 9
      Top = 21
      Width = 64
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 0
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 9
      Top = 56
      Width = 64
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 10
      ParentFont = False
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtCodEmpresa: TEditFocus
      Tag = 99
      Left = 8
      Top = 96
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesEmpresa: TEditFocus
      Left = 74
      Top = 96
      Width = 365
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtFornecedor: TEditFocus
      Tag = 99
      Left = 9
      Top = 138
      Width = 64
      Height = 22
      Alignment = taLeftJustify
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 8
      ParentFont = False
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesFornecedor: TEditFocus
      Left = 74
      Top = 138
      Width = 365
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object grbTabPreco: TGroupBox
      Left = 8
      Top = 162
      Width = 431
      Height = 48
      Caption = 'Tabela de Pre'#231'o Somente para c'#225'lculo do pre'#231'o de venda'
      TabOrder = 6
      object Label9: TLabel
        Left = 8
        Top = 22
        Width = 80
        Height = 14
        Alignment = taRightJustify
        Caption = 'Tabela de Pre'#231'o:'
      end
      object edtNomTab: TEditFocus
        Left = 154
        Top = 19
        Width = 271
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
      object edtTabPre: TEditFocus
        Tag = 99
        Left = 89
        Top = 19
        Width = 64
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        MaxLength = 6
        ParentFont = False
        TabOrder = 1
        OnExit = edtTabPreExit
        OnKeyPress = edtTabPreKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttNumerico
      end
    end
    object chkArrMai: TCheckBox
      Left = 8
      Top = 216
      Width = 280
      Height = 17
      Caption = 'Arredondar '#250'ltima casa decimal'
      TabOrder = 7
    end
  end
  object cxgGrupos: TcxGrid [3]
    Left = 0
    Top = 241
    Width = 588
    Height = 202
    Align = alClient
    TabOrder = 3
    object cxgGruposView: TcxGridDBTableView
      OnKeyDown = cxgGruposViewKeyDown
      Navigator.Buttons.CustomButtons = <>
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.GroupByBox = False
      object cxgGruposViewColumn1: TcxGridDBColumn
        Caption = 'Grupo'
        DataBinding.FieldName = 'CODGRP'
        Options.Editing = False
        Width = 58
      end
      object cxgGruposViewColumn2: TcxGridDBColumn
        Caption = 'Descri'#231#227'o do Grupo'
        DataBinding.FieldName = 'DESGRP'
        Options.Editing = False
        Width = 322
      end
      object cxgGruposViewColumn3: TcxGridDBColumn
        Caption = 'N'#237'vel A'
        DataBinding.FieldName = 'MKPNVA'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(-0.00)'
        HeaderAlignmentHorz = taRightJustify
      end
      object cxgGruposViewColumn4: TcxGridDBColumn
        Caption = 'N'#237'vel B'
        DataBinding.FieldName = 'MKPNVB'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(-0.00)'
        HeaderAlignmentHorz = taRightJustify
      end
      object cxgGruposViewColumn5: TcxGridDBColumn
        Caption = 'N'#237'vel C'
        DataBinding.FieldName = 'MKPNVC'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00;(-0.00)'
        HeaderAlignmentHorz = taRightJustify
      end
    end
    object cxgGruposLevel1: TcxGridLevel
      GridView = cxgGruposView
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 376
    Top = 16
  end
  object PopupMenu1: TPopupMenu
    Left = 344
    Top = 16
    object MenuItem1: TMenuItem
      Caption = 'Configurar Relat'#243'rio'
      OnClick = mnuConfigurarRelClick
    end
  end
  object ApplicationEvents1: TApplicationEvents
    OnMessage = ApplicationEventsMessage
    Left = 312
    Top = 16
  end
end
