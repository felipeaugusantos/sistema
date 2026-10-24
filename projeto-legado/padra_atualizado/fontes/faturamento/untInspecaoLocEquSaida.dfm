inherited frmInspecaoLocEquSaida: TfrmInspecaoLocEquSaida
  Width = 457
  Height = 314
  Caption = 'Informa'#231#245'es da inspe'#231#227'o de sa'#237'da'
  ExplicitWidth = 457
  ExplicitHeight = 314
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 243
    Width = 451
    TabOrder = 2
    ExplicitTop = 243
    ExplicitWidth = 451
    inherited FlwBotoes: TFlowPanel
      Width = 447
      ExplicitWidth = 447
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 371
      ExplicitLeft = 371
    end
  end
  inherited pnlStatus: TPanel
    Top = 269
    Width = 451
    TabOrder = 3
    ExplicitTop = 269
    ExplicitWidth = 451
    inherited pnlNomeForm: TPanel
      Left = 280
      ExplicitLeft = 280
    end
    inherited pnlInfo: TPanel
      Width = 280
      ExplicitWidth = 280
      object btnShowTrace: TSpeedButton
        Left = 278
        Top = 0
        Width = 23
        Height = 22
      end
      object btnHideTrace: TSpeedButton
        Left = 278
        Top = 0
        Width = 23
        Height = 22
      end
    end
  end
  object pnlBotoesSQLTrace: TPanel [2]
    Left = 0
    Top = 163
    Width = 451
    Height = 41
    TabOrder = 4
    object lblNSQLTrace: TLabel
      Left = 388
      Top = 0
      Width = 3
      Height = 14
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 34
    Width = 451
    Height = 155
    Align = alClient
    TabOrder = 0
    DesignSize = (
      451
      155)
    object lblPerfeitasCondicoes: TLabel
      Left = 8
      Top = 11
      Width = 183
      Height = 14
      Caption = 'Equipamento em perfeitas condi'#231#245'es?'
    end
    object ColorLabel28: TColorLabel
      Left = 224
      Top = 11
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
      Top = 32
      Width = 224
      Height = 14
      Caption = 'Observa'#231#245'es sobre o estado do equipamento:'
    end
    object edtPerfeitasCondicoes: TEditFocus
      Tag = 99
      Left = 196
      Top = 5
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
      Top = 53
      Width = 433
      Height = 95
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      StringQuebra = '<<csq>>'
    end
  end
  object Panel2: TPanel [4]
    Left = 0
    Top = 189
    Width = 451
    Height = 54
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      451
      54)
    object Label3: TLabel
      Left = 8
      Top = 10
      Width = 57
      Height = 14
      Caption = 'Conferente:'
    end
    object Label4: TLabel
      Left = 8
      Top = 34
      Width = 56
      Height = 14
      Caption = 'Supervisor:'
    end
    object edtCodConferente: TEditFocus
      Tag = 99
      Left = 70
      Top = 4
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
      Top = 28
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
      Top = 4
      Width = 314
      Height = 22
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
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
      Top = 28
      Width = 314
      Height = 22
      Alignment = taLeftJustify
      Anchors = [akLeft, akTop, akRight]
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
  object pnlDataInspecao: TPanel [5]
    Left = 0
    Top = 0
    Width = 451
    Height = 34
    Align = alTop
    TabOrder = 5
    object lblTermino: TLabel
      Left = 7
      Top = 11
      Width = 72
      Height = 14
      Caption = 'Data Inspe'#231#227'o:'
    end
    object mskDtaIps: TMaskEditFocus
      Tag = 99
      Left = 85
      Top = 6
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
    object edtHorIps: TMaskEditFocus
      Tag = 99
      Left = 168
      Top = 6
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
end
