inherited frmFatBaixaEmprestimos: TfrmFatBaixaEmprestimos
  Left = 111
  Top = 174
  Width = 1024
  Height = 565
  Caption = 'Baixa de Empr'#233'stimos'
  ExplicitWidth = 1024
  ExplicitHeight = 565
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 482
    Width = 1008
    ExplicitTop = 482
    ExplicitWidth = 1008
    inherited FlwBotoes: TFlowPanel
      Width = 1004
      ExplicitWidth = 1004
      inherited btnPesquisar: TBitBtnLocked
        Width = 110
        ExplicitWidth = 110
      end
      object btnBaiEmp: TBitBtnLocked
        Left = 228
        Top = 0
        Width = 140
        Height = 22
        Caption = '[ F10 ] Baixar Empr'#233'stimos'
        NumGlyphs = 2
        TabOrder = 2
        OnClick = btnBaiEmpClick
      end
      object btnGerCTP: TBitBtnLocked
        Left = 368
        Top = 0
        Width = 150
        Height = 22
        Caption = '[ F8 ] Gerar Contas a Pagar'
        NumGlyphs = 2
        TabOrder = 3
        OnClick = btnGerCTPClick
      end
      object btnGerPed: TBitBtnLocked
        Left = 518
        Top = 0
        Width = 189
        Height = 22
        Caption = '[ F8 ] Gerar Faturamento Futuro (FF)'
        NumGlyphs = 2
        TabOrder = 4
        Visible = False
        OnClick = btnGerPedClick
      end
      object btnMarDes: TBitBtnLocked
        Left = 707
        Top = 0
        Width = 145
        Height = 22
        Caption = '[ Espa'#231'o ] Marca/Desmarca'
        NumGlyphs = 2
        TabOrder = 5
        OnClick = btnMarDesClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 927
      ExplicitLeft = 927
    end
  end
  inherited pnlHeader: TPanel
    Width = 1008
    Height = 81
    ExplicitWidth = 1008
    ExplicitHeight = 81
    object Label1: TLabel
      Left = 15
      Top = 55
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object Label2: TLabel
      Left = 232
      Top = 32
      Width = 39
      Height = 14
      Alignment = taRightJustify
      Caption = 'Per'#237'odo:'
    end
    object Label3: TLabel
      Left = 352
      Top = 33
      Width = 7
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = #224
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 52
      Top = 51
      Width = 68
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 3
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomCli: TEditFocus
      Left = 120
      Top = 51
      Width = 317
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 273
      Top = 28
      Width = 68
      Height = 22
      EditMask = '99/99/9999'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 368
      Top = 28
      Width = 69
      Height = 22
      EditMask = '99/99/9999'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 2
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object rdgTipEmp: TRadioGroup
      Tag = 99
      Left = 52
      Top = 5
      Width = 165
      Height = 43
      Caption = 'Tipo de Empr'#233'stimo'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Entrada'
        'Sa'#237'da')
      TabOrder = 0
      OnClick = rdgTipEmpClick
      OnEnter = rdgTipEmpEnter
    end
  end
  inherited pnlTail: TPanel
    Top = 434
    Width = 1008
    ExplicitTop = 434
    ExplicitWidth = 1008
    object lblInformacao: TLabel
      Left = 0
      Top = 0
      Width = 1008
      Height = 31
      Align = alClient
      Alignment = taCenter
      Caption = 'Informa'#231#227'o'
      Color = clGray
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Arial Black'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
      Layout = tlCenter
      ExplicitWidth = 102
      ExplicitHeight = 23
    end
    object pbProgresso: TProgressBar
      Left = 0
      Top = 31
      Width = 1008
      Height = 17
      Align = alBottom
      Position = 100
      Smooth = True
      TabOrder = 0
    end
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 121
    Width = 1008
    Height = 313
    TabStop = False
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    Columns = <
      item
        Expanded = False
        FieldName = 'DTAENT'
        ReadOnly = True
        Title.Caption = 'Emiss'#227'o'
        Width = 59
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NUMDOC'
        ReadOnly = True
        Title.Caption = 'Empr'#233'stimo'
        Width = 81
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ESPDOC'
        ReadOnly = True
        Title.Caption = 'Esp.'
        Width = 26
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODITE'
        ReadOnly = True
        Title.Caption = 'C'#243'd.Item'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESITE'
        ReadOnly = True
        Title.Caption = 'Descri'#231#227'o do Item'
        Width = 215
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'REFERE'
        ReadOnly = True
        Title.Caption = 'Refer'#234'ncia'
        Width = 101
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SIGUNI'
        ReadOnly = True
        Title.Caption = 'Unid.'
        Width = 29
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'SALDIS'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'Saldo Dispon'#237'vel'
        Width = 89
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'QTDITE'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'Qtd. Pendente'
        Width = 80
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'UNITAR'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor Unit'#225'rio'
        Width = 80
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'TOTITE'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor Total'
        Width = 80
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'QTDBAI'
        Title.Alignment = taRightJustify
        Title.Caption = 'Qtd. a Baixar'
        Width = 80
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 81
    Width = 1008
    ExplicitTop = 81
    ExplicitWidth = 1008
  end
  inherited pnlStatus: TPanel
    Top = 510
    Width = 1008
    ExplicitTop = 510
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
  inherited mnuAuxiliar: TPopupMenu
    Left = 608
    Top = 16
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 664
  end
  inherited qryConsulta: TUniQuery
    Left = 464
    Top = 16
  end
  inherited dspConsulta: TUniDataSetProvider
    Left = 496
    Top = 16
  end
  inherited cdsConsulta: TUniClientDataSet
    AggregatesActive = True
    BeforePost = cdsConsultaBeforePost
    AfterPost = cdsConsultaAfterPost
    Left = 528
    Top = 16
    object cdsConsultaTOTDOC: TAggregateField
      FieldName = 'TOTDOC'
      Active = True
      DisplayName = ''
      Expression = 'SUM(QTDBAI*UNITAR)'
    end
  end
  inherited dtsConsulta: TDataSource
    Left = 560
    Top = 16
  end
end
