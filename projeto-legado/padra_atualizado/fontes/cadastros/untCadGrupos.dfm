inherited frmCadGrupos: TfrmCadGrupos
  Left = 344
  Top = 370
  Width = 728
  Height = 272
  Caption = 'Cadastro de Linha e Grupo'
  ExplicitWidth = 728
  ExplicitHeight = 272
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 202
    Width = 722
    Height = 25
    TabOrder = 1
    ExplicitTop = 202
    ExplicitWidth = 722
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 718
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 718
      inherited btnIncluir: TBitBtnLocked
        Width = 85
        ExplicitWidth = 85
      end
      inherited btnGravar: TBitBtnLocked
        Left = 85
        Width = 85
        ExplicitLeft = 85
        ExplicitWidth = 85
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 170
        Width = 85
        ExplicitLeft = 170
        ExplicitWidth = 85
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 255
        Width = 85
        ExplicitLeft = 255
        ExplicitWidth = 85
      end
      inherited btnCancela: TBitBtnLocked
        Left = 340
        Width = 85
        ExplicitLeft = 340
        ExplicitWidth = 85
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 425
        Width = 85
        ExplicitLeft = 425
        ExplicitWidth = 85
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 643
      Height = 21
      Align = alRight
      ExplicitLeft = 642
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Width = 722
    Height = 202
    Visible = False
    ExplicitWidth = 722
    ExplicitHeight = 199
    inherited tbsGeral: TTabSheet
      ParentFont = False
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 714
      ExplicitHeight = 167
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 722
    Height = 202
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    ExplicitHeight = 199
    object Label2: TLabel
      Left = 62
      Top = 36
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label1: TLabel
      Left = 78
      Top = 14
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label4: TLabel
      Left = 64
      Top = 60
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Comiss'#227'o:'
    end
    object Label5: TLabel
      Left = 160
      Top = 60
      Width = 10
      Height = 14
      Alignment = taRightJustify
      Caption = '%'
    end
    object lblDesLin: TLabel
      Left = 14
      Top = 85
      Width = 100
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descr. Reduz. Linha:'
    end
    object lblDesGru: TLabel
      Left = 10
      Top = 107
      Width = 104
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descr. Reduz. Grupo:'
    end
    object lblDetLin: TLabel
      Left = 10
      Top = 129
      Width = 104
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descr. Etiqueta Linha:'
    end
    object lblDetGru: TLabel
      Left = 6
      Top = 151
      Width = 108
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descr. Etiqueta Grupo:'
    end
    object lblSgEtGr: TLabel
      Left = 14
      Top = 174
      Width = 100
      Height = 14
      Alignment = taRightJustify
      Caption = 'Sigla Etiqueta Grupo:'
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 117
      Top = 32
      Width = 448
      Height = 22
      CharCase = ecUpperCase
      DataField = 'GRU_DESGRU'
      DataSource = dtsCadGru
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCodgru: TDBEditFocus
      Tag = 99
      Left = 117
      Top = 10
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'GRU_CODGRU'
      DataSource = dtsCadGru
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbePerCom: TDBEditFocus
      Tag = 99
      Left = 117
      Top = 56
      Width = 42
      Height = 22
      CharCase = ecUpperCase
      DataField = 'GRU_PERCOM'
      DataSource = dtsCadGru
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 6
      ParentFont = False
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeDesLin: TDBEditFocus
      Tag = 99
      Left = 117
      Top = 81
      Width = 448
      Height = 22
      CharCase = ecUpperCase
      DataField = 'GRU_DRELIN'
      DataSource = dtsCadGru
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDesGru: TDBEditFocus
      Tag = 99
      Left = 117
      Top = 103
      Width = 448
      Height = 22
      CharCase = ecUpperCase
      DataField = 'GRU_DREGRU'
      DataSource = dtsCadGru
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDetLin: TDBEditFocus
      Tag = 99
      Left = 117
      Top = 125
      Width = 448
      Height = 22
      CharCase = ecUpperCase
      DataField = 'GRU_DETLIN'
      DataSource = dtsCadGru
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDetGru: TDBEditFocus
      Tag = 99
      Left = 117
      Top = 147
      Width = 448
      Height = 22
      CharCase = ecUpperCase
      DataField = 'GRU_DETGRU'
      DataSource = dtsCadGru
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeSgEtGr: TDBEditFocus
      Tag = 99
      Left = 117
      Top = 170
      Width = 448
      Height = 22
      CharCase = ecUpperCase
      DataField = 'GRU_SGETGR'
      DataSource = dtsCadGru
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object pnlTipo: TPanel
      Left = 199
      Top = 56
      Width = 221
      Height = 23
      BevelOuter = bvNone
      TabOrder = 8
      object lblTipo: TLabel
        Left = 10
        Top = 4
        Width = 23
        Height = 14
        Alignment = taRightJustify
        Caption = 'Tipo:'
      end
      object clbTipGru: TColorLabel
        Left = 53
        Top = 4
        Width = 162
        Height = 14
        Caption = '(0) Outros   (1) Pe'#231'as   (2) Pneus'
        CorDestaque = clRed
      end
      object dbeTipGru: TDBEditFocus
        Tag = 99
        Left = 35
        Top = 1
        Width = 15
        Height = 22
        DataField = 'GRU_TIPGRU'
        DataSource = dtsCadGru
        MaxLength = 1
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttNumerico
      end
    end
    object pnlImgGru: TPanel
      Left = 579
      Top = 12
      Width = 131
      Height = 95
      BevelInner = bvLowered
      BorderWidth = 2
      BorderStyle = bsSingle
      Color = clWhite
      DoubleBuffered = True
      ParentBackground = False
      ParentDoubleBuffered = False
      TabOrder = 9
      OnDblClick = imgGruDblClick
      object lblErrImg: TLabel
        Left = 4
        Top = 4
        Width = 119
        Height = 83
        Align = alClient
        Alignment = taCenter
        Caption = 
          'N'#227'o foi poss'#237'vel carregar a imagem. Verifique o formato do arqui' +
          'vo!'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        Visible = False
        WordWrap = True
        OnDblClick = imgGruDblClick
        ExplicitWidth = 118
        ExplicitHeight = 36
      end
      object imgGru: TcxImage
        Left = 4
        Top = 4
        Align = alClient
        Properties.FitMode = ifmProportionalStretch
        Properties.PopupMenuLayout.MenuItems = []
        TabOrder = 0
        OnDblClick = imgGruDblClick
        Height = 83
        Width = 119
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 227
    Width = 722
    TabOrder = 3
    ExplicitTop = 227
    ExplicitWidth = 722
    inherited pnlNomeForm: TPanel
      Left = 547
      Width = 175
      ExplicitLeft = 547
      ExplicitWidth = 175
    end
    inherited pnlInfo: TPanel
      Width = 547
      ExplicitWidth = 547
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 416
  end
  object dtsCadGru: TDataSource
    Left = 312
    Top = 16
  end
end
