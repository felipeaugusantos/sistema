inherited frmInspecaoLocEquEntrada: TfrmInspecaoLocEquEntrada
  Width = 458
  Height = 393
  Caption = 'Informa'#231#245'es da inspe'#231#227'o de entrada'
  ExplicitWidth = 458
  ExplicitHeight = 393
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 322
    Width = 452
    TabOrder = 3
    ExplicitTop = 322
    ExplicitWidth = 452
    inherited FlwBotoes: TFlowPanel
      Width = 448
      ExplicitWidth = 448
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 372
      ExplicitLeft = 372
    end
  end
  inherited pnlStatus: TPanel
    Top = 348
    Width = 452
    TabOrder = 4
    ExplicitTop = 348
    ExplicitWidth = 452
    inherited pnlNomeForm: TPanel
      Left = 281
      ExplicitLeft = 281
    end
    inherited pnlInfo: TPanel
      Width = 281
      ExplicitWidth = 281
      object btnShowTrace: TSpeedButton
        Left = 279
        Top = 0
        Width = 23
        Height = 22
      end
      object btnHideTrace: TSpeedButton
        Left = 279
        Top = 0
        Width = 23
        Height = 22
      end
    end
  end
  object pnlBotoesSQLTrace: TPanel [2]
    Left = 0
    Top = 184
    Width = 452
    Height = 41
    TabOrder = 5
    object lblNSQLTrace: TLabel
      Left = 389
      Top = 0
      Width = 3
      Height = 14
    end
  end
  object pnlCobranca: TPanel [3]
    Left = 0
    Top = 184
    Width = 452
    Height = 63
    Align = alBottom
    TabOrder = 1
    object Label6: TLabel
      Left = 8
      Top = 13
      Width = 193
      Height = 14
      Caption = 'Gerar valor de cobran'#231'a para o cliente?'
    end
    object ColorLabel2: TColorLabel
      Left = 241
      Top = 13
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      CorDestaque = clRed
    end
    object Label7: TLabel
      Left = 8
      Top = 37
      Width = 89
      Height = 14
      Caption = 'Valor da cobran'#231'a'
    end
    object edtGerarValor: TEditFocus
      Tag = 99
      Left = 213
      Top = 7
      Width = 22
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 1
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 1
      TipoTexto = ttAlfanumerico
    end
    object edtValorCobranca: TCurrencyEditFocus
      Tag = 99
      Left = 114
      Top = 31
      Properties.DisplayFormat = '0.00;-0.00'
      StyleFocused.Color = clInfoBk
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      Width = 121
    end
  end
  object pnlInspecao: TPanel [4]
    Left = 0
    Top = 33
    Width = 452
    Height = 151
    Align = alClient
    TabOrder = 0
    DesignSize = (
      452
      151)
    object lblEquipamentoHigienizado: TLabel
      Left = 8
      Top = 8
      Width = 124
      Height = 14
      Caption = 'Equipamento higienizado?'
    end
    object ColorLabel28: TColorLabel
      Left = 183
      Top = 8
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      CorDestaque = clRed
    end
    object lblObervacoes: TLabel
      Left = 8
      Top = 52
      Width = 224
      Height = 14
      Caption = 'Observa'#231#245'es sobre o estado do equipamento:'
    end
    object lblAvarias: TLabel
      Left = 8
      Top = 32
      Width = 141
      Height = 14
      Caption = 'Equipamento sofreu avarias?'
    end
    object ColorLabel1: TColorLabel
      Left = 183
      Top = 32
      Width = 55
      Height = 14
      Caption = '(S)im (N)'#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      CorDestaque = clRed
    end
    object edtHigienizado: TEditFocus
      Tag = 99
      Left = 155
      Top = 2
      Width = 22
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 1
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 1
      TipoTexto = ttAlfanumerico
    end
    object memObservacoes: TMemoFocus
      Tag = 99
      Left = 8
      Top = 71
      Width = 433
      Height = 75
      Anchors = [akLeft, akTop, akBottom]
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
    object edtAvarias: TEditFocus
      Tag = 99
      Left = 155
      Top = 26
      Width = 22
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 1
      TabOrder = 1
      OnEnter = edtAvariasEnter
      OnExit = edtAvariasExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 1
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlConferente: TPanel [5]
    Left = 0
    Top = 247
    Width = 452
    Height = 75
    Align = alBottom
    TabOrder = 2
    object Label3: TLabel
      Left = 8
      Top = 14
      Width = 57
      Height = 14
      Caption = 'Conferente:'
    end
    object Label4: TLabel
      Left = 8
      Top = 36
      Width = 56
      Height = 14
      Caption = 'Supervisor:'
    end
    object lblInformacao: TLabel
      Left = 1
      Top = 60
      Width = 3
      Height = 14
      Align = alBottom
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtCodConferente: TEditFocus
      Tag = 99
      Left = 70
      Top = 8
      Width = 56
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 0
      OnKeyPress = edtCodConferenteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodSupervisor: TEditFocus
      Tag = 99
      Left = 70
      Top = 32
      Width = 56
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      PasswordChar = '*'
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomConferente: TEditFocus
      Left = 127
      Top = 8
      Width = 314
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomSupervisor: TEditFocus
      Left = 127
      Top = 32
      Width = 314
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
  object pnlDataInspecao: TPanel [6]
    Left = 0
    Top = 0
    Width = 452
    Height = 33
    Align = alTop
    TabOrder = 6
    object lblTermino: TLabel
      Left = 8
      Top = 11
      Width = 72
      Height = 14
      Caption = 'Data Inspe'#231#227'o:'
    end
    object mskDtaIpe: TMaskEditFocus
      Tag = 99
      Left = 84
      Top = 7
      Width = 81
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 0
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtHorIpe: TMaskEditFocus
      Tag = 99
      Left = 167
      Top = 7
      Width = 35
      Height = 22
      EditMask = '99:99;1;_'
      MaxLength = 5
      TabOrder = 1
      Text = '  :  '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 360
    Top = 144
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 360
    Top = 80
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 360
    Top = 24
  end
end
