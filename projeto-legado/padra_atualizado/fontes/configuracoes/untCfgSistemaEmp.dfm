inherited frmCfgSistemaEmp: TfrmCfgSistemaEmp
  Width = 1024
  Height = 768
  BorderStyle = bsSizeable
  Caption = 'Configura'#231#245'es do sistema (Empresas)'
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  OnResize = FormResize
  ExplicitWidth = 1024
  ExplicitHeight = 768
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 687
    Width = 1008
    ParentColor = True
    ExplicitTop = 687
    ExplicitWidth = 1008
    object lblInformacoes: TLabel [0]
      Left = 353
      Top = 2
      Width = 351
      Height = 22
      Align = alClient
      Alignment = taCenter
      Caption = '...'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      ExplicitWidth = 9
      ExplicitHeight = 14
    end
    inherited FlwBotoes: TFlowPanel
      Width = 351
      Align = alLeft
      ExplicitWidth = 351
      inherited btnConfirma: TBitBtnLocked
        Width = 126
        Caption = '[F10] &Gravar'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000007E4C
          69B7AF6A93FFAF6A93FFAF6A93FFAF6A93FFAF6A93FFAF6A93FFAF6A93FFAF6A
          93FFAF6A93FFAF6A93FFAF6A93FFAF6A93FF7E4C69B70000000000000000AF6A
          93FFAF6A93FFAF6A93FFAF6A93FFAF6A93FFAF6A93FFAF6A93FFAF6A93FFAF6A
          93FFAF6A93FFAF6A93FFAF6A93FFAF6A93FFAF6A93FF0000000000000000AF6A
          93FFAF6A93FF0000000000000000000000000000000000000000000000000000
          0000000000000000000000000000AF6A93FFAF6A93FF0000000000000000AF6A
          93FFAF6A93FF0000000000000000000000000000000000000000000000000000
          0000000000000000000000000000AF6A93FFAF6A93FF0000000000000000AF6A
          93FFAF6A93FF0000000000000000000000000000000000000000000000000000
          0000000000000000000000000000AF6A93FFAF6A93FF0000000000000000AF6A
          93FFAF6A93FF0000000000000000000000000000000000000000000000000000
          0000000000000000000000000000AF6A93FFAF6A93FF0000000000000000AF6A
          93FFAF6A93FF0000000000000000000000000000000000000000000000000000
          0000000000000000000000000000AF6A93FFAF6A93FF0000000000000000AF6A
          93FFAF6A93FFAF6A93FFAF6A93FFAF6A93FFAF6A93FFAF6A93FFAF6A93FFAF6A
          93FFAF6A93FFAF6A93FFAF6A93FFAF6A93FFAF6A93FF0000000000000000AF6A
          93FFAF6A93FFAF6A93FFAF6A93FFAF6A93FFAF6A93FFAF6A93FFAF6A93FFAF6A
          93FFAF6A93FFAF6A93FFAF6A93FFAF6A93FFAF6A93FF0000000000000000AF6A
          93FFAF6A93FFAF6A93FF00000000000000000000000000000000000000000000
          00000000000000000000AF6A93FFAF6A93FFAF6A93FF0000000000000000AF6A
          93FFAF6A93FFAF6A93FF00000000AF6A93FFAF6A93FFAF6A93FFAF6A93FFAF6A
          93FFAF6A93FF00000000AF6A93FFAF6A93FFAF6A93FF0000000000000000AF6A
          93FFAF6A93FFAF6A93FF00000000AF6A93FFAF6A93FFAF6A93FFAF6A93FF0000
          0000AF6A93FF00000000AF6A93FFAF6A93FFAF6A93FF0000000000000000AF6A
          93FFAF6A93FFAF6A93FF00000000AF6A93FFAF6A93FFAF6A93FFAF6A93FF0000
          0000AF6A93FF00000000AF6A93FFAF6A93FFAF6A93FF0000000000000000824F
          6DBDAF6A93FFAF6A93FF00000000AF6A93FFAF6A93FFAF6A93FFAF6A93FFAF6A
          93FFAF6A93FF00000000AF6A93FFAF6A93FF824F6DBD00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        ModalResult = 0
        NumGlyphs = 1
        ExplicitWidth = 126
      end
      object btnMarcaTodas: TBitBtnLocked
        Left = 126
        Top = 0
        Width = 219
        Height = 22
        Caption = '[F6] Copiar para todas as empresas'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000008484
          84FF848484FF848484FF848484FF848484FF848484FF848484FF848484FF8484
          84FF848484FF848484FF00000000000000000000000000000000000000008484
          84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF848484FF00000000000000000000000000000000000000008484
          84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF848484FF00000000000000000000000000000000000000008484
          84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF848484FF848484FF848484FF848484FF00000000000000008484
          84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF848484FFFFFFFFFFFFFFFFFF848484FF00000000000000008484
          84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF848484FFFFFFFFFFFFFFFFFF848484FF00000000000000008484
          84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF848484FFFFFFFFFFFFFFFFFF848484FF00000000000000008484
          84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF848484FFFFFFFFFFFFFFFFFF848484FF00000000000000008484
          84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF848484FFFFFFFFFFFFFFFFFF848484FF00000000000000008484
          84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF8484
          84FF848484FF848484FFFFFFFFFFFFFFFFFF848484FF00000000000000008484
          84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FFFFFF
          FFFF9D9D9DFFE6E6E6FFFFFFFFFFFFFFFFFF848484FF00000000000000008484
          84FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484FF9D9D
          9DFFE6E6E6FFFFFFFFFFFFFFFFFFFFFFFFFF848484FF00000000000000008484
          84FF848484FF848484FF848484FF848484FF848484FF848484FF848484FFE6E6
          E6FFFFFFFFFF848484FF848484FF848484FF848484FF00000000000000000000
          00000000000000000000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF848484FFFAFAFAFA7B7B7BDD1A1A1A3300000000000000000000
          00000000000000000000848484FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFF848484FF7B7B7BDD1A1A1A330000000000000000000000000000
          00000000000000000000848484FF848484FF848484FF848484FF848484FF8484
          84FF838383FE848484FF1A1A1A33000000000000000000000000}
        TabOrder = 1
        OnClick = btnMarcaTodasClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 929
      Top = 2
      Align = alRight
      ExplicitLeft = 929
      ExplicitTop = 2
    end
    object pnlLegenda: TPanel
      Left = 704
      Top = 2
      Width = 225
      Height = 22
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 2
      object shpLegCfgAlt: TShape
        AlignWithMargins = True
        Left = 5
        Top = 5
        Width = 14
        Height = 12
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alLeft
        Brush.Color = clBlue
        ExplicitHeight = 14
      end
      object Label1: TLabel
        Left = 24
        Top = 0
        Width = 201
        Height = 22
        Align = alClient
        Caption = 'Alterado valor da configura'#231#227'o'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        ExplicitWidth = 150
        ExplicitHeight = 14
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 713
    Width = 1008
    ExplicitTop = 713
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
  object cxgCfgEmp: TcxGridCitel [2]
    Left = 0
    Top = 33
    Width = 1008
    Height = 654
    Align = alClient
    TabOrder = 2
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxgCfgEmpTable: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      OnCustomDrawCell = cxgCfgEmpTableCustomDrawCell
      OnEditing = cxgCfgEmpTableEditing
      DataController.DataSource = dtsCfgEmp
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.CellAutoHeight = True
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = False
      CorZebra = clMoneyGreen
      object cxgCfgEmpTableSIS_CODEMP: TcxGridDBColumn
        Caption = 'Emp.'
        DataBinding.FieldName = 'SIS_CODEMP'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Moving = False
        Options.Sorting = False
        SortIndex = 0
        SortOrder = soAscending
        Width = 50
      end
      object cxgCfgEmpTableEMP_SIGLA_: TcxGridDBColumn
        Caption = 'Sigla'
        DataBinding.FieldName = 'EMP_SIGLA_'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Options.Moving = False
        Options.Sorting = False
        Width = 50
      end
      object cxgCfgEmpTableEMP_NOMEMP: TcxGridDBColumn
        Caption = 'Raz'#227'o Social'
        DataBinding.FieldName = 'EMP_NOMEMP'
        MinWidth = 100
        Options.Editing = False
        Options.Moving = False
        Options.Sorting = False
        Width = 270
      end
      object cxgCfgEmpTableEMP_NOMFAN: TcxGridDBColumn
        Caption = 'Nome Fantasia'
        DataBinding.FieldName = 'EMP_NOMFAN'
        Options.Editing = False
        Options.Moving = False
        Options.Sorting = False
        Width = 270
      end
      object cxgCfgEmpTableSIS_VALCFG: TcxGridDBColumn
        Caption = 'Valor'
        DataBinding.FieldName = 'SIS_VALCFG'
        OnGetDataText = cxgCfgEmpTableSIS_VALCFGGetDataText
        OnGetProperties = cxgCfgEmpTableSIS_VALCFGGetProperties
        Options.Moving = False
        Options.Sorting = False
        Width = 328
      end
      object cxgCfgEmpTableSIS_VALANT: TcxGridDBColumn
        DataBinding.FieldName = 'SIS_VALANT'
        Visible = False
      end
    end
    object cxgCfgEmpLevel: TcxGridLevel
      GridView = cxgCfgEmpTable
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 1008
    Height = 33
    Align = alTop
    BevelOuter = bvLowered
    TabOrder = 3
    object edtCodCfg: TEditFocus
      Tag = 99
      AlignWithMargins = True
      Left = 6
      Top = 6
      Width = 99
      Height = 21
      Hint = 'Pressione INSERT para inserir um novo cliente'
      Margins.Left = 5
      Margins.Top = 5
      Margins.Bottom = 5
      TabStop = False
      Align = alLeft
      Alignment = taCenter
      CharCase = ecUpperCase
      Color = 16768952
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      ParentFont = False
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 0
      Text = 'CFG_ACEMPI'
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
      ExplicitHeight = 22
    end
    object edtDesCfg: TEditFocus
      AlignWithMargins = True
      Left = 111
      Top = 6
      Width = 876
      Height = 21
      Margins.Top = 5
      Margins.Right = 20
      Margins.Bottom = 5
      TabStop = False
      Align = alClient
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      ReadOnly = True
      TabOrder = 1
      Text = 
        'VERIFICAR DIREITO DE ACESSO (EMPRESA ACESSO) QUANDO UTILIZAR ALG' +
        'UMA DAS CONFIGURA'#199#213'ES "[CFG_EMPFVN] SOLICITAR EMP. DE FATURAMENT' +
        'O NOS ITENS DA TELA DE VN (MULTI-EMPRESAS)?" "[CFG_EMPFAT] SOLIC' +
        'ITAR EMP. DE FATURAMENTO NOS ITENS DA TELA DE OR/PD?"'
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      ExplicitHeight = 22
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 728
    Top = 280
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 680
    Top = 216
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 608
    Top = 240
  end
  object dtsCfgEmp: TDataSource
    Left = 456
    Top = 208
  end
end
