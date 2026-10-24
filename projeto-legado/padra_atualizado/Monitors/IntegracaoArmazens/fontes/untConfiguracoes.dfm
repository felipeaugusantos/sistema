object frmConfiguracoes: TfrmConfiguracoes
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Configura'#231#245'es'
  ClientHeight = 400
  ClientWidth = 495
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  DesignSize = (
    495
    400)
  PixelsPerInch = 96
  TextHeight = 13
  object btnSair: TBitBtnLocked
    Left = 408
    Top = 368
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Sair'
    TabOrder = 2
    OnClick = btnSairClick
    ExplicitTop = 301
  end
  object grbFTP: TGroupBox
    Left = 8
    Top = 106
    Width = 475
    Height = 213
    Caption = 'FTP'
    TabOrder = 0
    DesignSize = (
      475
      213)
    object edtIP: TLabeledEditFocus
      Left = 28
      Top = 40
      Width = 200
      Height = 21
      TabStop = False
      Color = 16770261
      EditLabel.Width = 76
      EditLabel.Height = 13
      EditLabel.Caption = 'IP / Host Name:'
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtPorta: TLabeledEditFocus
      Left = 28
      Top = 84
      Width = 200
      Height = 21
      TabStop = False
      Color = 16770261
      EditLabel.Width = 30
      EditLabel.Height = 13
      EditLabel.Caption = 'Porta:'
      NumbersOnly = True
      ReadOnly = True
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtUsuario: TLabeledEditFocus
      Left = 28
      Top = 132
      Width = 200
      Height = 21
      TabStop = False
      Color = 16770261
      EditLabel.Width = 40
      EditLabel.Height = 13
      EditLabel.Caption = 'Usu'#225'rio:'
      ReadOnly = True
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object edtSenha: TLabeledEditFocus
      Left = 28
      Top = 176
      Width = 200
      Height = 21
      TabStop = False
      Color = 16770261
      EditLabel.Width = 34
      EditLabel.Height = 13
      EditLabel.Caption = 'Senha:'
      PasswordChar = '*'
      ReadOnly = True
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
    object btnTesteConexao: TBitBtnLocked
      Left = 344
      Top = 174
      Width = 108
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Teste de Conex'#227'o'
      TabOrder = 5
      OnClick = btnTesteConexaoClick
    end
    object edtIntervalo: TLabeledEditFocus
      Left = 252
      Top = 40
      Width = 200
      Height = 21
      TabStop = False
      Color = 16770261
      EditLabel.Width = 106
      EditLabel.Height = 13
      EditLabel.Caption = 'Intervalo (Segundos):'
      NumbersOnly = True
      ReadOnly = True
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
    end
  end
  object edtEmpresas: TLabeledEditFocus
    Left = 8
    Top = 339
    Width = 475
    Height = 21
    TabStop = False
    Color = 16770261
    EditLabel.Width = 218
    EditLabel.Height = 13
    EditLabel.Caption = 'Empresas Monitoradas: (Ex.:) 001_002_003_'
    ReadOnly = True
    TabOrder = 1
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
  end
  object rdgFormaGeracao: TRadioGroup
    Left = 8
    Top = 7
    Width = 475
    Height = 46
    Caption = 'Forma de Gera'#231#227'o'
    Columns = 2
    Enabled = False
    Items.Strings = (
      'FTP Externo'
      'Pasta Externa')
    TabOrder = 3
  end
  object edtPastaExterna: TLabeledEditFocus
    Left = 8
    Top = 77
    Width = 475
    Height = 21
    TabStop = False
    Color = 16770261
    EditLabel.Width = 205
    EditLabel.Height = 13
    EditLabel.Caption = 'Pasta Externa para grava'#231#227'o dos arquivos'
    ReadOnly = True
    TabOrder = 4
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
  end
  object IdFTP: TIdFTP
    IPVersion = Id_IPv4
    ConnectTimeout = 0
    NATKeepAlive.UseKeepAlive = False
    NATKeepAlive.IdleTimeMS = 0
    NATKeepAlive.IntervalMS = 0
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    Left = 300
    Top = 116
  end
end
