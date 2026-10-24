inherited frmReimpressaoCarnePagto: TfrmReimpressaoCarnePagto
  Left = 195
  Top = 179
  Width = 800
  Height = 577
  Caption = 'Relat'#243'rio de Reimpress'#227'o de Carn'#234' de Pagamento'
  Position = poMainFormCenter
  ExplicitWidth = 800
  ExplicitHeight = 577
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 496
    Width = 784
    Height = 26
    ExplicitTop = 496
    ExplicitWidth = 784
    ExplicitHeight = 26
    object lblInformacao: TLabel [0]
      Left = 2
      Top = 2
      Width = 665
      Height = 22
      Align = alClient
      Alignment = taCenter
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      ExplicitWidth = 3
      ExplicitHeight = 14
    end
    inherited FlwBotoes: TFlowPanel
      Width = 665
      Height = 22
      ExplicitTop = 2
      ExplicitWidth = 780
      ExplicitHeight = 25
      inherited btnMudaOrdem: TBitBtnLocked
        Width = 115
        ExplicitWidth = 115
      end
      inherited btnPesquisar: TBitBtnLocked
        Left = 115
        Width = 115
        ExplicitLeft = 115
        ExplicitWidth = 115
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 667
      Top = 2
      Width = 115
      Align = alRight
      ExplicitLeft = 674
      ExplicitTop = 4
      ExplicitWidth = 115
    end
  end
  inherited pnlHeader: TPanel
    Width = 784
    Height = 136
    ExplicitWidth = 784
    ExplicitHeight = 136
    object Label1: TLabel
      Left = 20
      Top = 67
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object Label2: TLabel
      Left = 16
      Top = 113
      Width = 39
      Height = 14
      Alignment = taRightJustify
      Caption = 'Per'#237'odo:'
    end
    object Label3: TLabel
      Left = 134
      Top = 110
      Width = 6
      Height = 14
      Alignment = taRightJustify
      Caption = #224
    end
    object Label20: TLabel
      Left = 10
      Top = 90
      Width = 45
      Height = 14
      Caption = 'Empresa:'
    end
    object Label4: TLabel
      Left = 223
      Top = 113
      Width = 126
      Height = 14
      Alignment = taRightJustify
      Caption = '(Vencimento ou Cadastro)'
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 58
      Top = 59
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 8
      TabOrder = 1
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 58
      Top = 105
      Width = 72
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 3
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 145
      Top = 105
      Width = 71
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 4
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtNomCli: TEditFocus
      Left = 131
      Top = 59
      Width = 502
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtNomEmp: TEditFocus
      Left = 131
      Top = 82
      Width = 502
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 6
      OnKeyPress = edtNomEmpKeyPress
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 58
      Top = 82
      Width = 72
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 3
      TabOrder = 2
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object rdgDuplicatas: TRadioGroup
      Left = 58
      Top = 8
      Width = 378
      Height = 43
      Caption = 'Duplicatas:'
      Columns = 3
      ItemIndex = 2
      Items.Strings = (
        'Todas'
        #192' Vista'
        #192' Prazo')
      TabOrder = 0
    end
  end
  inherited pnlTail: TPanel
    Top = 496
    Width = 784
    Height = 0
    Enabled = False
    Visible = True
    ExplicitTop = 493
    ExplicitWidth = 784
    ExplicitHeight = 0
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 176
    Width = 784
    Height = 320
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    OnEnter = dbgConsultaEnter
    OnExit = dbgConsultaExit
    Columns = <
      item
        Expanded = False
        FieldName = 'CTR_BARCON'
        Title.Caption = 'Contrato'
        Width = 90
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CTR_DUPPAR'
        Title.Alignment = taCenter
        Title.Caption = 'Documento'
        Width = 90
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CTR_ESPDOC'
        Title.Alignment = taCenter
        Title.Caption = 'Esp.'
        Width = 27
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CTR_CODEMP'
        Title.Alignment = taCenter
        Title.Caption = 'Emp.'
        Width = 27
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CLI_NOMCLI'
        Title.Caption = 'Cliente'
        Width = 171
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CTR_DTACAD'
        Title.Alignment = taCenter
        Title.Caption = 'Data Cadastro'
        Width = 72
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CTR_DTAVEN'
        Title.Alignment = taCenter
        Title.Caption = 'Data Venc.'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CTR_VALDUP'
        Title.Caption = 'Val. Duplicata'
        Width = 75
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'CTR_DTAREC'
        Title.Alignment = taCenter
        Title.Caption = 'Data Pagto'
        Width = 72
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CTR_VALREC'
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor Pagto'
        Width = 74
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 136
    Width = 784
    ExplicitTop = 136
    ExplicitWidth = 784
  end
  inherited pnlStatus: TPanel
    Top = 522
    Width = 784
    ExplicitTop = 522
    ExplicitWidth = 784
    inherited pnlNomeForm: TPanel
      Left = 613
      ExplicitLeft = 613
    end
    inherited pnlInfo: TPanel
      Width = 613
      ExplicitWidth = 613
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 280
    Top = 336
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 312
    Top = 336
  end
  inherited qryConsulta: TUniQuery
    Left = 152
    Top = 336
  end
  inherited dspConsulta: TUniDataSetProvider
    Left = 184
    Top = 336
  end
  inherited cdsConsulta: TUniClientDataSet
    DisableStringTrim = True
    Left = 216
    Top = 336
  end
  inherited dtsConsulta: TDataSource
    Left = 248
    Top = 336
  end
end
