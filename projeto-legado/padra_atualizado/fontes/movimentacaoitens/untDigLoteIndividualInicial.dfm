inherited frmDigLoteIndividualInicial: TfrmDigLoteIndividualInicial
  Width = 501
  Height = 142
  Caption = 'Lote Inicial'
  ExplicitWidth = 501
  ExplicitHeight = 142
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 70
    Width = 495
    TabOrder = 1
    ExplicitTop = 70
    ExplicitWidth = 495
    inherited btnSair: TBitBtnLocked
      Left = 412
      ExplicitLeft = 412
    end
    inherited btnConfirma: TBitBtnLocked
      Left = 2
      ModalResult = 0
      ExplicitLeft = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 98
    Width = 495
    TabOrder = 3
    ExplicitTop = 98
    ExplicitWidth = 495
    inherited pnlNomeForm: TPanel
      Left = 324
      ExplicitLeft = 324
    end
    inherited pnlInfo: TPanel
      Width = 324
      ExplicitWidth = 324
    end
  end
  object GroupBox1: TGroupBox [3]
    Left = 8
    Top = 5
    Width = 476
    Height = 59
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 10
      Width = 34
      Height = 14
      Caption = 'Prefixo'
    end
    object Label2: TLabel
      Left = 131
      Top = 10
      Width = 94
      Height = 14
      Caption = 'Sequencial Inicial'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 346
      Top = 10
      Width = 31
      Height = 14
      Caption = 'Sufixo'
    end
    object edtPrefixo: TEditFocus
      Tag = 99
      Left = 8
      Top = 25
      Width = 121
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtSequencial: TEditFocus
      Tag = 99
      Left = 131
      Top = 25
      Width = 213
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtSufixo: TEditFocus
      Tag = 99
      Left = 346
      Top = 25
      Width = 121
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Top = 48
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 408
    Top = 32
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 448
    Top = 48
  end
end
