inherited frmCadFaixasCatEtiqProduto: TfrmCadFaixasCatEtiqProduto
  Height = 126
  Caption = 
    'Cadastro de Faixas de Categorias para Impress'#227'o de Etiquetas de ' +
    'Produtos'
  ExplicitHeight = 126
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 53
    ExplicitTop = 53
    inherited FlwBotoes: TFlowPanel
      inherited btnIncluir: TBitBtnLocked
        Width = 73
        ExplicitWidth = 73
      end
      inherited btnGravar: TBitBtnLocked
        Left = 73
        Width = 73
        ExplicitLeft = 73
        ExplicitWidth = 73
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 146
        Width = 73
        ExplicitLeft = 146
        ExplicitWidth = 73
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 219
        Width = 73
        ExplicitLeft = 219
        ExplicitWidth = 73
      end
      inherited btnCancela: TBitBtnLocked
        Left = 292
        Width = 73
        ExplicitLeft = 292
        ExplicitWidth = 73
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 365
        Width = 73
        ExplicitLeft = 365
        ExplicitWidth = 73
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 503
      Width = 73
      Height = 20
      ExplicitLeft = 503
      ExplicitWidth = 73
      ExplicitHeight = 20
    end
  end
  inherited pgcDados: TPageControl
    Height = 53
    ExplicitHeight = 53
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 577
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 81
    ExplicitTop = 81
  end
  object pnlDados: TPanel [4]
    Left = 0
    Top = 0
    Width = 585
    Height = 53
    Align = alClient
    ParentColor = True
    TabOrder = 4
    object pnlFaixas: TPanel
      Left = 1
      Top = 1
      Width = 583
      Height = 51
      Align = alClient
      BevelOuter = bvLowered
      ParentColor = True
      TabOrder = 0
      object Label12: TLabel
        Left = 25
        Top = 17
        Width = 49
        Height = 14
        Alignment = taRightJustify
        Caption = 'Categoria:'
      end
      object Label1: TLabel
        Left = 185
        Top = 17
        Width = 86
        Height = 14
        Alignment = taRightJustify
        Caption = '% Inicial da Faixa:'
      end
      object Label2: TLabel
        Left = 374
        Top = 17
        Width = 82
        Height = 14
        Alignment = taRightJustify
        Caption = '% Final da Faixa:'
      end
      object dbeInicioFaixa: TDBEditFocus
        Tag = 99
        Left = 277
        Top = 13
        Width = 87
        Height = 22
        DataField = 'CAT_INICIO'
        DataSource = dtsTabela
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeFinalFaixa: TDBEditFocus
        Tag = 99
        Left = 462
        Top = 13
        Width = 87
        Height = 22
        DataField = 'CAT_FINAL'
        DataSource = dtsTabela
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object dbeCategoria: TDBEditFocus
        Left = 80
        Top = 13
        Width = 99
        Height = 22
        CharCase = ecUpperCase
        DataField = 'CAT_DESCRI'
        DataSource = dtsTabela
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 228
    Top = 116
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 228
    Top = 144
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 200
    Top = 116
  end
  object dtsTabela: TDataSource
    Left = 301
    Top = 101
  end
end
