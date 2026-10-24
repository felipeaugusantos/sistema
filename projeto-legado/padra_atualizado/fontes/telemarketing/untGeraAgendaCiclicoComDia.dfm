inherited frmGeraAgendaCiclicoComDia: TfrmGeraAgendaCiclicoComDia
  Left = 374
  Top = 334
  Width = 387
  Height = 337
  ActiveControl = mskDtaIni
  BorderStyle = bsDialog
  Caption = 'Agendamento c'#237'clico com dia de in'#237'cio do ciclo'
  Position = poScreenCenter
  ExplicitWidth = 387
  ExplicitHeight = 337
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 264
    Width = 381
    ExplicitTop = 264
    ExplicitWidth = 381
    DesignSize = (
      381
      28)
    inherited FlwBotoes: TFlowPanel
      Top = 2
      Width = 377
      Height = 24
      ExplicitLeft = 2
      ExplicitTop = 2
      ExplicitWidth = 377
      ExplicitHeight = 24
      object btnGerar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 99
        Height = 22
        Caption = '[ F10 ] Gerar'
        TabOrder = 0
        OnClick = btnGerarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 301
      Top = 2
      ExplicitLeft = 301
      ExplicitTop = 2
    end
  end
  object pgbAge: TProgressBar [2]
    Left = 0
    Top = 248
    Width = 381
    Height = 16
    Align = alBottom
    Smooth = True
    TabOrder = 2
  end
  object pnlAgeAut: TPanel [3]
    Left = 0
    Top = 159
    Width = 381
    Height = 89
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 3
    object Memo1: TMemo
      Left = 0
      Top = 0
      Width = 381
      Height = 89
      Align = alClient
      Alignment = taCenter
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Lines.Strings = (
        ''
        'Os agendamentos abertos ser'#227'o apagados.'
        'Ser'#227'o gerados novos agendamentos iniciais.'
        'A data de hoje ser'#225' a data do primeiro agendamento '
        'para os clientes que possuem dia de in'#237'cio igual a zero.')
      TabOrder = 0
    end
  end
  object pnlPeriodo: TPanel [4]
    Left = 0
    Top = 0
    Width = 381
    Height = 159
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 4
    object Label12: TLabel
      Left = 6
      Top = 71
      Width = 32
      Height = 14
      Caption = 'Cliente'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 6
      Top = 111
      Width = 45
      Height = 14
      Caption = 'Atividade'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object grbPerido: TGroupBox
      Left = 6
      Top = 8
      Width = 211
      Height = 56
      Caption = 'Per'#237'odo para gera'#231#227'o do agendamento'
      TabOrder = 0
      object Label6: TLabel
        Left = 95
        Top = 32
        Width = 6
        Height = 14
        Caption = #224
      end
      object mskDtaIni: TMaskEditFocus
        Tag = 99
        Left = 9
        Top = 24
        Width = 76
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
        Left = 110
        Top = 24
        Width = 78
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
    end
    object edtCodCliente: TEditFocus
      Left = 6
      Top = 87
      Width = 69
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 8
      ParentFont = False
      TabOrder = 1
      OnExit = edtCodClienteExit
      OnKeyPress = edtCodClienteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtDesCliente: TEditFocus
      Left = 77
      Top = 87
      Width = 295
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 2
      Text = 'TODOS'
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodAti: TEditFocus
      Tag = 99
      Left = 6
      Top = 127
      Width = 69
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
      TabOrder = 3
      OnKeyPress = edtCodAtiKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesAti: TEditFocus
      Left = 76
      Top = 127
      Width = 295
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 4
      Text = 'TODOS'
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 292
    Width = 381
    ExplicitTop = 292
    ExplicitWidth = 381
    inherited pnlNomeForm: TPanel
      Left = 210
      ExplicitLeft = 210
    end
    inherited pnlInfo: TPanel
      Width = 210
      ExplicitWidth = 210
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 288
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    OnException = ApplicationEventsException
    Left = 320
    Top = 8
  end
end
