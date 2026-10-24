inherited frmCadMetasCentroCusto: TfrmCadMetasCentroCusto
  Width = 667
  Height = 600
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsSizeable
  Caption = 'Metas de Pedido de Compras  por Despesas'
  ExplicitTop = -148
  ExplicitWidth = 667
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 520
    Width = 651
    Height = 25
    TabOrder = 1
    ExplicitTop = 520
    ExplicitWidth = 651
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 647
      Height = 21
      ExplicitWidth = 647
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 82
        ExplicitWidth = 82
      end
      inherited btnGravar: TBitBtnLocked
        Left = 82
        Width = 82
        ExplicitLeft = 82
        ExplicitWidth = 82
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 164
        Width = 82
        ExplicitLeft = 164
        ExplicitWidth = 82
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 246
        Width = 82
        ExplicitLeft = 246
        ExplicitWidth = 82
      end
      inherited btnCancela: TBitBtnLocked
        Left = 328
        Width = 82
        ExplicitLeft = 328
        ExplicitWidth = 82
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 410
        Width = 82
        ExplicitLeft = 410
        ExplicitWidth = 82
      end
      object btnHeranca: TBitBtnLocked
        Left = 492
        Top = 0
        Width = 82
        Height = 20
        Caption = '&Heran'#231'a'
        Enabled = False
        TabOrder = 6
        OnClick = btnHerancaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 576
      Width = 73
      Height = 20
      ExplicitLeft = 576
      ExplicitWidth = 73
      ExplicitHeight = 20
    end
  end
  inherited pnlStatus: TPanel
    Top = 545
    Width = 651
    TabOrder = 2
    ExplicitTop = 545
    ExplicitWidth = 651
    inherited pnlNomeForm: TPanel
      Left = 464
      Width = 187
      ExplicitLeft = 464
      ExplicitWidth = 187
    end
    inherited pnlInfo: TPanel
      Width = 464
      ExplicitWidth = 464
    end
  end
  inherited pgcDados: TPageControl
    Width = 651
    Height = 520
    Enabled = False
    TabOrder = 3
    ExplicitWidth = 651
    ExplicitHeight = 520
    inherited tbsGeral: TTabSheet
      ExplicitWidth = 643
      ExplicitHeight = 488
    end
  end
  object pnlDados: TPanel [3]
    Left = 0
    Top = 0
    Width = 651
    Height = 520
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object pnlEmpres: TPanel
      Left = 0
      Top = 0
      Width = 651
      Height = 65
      Align = alTop
      BevelOuter = bvLowered
      ParentColor = True
      TabOrder = 0
      DesignSize = (
        651
        65)
      object lblEmpres: TLabel
        Left = 15
        Top = 14
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Empresa:'
      end
      object Label2: TLabel
        Left = 6
        Top = 39
        Width = 54
        Height = 14
        Alignment = taRightJustify
        Anchors = [akLeft, akBottom]
        Caption = 'Data Inicial:'
      end
      object Label3: TLabel
        Left = 156
        Top = 39
        Width = 50
        Height = 14
        Alignment = taRightJustify
        Anchors = [akLeft, akBottom]
        Caption = 'Data Final:'
      end
      object dbeCodEmp: TDBEditFocus
        Tag = 99
        Left = 65
        Top = 9
        Width = 74
        Height = 22
        CharCase = ecUpperCase
        DataField = 'MCP_CODEMP'
        DataSource = dtsTabela
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnKeyPress = dbeCodEmpKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TipoTexto = ttNumerico
      end
      object dbeDtaIni: TDBEditFocus
        Tag = 99
        Left = 65
        Top = 35
        Width = 74
        Height = 22
        Anchors = [akLeft, akBottom]
        CharCase = ecUpperCase
        DataField = 'MCP_DTAINI'
        DataSource = dtsTabela
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
      object dbeDtaFin: TDBEditFocus
        Tag = 99
        Left = 208
        Top = 35
        Width = 74
        Height = 22
        Anchors = [akLeft, akBottom]
        CharCase = ecUpperCase
        DataField = 'MCP_DTAFIN'
        DataSource = dtsTabela
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TipoTexto = ttAlfanumerico
      end
      object edtNomEmp: TEditFocus
        Left = 139
        Top = 9
        Width = 415
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
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
    object pnlConta: TPanel
      Left = 0
      Top = 65
      Width = 651
      Height = 107
      Align = alTop
      BevelOuter = bvLowered
      Enabled = False
      ParentColor = True
      TabOrder = 1
      object Label12: TLabel
        Left = 52
        Top = 88
        Width = 69
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor da Meta:'
      end
      object Label1: TLabel
        Left = 5
        Top = 17
        Width = 115
        Height = 14
        Alignment = taRightJustify
        Caption = 'Operador Respons'#225'vel:'
      end
      object Label5: TLabel
        Left = 38
        Top = 64
        Width = 81
        Height = 14
        Alignment = taRightJustify
        Caption = 'Centro de Custo:'
      end
      object edtValMet: TEditFocus
        Tag = 99
        Left = 124
        Top = 82
        Width = 77
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
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttNumerico
        EditFormat = '#0.00'
      end
      object edtCodOpe: TEditFocus
        Tag = 99
        Left = 124
        Top = 10
        Width = 77
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
        MaxLength = 3
        ParentFont = False
        TabOrder = 0
        OnKeyPress = edtCodOpeKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
      object edtNomOpe: TEditFocus
        Left = 204
        Top = 10
        Width = 390
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
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
      inline fraPlanoDeContas: TfraPlanoDeContasMskEdit
        Left = 37
        Top = 34
        Width = 561
        Height = 22
        TabOrder = 1
        ExplicitLeft = 37
        ExplicitTop = 34
        ExplicitWidth = 561
        inherited lblPlaContas: TLabel
          Left = 2
          Width = 81
          Height = 14
          ExplicitLeft = 2
          ExplicitWidth = 81
          ExplicitHeight = 14
        end
        inherited edtDesCta: TEditFocus
          Left = 167
          Width = 390
          Height = 22
          ExplicitLeft = 167
          ExplicitWidth = 390
          ExplicitHeight = 22
        end
        inherited MskCodCta: TMaskEdit
          Left = 87
          Width = 77
          Height = 22
          OnKeyPress = fraPlanoDeContasMskCodCtaKeyPress
          ExplicitLeft = 87
          ExplicitWidth = 77
          ExplicitHeight = 22
        end
      end
      object edtCodEve: TEditFocus
        Tag = 99
        Left = 124
        Top = 58
        Width = 77
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
        MaxLength = 5
        ParentFont = False
        TabOrder = 2
        OnKeyPress = edtCodEveKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttAlfanumerico
      end
      object edtDesEve: TEditFocus
        Left = 204
        Top = 58
        Width = 390
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ParentFont = False
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
    end
    object cxgCustos: TcxGrid
      Left = 0
      Top = 172
      Width = 651
      Height = 307
      Align = alClient
      TabOrder = 2
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxgCustosView: TcxGridDBTableView
        OnKeyDown = cxgCustosViewKeyDown
        Navigator.Buttons.CustomButtons = <>
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.Deleting = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = ' '
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        Styles.ContentOdd = cxStyle1
        object cxgCustosCODCTA: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'MCP_CODCTA'
          SortIndex = 0
          SortOrder = soAscending
          Width = 88
        end
        object cxgCustosDESCTA: TcxGridDBColumn
          Caption = 'Descri'#231#227'o do Plano de Contas'
          DataBinding.FieldName = 'MCP_DESCTA'
          Width = 359
        end
        object cxgCustosCODOPE: TcxGridDBColumn
          Caption = 'Operador'
          DataBinding.FieldName = 'MCP_CODOPE'
          Width = 60
        end
        object cxgCustosVALMET: TcxGridDBColumn
          Caption = 'Valor'
          DataBinding.FieldName = 'MCP_VALMET'
          PropertiesClassName = 'TcxCurrencyEditProperties'
          Properties.DisplayFormat = '0.00;-0.00'
          HeaderAlignmentHorz = taRightJustify
          Width = 142
        end
      end
      object cxgCustosLevel1: TcxGridLevel
        GridView = cxgCustosView
      end
    end
    object Panel3: TPanel
      Left = 0
      Top = 479
      Width = 651
      Height = 41
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 3
      object btnExcCta: TBitBtnLocked
        Left = 5
        Top = 10
        Width = 172
        Height = 22
        Caption = '[DEL] Exclui Plano de Contas'
        Enabled = False
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E0000
          6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001DE80010DC00006EFF00FFFF
          00FFFF00FFFF00FF00006E0004E20008E700006EFF00FFFF00FFFF00FFFF00FF
          00006E001AE2001FEB0010D900006EFF00FFFF00FF00006E0005DF0009EB0003
          DB00006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001ADF0020EB0013DC00
          006E00006E0005E2000BEB0004DA00006EFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FF00006E001BDF0022EB0012E60008EA0009EB0004DF00006EFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E001BE300
          16EB0011EB000ADF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF00006E0021E7001EEB001AEB0017DF00006EFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E062DE30430EB00
          20E2001EE20027EB0019DF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF00006E0C35E40E3CEB052BDC00006E00006E001FDC002AEB001CDF0000
          6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E1442E41645EB092ED900006EFF
          00FFFF00FF00006E0020D9012CEB001FE200006EFF00FFFF00FFFF00FFFF00FF
          00006E1C4BE71037DB00006EFF00FFFF00FFFF00FFFF00FF00006E0022DC0027
          E400006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 0
        OnClick = btnExcCtaClick
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 168
    Top = 368
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 48
    Top = 216
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 56
    Top = 360
  end
  object dtsTabela: TDataSource
    Left = 529
    Top = 8
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 472
    Top = 184
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
  end
end
