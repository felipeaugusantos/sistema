inherited frmCadFreteFaixaFaturamento: TfrmCadFreteFaixaFaturamento
  Width = 601
  Height = 430
  Caption = 'Cadastro de frete por faixa de faturamento'
  ExplicitWidth = 601
  ExplicitHeight = 430
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 360
    Width = 595
    Height = 25
    ExplicitTop = 261
    ExplicitWidth = 595
    ExplicitHeight = 25
    inherited FlwBotoes: TFlowPanel
      Width = 521
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 521
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 85
        Height = 21
        Spacing = 2
        ExplicitWidth = 85
        ExplicitHeight = 21
      end
      inherited btnGravar: TBitBtnLocked
        Left = 85
        Width = 85
        Height = 21
        Spacing = 2
        ExplicitLeft = 85
        ExplicitWidth = 85
        ExplicitHeight = 21
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 170
        Width = 85
        Height = 21
        Spacing = 2
        ExplicitLeft = 170
        ExplicitWidth = 85
        ExplicitHeight = 21
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 255
        Width = 85
        Height = 21
        Spacing = 2
        ExplicitLeft = 255
        ExplicitWidth = 85
        ExplicitHeight = 21
      end
      inherited btnCancela: TBitBtnLocked
        Left = 340
        Width = 85
        Height = 21
        Spacing = 2
        ExplicitLeft = 340
        ExplicitWidth = 85
        ExplicitHeight = 21
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 425
        Width = 85
        Height = 21
        Spacing = 2
        ExplicitLeft = 425
        ExplicitWidth = 85
        ExplicitHeight = 21
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 523
      Width = 70
      Height = 21
      Align = alRight
      ExplicitLeft = 523
      ExplicitWidth = 70
      ExplicitHeight = 21
    end
  end
  inherited pnlStatus: TPanel
    Top = 385
    Width = 595
    ExplicitWidth = 595
    inherited pnlNomeForm: TPanel
      Left = 352
      Width = 243
      ExplicitLeft = 352
      ExplicitWidth = 243
    end
    inherited pnlInfo: TPanel
      Width = 352
      ExplicitWidth = 352
    end
  end
  inherited pgcDados: TPageControl
    Top = 145
    Width = 595
    Height = 215
    ActivePage = nil
    ExplicitTop = 60
    ExplicitWidth = 595
    ExplicitHeight = 201
    inherited tbsGeral: TTabSheet
      TabVisible = False
      ExplicitLeft = 4
      ExplicitTop = 6
      ExplicitWidth = 587
      ExplicitHeight = 191
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 595
    Height = 145
    Align = alTop
    ParentColor = True
    TabOrder = 4
    object Label1: TLabel
      Left = 48
      Top = 11
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 32
      Top = 36
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label3: TLabel
      Left = 32
      Top = 55
      Width = 206
      Height = 14
      Caption = 'Tipo de Frete para C'#225'lculo no Faturamento:'
    end
    object dbeCodFrg: TDBEditFocus
      Tag = 99
      Left = 88
      Top = 8
      Width = 88
      Height = 22
      TabStop = False
      CharCase = ecUpperCase
      DataField = 'FRG_CODFRG'
      DataSource = dtsFreFai
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeDesFrg: TDBEditFocus
      Tag = 99
      Left = 88
      Top = 31
      Width = 386
      Height = 22
      CharCase = ecUpperCase
      DataField = 'FRG_DESFRG'
      DataSource = dtsFreFai
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
    object clbTipFre: TcxDBCheckListBox
      Left = 32
      Top = 72
      Width = 442
      Height = 63
      Columns = 2
      DataBinding.DataSource = dtsFreFai
      DataBinding.DataField = 'FRG_TIPFRE'
      Items = <
        item
          Text = 'Emitente (CIF)'
        end
        item
          Text = 'Destinat'#225'rio (FOB)'
        end
        item
          Text = 'Terceiros'
        end
        item
          Text = 'Sem Frete'
        end
        item
          Text = 'Transporte Pr'#243'prio Remetente'
        end
        item
          Text = 'Transporte Pr'#243'prio Destinat'#225'rio'
        end>
      ParentColor = False
      TabOrder = 2
      OnCheckStatesToEditValue = clbTipFreCheckStatesToEditValue
      OnEditValueToCheckStates = clbTipFreEditValueToCheckStates
    end
  end
  object pnlFaixas: TPanel [4]
    Left = 0
    Top = 145
    Width = 595
    Height = 215
    Align = alClient
    Enabled = False
    TabOrder = 3
    ExplicitTop = 60
    ExplicitHeight = 201
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 593
      Height = 25
      Align = alTop
      Caption = 'Faixas de Frete'
      Color = 16770261
      TabOrder = 0
      object dbnFaixas: TDBNavigator
        Left = 0
        Top = 0
        Width = 125
        Height = 24
        DataSource = dtsFaixas
        VisibleButtons = [nbInsert, nbDelete, nbEdit, nbPost, nbCancel]
        Enabled = False
        Flat = True
        Ctl3D = False
        Hints.Strings = (
          'First record'
          'Prior record'
          'Next record'
          'Last record'
          'Insere'
          'Exclui'
          'Altera'
          'Salva'
          'Cancela'
          'Refresh data')
        ParentCtl3D = False
        ParentShowHint = False
        ConfirmDelete = False
        ShowHint = True
        TabOrder = 0
      end
    end
    object dbgFaixas: TDBGridCitel
      Left = 1
      Top = 26
      Width = 593
      Height = 188
      Align = alClient
      DataSource = dtsFaixas
      Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgTabs, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 1
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'FRD_VALINI'
          Title.Alignment = taRightJustify
          Title.Caption = 'Valor Inicial'
          Width = 92
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FRD_VALFIN'
          Title.Alignment = taRightJustify
          Title.Caption = 'Valor Final'
          Width = 92
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'FRD_VALFRE'
          Title.Alignment = taRightJustify
          Title.Caption = 'Valor do Frete'
          Width = 92
          Visible = True
        end>
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 540
    Top = 4
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 455
    Top = 4
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 512
    Top = 4
  end
  object dtsFreFai: TDataSource
    Left = 484
    Top = 4
  end
  object dtsFaixas: TDataSource
    DataSet = cdsFaixas
    Left = 60
    Top = 156
  end
  object cdsFaixas: TUniClientDataSet
    Aggregates = <>
    IndexFieldNames = 'FRD_VALINI'
    Params = <>
    AfterInsert = cdsFaixas_AfterInsert
    AfterEdit = cdsFaixasAfterEdit
    BeforePost = cdsFaixas_BeforePost
    AfterPost = cdsFaixas_AfterPost
    OnNewRecord = cdsFaixasNewRecord
    Left = 96
    Top = 152
    object cdsFaixasFRD_SEQGER: TStringField
      FieldName = 'FRD_SEQGER'
    end
    object cdsFaixasAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsFaixasFRD_VALINI: TFloatField
      FieldName = 'FRD_VALINI'
      DisplayFormat = '#,##0.00'
      EditFormat = '#0.00'
    end
    object cdsFaixasFRD_VALFIN: TFloatField
      FieldName = 'FRD_VALFIN'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsFaixasFRD_VALFRE: TFloatField
      FieldName = 'FRD_VALFRE'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
  end
end
