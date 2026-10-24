inherited frmCadGrupoProdutos: TfrmCadGrupoProdutos
  Width = 726
  Height = 193
  Caption = 'Grupo de Produtos'
  ExplicitWidth = 726
  ExplicitHeight = 193
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 123
    Width = 720
    Height = 25
    ExplicitTop = 123
    ExplicitWidth = 720
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 646
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 646
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 82
        Height = 21
        ExplicitWidth = 82
        ExplicitHeight = 21
      end
      inherited btnGravar: TBitBtnLocked
        Left = 82
        Width = 83
        Height = 21
        ExplicitLeft = 82
        ExplicitWidth = 83
        ExplicitHeight = 21
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 165
        Width = 83
        Height = 21
        ExplicitLeft = 165
        ExplicitWidth = 83
        ExplicitHeight = 21
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 248
        Width = 83
        Height = 21
        ExplicitLeft = 248
        ExplicitWidth = 83
        ExplicitHeight = 21
      end
      inherited btnCancela: TBitBtnLocked
        Left = 331
        Width = 84
        Height = 21
        ExplicitLeft = 331
        ExplicitWidth = 84
        ExplicitHeight = 21
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 415
        Width = 84
        Height = 21
        ExplicitLeft = 415
        ExplicitWidth = 84
        ExplicitHeight = 21
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 648
      Width = 70
      Height = 21
      Align = alRight
      ExplicitLeft = 648
      ExplicitWidth = 70
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 148
    Width = 720
    ExplicitTop = 148
    ExplicitWidth = 720
    inherited pnlNomeForm: TPanel
      Left = 527
      Width = 193
      ExplicitLeft = 527
      ExplicitWidth = 193
    end
    inherited pnlInfo: TPanel
      Width = 527
      ExplicitWidth = 527
    end
  end
  inherited pgcDados: TPageControl
    Width = 720
    Height = 123
    ExplicitWidth = 720
    ExplicitHeight = 123
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 712
      ExplicitHeight = 91
    end
  end
  object pnlGeral: TPanel [3]
    Left = 0
    Top = 0
    Width = 720
    Height = 123
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 3
    object Label1: TLabel
      Left = 51
      Top = 16
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 35
      Top = 38
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object dbeCodigo: TDBEditFocus
      Tag = 99
      Left = 91
      Top = 9
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'PRD_CODGRU'
      DataSource = dtsTabela
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDesGru: TDBEditFocus
      Tag = 99
      Left = 91
      Top = 32
      Width = 288
      Height = 22
      CharCase = ecUpperCase
      DataField = 'PRD_DESGRU'
      DataSource = dtsTabela
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object pnlFornecedor: TPanel
      Left = 0
      Top = 55
      Width = 628
      Height = 25
      BevelOuter = bvNone
      Caption = 'pnlFornecedor'
      ShowCaption = False
      TabOrder = 2
      object Label7: TLabel
        Left = 29
        Top = 3
        Width = 59
        Height = 14
        Alignment = taRightJustify
        Caption = 'Fornecedor:'
      end
      object dbeCodFor: TDBEditFocus
        Tag = 99
        Left = 91
        Top = 0
        Width = 88
        Height = 22
        CharCase = ecUpperCase
        DataField = 'PRD_CODFOR'
        DataSource = dtsTabela
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
        TabOrder = 0
        OnKeyPress = dbeCodForKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        PanelInfo = pnlInfo
        TipoTexto = ttAlfanumerico
      end
      object edtNomFor: TEditFocus
        Left = 180
        Top = 0
        Width = 381
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
      TabOrder = 3
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
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 472
    Top = 8
  end
  object dtsTabela: TDataSource
    Left = 400
    Top = 65528
  end
end
