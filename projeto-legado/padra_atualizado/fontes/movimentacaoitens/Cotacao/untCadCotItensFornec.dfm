inherited frmCadCotItensFornec: TfrmCadCotItensFornec
  Left = 155
  Top = 252
  Width = 891
  Height = 361
  Align = alClient
  Caption = 'frmCadCotItensFornec'
  OnClose = FormClose
  ExplicitWidth = 891
  ExplicitHeight = 361
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 273
    Width = 875
    Height = 34
    BevelInner = bvNone
    BevelOuter = bvNone
    ParentColor = True
    ExplicitTop = 273
    ExplicitWidth = 875
    ExplicitHeight = 34
    object Label1: TLabel [0]
      Left = 478
      Top = 14
      Width = 99
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total do Fornecedor:'
    end
    inherited btnSair: TBitBtnLocked
      Left = 458
      Top = 6
      Visible = False
      ExplicitLeft = 458
      ExplicitTop = 6
    end
    inherited btnPesquisar: TBitBtnLocked
      Left = 138
      Top = 6
      ExplicitLeft = 138
      ExplicitTop = 6
    end
    inherited btnMudaOrdem: TBitBtnLocked
      Left = 18
      Top = 6
      ExplicitLeft = 18
      ExplicitTop = 6
    end
    object dbeTotFor: TDBEditFocus
      Left = 582
      Top = 6
      Width = 120
      Height = 22
      Color = 16768952
      DataField = 'TOTFOR'
      DataSource = dtsConsulta
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlHeader: TPanel
    Width = 875
    Height = 60
    ExplicitWidth = 875
    ExplicitHeight = 60
    object Fornecedor: TLabel
      Left = 8
      Top = 16
      Width = 65
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Fornecedor:'
    end
    object Label2: TLabel
      Left = 8
      Top = 39
      Width = 65
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Data Entrega:'
    end
    object Label3: TLabel
      Left = 160
      Top = 39
      Width = 137
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Condi'#231#227'o de Pagamento:'
    end
    object dbLookCodFor: TDBLookupComboBoxFocus
      Tag = 99
      Left = 75
      Top = 8
      Width = 497
      Height = 22
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      KeyField = 'CODFOR'
      ListField = 'NOMFOR'
      TabOrder = 0
      OnClick = dbLookCodForClick
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object dbeDtaEnt: TDBEditFocus
      Tag = 99
      Left = 75
      Top = 31
      Width = 78
      Height = 22
      DataField = 'DTAENT'
      DataSource = dtsCotCfo
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeConPag: TDBEditFocus
      Tag = 99
      Left = 299
      Top = 31
      Width = 273
      Height = 22
      DataField = 'CONPAG'
      DataSource = dtsCotCfo
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlTail: TPanel
    Top = 255
    Width = 875
    Height = 18
    ExplicitTop = 255
    ExplicitWidth = 875
    ExplicitHeight = 18
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 100
    Width = 875
    Height = 155
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    OnKeyDown = dbgConsultaKeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'CODITE'
        ReadOnly = True
        Title.Caption = 'C'#243'd.Item'
        Width = 57
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODFAB'
        ReadOnly = True
        Title.Caption = 'C'#243'digo F'#225'brica'
        Width = 135
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESITE'
        ReadOnly = True
        Title.Caption = 'Descri'#231#227'o'
        Width = 254
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'REFERE'
        ReadOnly = True
        Title.Caption = 'Refer'#234'ncia'
        Width = 105
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'QTDITE'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'Quantidade'
        Width = 94
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'VALUNI'
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor unit'#225'rio'
        Width = 94
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'IPIENT'
        Title.Alignment = taRightJustify
        Title.Caption = '% IPI'
        Width = 50
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'SUBSTI'
        Title.Alignment = taRightJustify
        Title.Caption = '% Substi.'
        Width = 55
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'VALTOT'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor Total'
        Width = 96
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'DTAULT'
        ReadOnly = True
        Title.Alignment = taCenter
        Title.Caption = 'Data.'#218'lt.Com.'
        Width = 69
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FORULT'
        ReadOnly = True
        Title.Caption = 'Fornec.'#218'lt.Com.'
        Width = 149
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'PREULT'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'Unit.'#218'lt.Com.'
        Width = 73
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 60
    Width = 875
    ExplicitTop = 60
    ExplicitWidth = 875
  end
  inherited pnlStatus: TPanel
    Top = 307
    Width = 875
    Visible = False
    ExplicitTop = 307
    ExplicitWidth = 875
    inherited pnlNomeForm: TPanel
      Left = 704
      ExplicitLeft = 704
    end
    inherited pnlInfo: TPanel
      Width = 704
      ExplicitWidth = 704
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 592
  end
  inherited qryConsulta: TUniQuery
    Left = 368
    Top = 184
  end
  inherited dspConsulta: TUniDataSetProvider
    Left = 400
    Top = 184
  end
  inherited cdsConsulta: TUniClientDataSet
    AggregatesActive = True
    BeforePost = cdsConsultaBeforePost
    Left = 432
    Top = 184
    object cdsConsultaTOTFOR: TAggregateField
      Alignment = taRightJustify
      FieldName = 'TOTFOR'
      Active = True
      DisplayName = ''
      DisplayFormat = '#,##0.00'
      Expression = 'SUM(VALTOT)'
    end
  end
  inherited dtsConsulta: TDataSource
    Left = 464
    Top = 184
  end
  object dtsCotCfo: TDataSource
    Left = 632
    Top = 16
  end
end
