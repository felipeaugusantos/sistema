inherited frmRelFatProfissional: TfrmRelFatProfissional
  Left = 388
  Top = 265
  Width = 429
  Height = 250
  ActiveControl = mskDtaIni
  BorderIcons = [biSystemMenu]
  Caption = 'Relat'#243'rio de Profissional'
  ExplicitWidth = 429
  ExplicitHeight = 250
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 181
    Width = 423
    TabOrder = 1
    ExplicitTop = 181
    ExplicitWidth = 423
    inherited btnSair: TBitBtn
      Left = 341
      ExplicitLeft = 341
    end
    inherited btnImprimir: TBitBtn
      Left = 2
      ExplicitLeft = 2
    end
    inherited btnConfigurar: TBitBtn
      Left = 79
      ExplicitLeft = 79
    end
  end
  inherited pnlStatus: TPanel
    Top = 209
    Width = 423
    TabOrder = 2
    ExplicitTop = 209
    ExplicitWidth = 423
    inherited pnlNomeForm: TPanel
      Left = 252
      ExplicitLeft = 252
    end
    inherited pnlInfo: TPanel
      Width = 252
      ExplicitWidth = 252
    end
  end
  inherited pnlDados: TPanel
    Width = 423
    Height = 181
    TabOrder = 0
    ExplicitWidth = 423
    ExplicitHeight = 181
    object Label11: TLabel [0]
      Left = 7
      Top = 42
      Width = 47
      Height = 14
      Caption = 'Data Final'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object lblDesDtaIni: TLabel [1]
      Left = 78
      Top = 24
      Width = 107
      Height = 14
      Caption = '(DATA DE ENTRADA)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblDesDtaFin: TLabel [2]
      Left = 78
      Top = 60
      Width = 107
      Height = 14
      Caption = '(DATA DE ENTRADA)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label12: TLabel [3]
      Left = 7
      Top = 5
      Width = 51
      Height = 14
      Caption = 'Data Inicial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel [4]
      Left = 7
      Top = 80
      Width = 27
      Height = 14
      Caption = 'Pintor'
    end
    object Label2: TLabel [5]
      Left = 326
      Top = 5
      Width = 72
      Height = 14
      Caption = 'Somente Class'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    inherited gpbDestino: TGroupBox
      Left = 168
      Top = 120
      Width = 150
      Height = 48
      TabOrder = 4
      ExplicitLeft = 168
      ExplicitTop = 120
      ExplicitWidth = 150
      ExplicitHeight = 48
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 7
      Top = 19
      Width = 66
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ParentFont = False
      TabOrder = 0
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 7
      Top = 54
      Width = 68
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ParentFont = False
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtCodProfissional: TEditFocus
      Left = 7
      Top = 94
      Width = 57
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      ParentFont = False
      TabOrder = 2
      OnExit = edtCodProfissionalExit
      OnKeyPress = edtCodProfissionalKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
      Alignment = taLeftJustify
    end
    object edtDesProfissional: TEditFocus
      Left = 68
      Top = 93
      Width = 250
      Height = 22
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
    object gpbTipo: TGroupBox
      Left = 6
      Top = 120
      Width = 150
      Height = 48
      Caption = 'Tipo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      object ColorLabel2: TColorLabel
        Left = 29
        Top = 22
        Width = 101
        Height = 14
        Caption = '(A)nal'#237'tico (S)int'#233'tico'
        CorDestaque = clRed
      end
      object edtTipo: TEditFocus
        Tag = 99
        Left = 7
        Top = 19
        Width = 18
        Height = 22
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = 'A'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
        Alignment = taLeftJustify
      end
    end
    object lstClaFis: TMemo
      Left = 326
      Top = 19
      Width = 91
      Height = 148
      TabStop = False
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
      ScrollBars = ssVertical
      TabOrder = 6
      WantReturns = False
      WordWrap = False
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 240
    Top = 48
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 287
    Top = 48
  end
end
