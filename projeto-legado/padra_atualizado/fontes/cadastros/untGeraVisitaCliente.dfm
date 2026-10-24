inherited frmGeraVisitaCliente: TfrmGeraVisitaCliente
  Left = 374
  Top = 334
  Width = 387
  Height = 273
  BorderStyle = bsDialog
  Caption = 'Gera'#231#227'o de Visitas em Clientes - SFA'
  Position = poScreenCenter
  ExplicitWidth = 387
  ExplicitHeight = 273
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 201
    Width = 381
    ExplicitTop = 201
    ExplicitWidth = 381
    DesignSize = (
      381
      28)
    inherited btnSair: TBitBtnLocked
      Left = 298
      TabOrder = 1
      ExplicitLeft = 298
    end
    object btnGerar: TBitBtnLocked
      Left = 4
      Top = 3
      Width = 99
      Height = 22
      Caption = '[ F10 ] Gerar'
      TabOrder = 0
      OnClick = btnGerarClick
    end
  end
  object pnlPeriodo: TPanel [2]
    Left = 0
    Top = 0
    Width = 381
    Height = 201
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
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
      Width = 33
      Height = 14
      Caption = 'Cidade'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 6
      Top = 152
      Width = 71
      Height = 14
      Caption = 'Representante'
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
      Caption = 'Per'#237'odo para gera'#231#227'o das visitas'
      TabOrder = 0
      object Label6: TLabel
        Left = 95
        Top = 32
        Width = 6
        Height = 14
        Caption = 'a'
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
      Top = 86
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
      Left = 76
      Top = 86
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
    object edtCodCid: TEditFocus
      Tag = 99
      Left = 6
      Top = 126
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
      MaxLength = 5
      ParentFont = False
      TabOrder = 3
      OnExit = edtCodCidExit
      OnKeyPress = edtCodCidKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesCid: TEditFocus
      Left = 76
      Top = 126
      Width = 295
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 4
      Text = 'TODAS'
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodRep: TEditFocus
      Tag = 99
      Left = 6
      Top = 167
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
      TabOrder = 5
      OnExit = edtCodRepExit
      OnKeyPress = edtCodRepKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtDesRep: TEditFocus
      Left = 76
      Top = 167
      Width = 295
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 6
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
    Top = 229
    Width = 381
    TabOrder = 2
    ExplicitTop = 229
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
    Left = 320
    Top = 8
  end
end
