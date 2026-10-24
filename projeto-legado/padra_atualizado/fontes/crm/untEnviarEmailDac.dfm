inherited frmEnviarEmailDac: TfrmEnviarEmailDac
  Width = 368
  Height = 158
  Caption = 'Selecionar Documento de Devolu'#231#227'o'
  ExplicitWidth = 368
  ExplicitHeight = 158
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 239
    Top = 90
    Width = 72
    Height = 14
    Alignment = taRightJustify
    Caption = 'N'#250'mero do AD:'
  end
  inherited pnlBotoes: TPanel
    Top = 86
    Width = 362
    ExplicitTop = 86
    ExplicitWidth = 362
    inherited btnSair: TBitBtnLocked
      Left = 279
      ExplicitLeft = 279
    end
    inherited btnConfirma: TBitBtnLocked
      ModalResult = 0
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 362
    Height = 86
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object lblNumAD: TLabel
      Left = 15
      Top = 23
      Width = 72
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#250'mero do AD:'
    end
    object Label2: TLabel
      Left = 8
      Top = 50
      Width = 77
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#250'mero da Dev:'
    end
    object Label3: TLabel
      Left = 181
      Top = 50
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'S'#233'rie:'
    end
    object edtNumAD: TEditFocus
      Tag = 99
      Left = 91
      Top = 19
      Width = 83
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      MaxLength = 8
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNumDev: TEditFocus
      Tag = 99
      Left = 91
      Top = 47
      Width = 83
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      MaxLength = 12
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtSerie_: TEditFocus
      Tag = 99
      Left = 215
      Top = 47
      Width = 62
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      MaxLength = 8
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 3
      TipoTexto = ttNumerico
    end
  end
  inherited pnlStatus: TPanel
    Top = 114
    Width = 362
    ExplicitTop = 114
    ExplicitWidth = 362
    inherited pnlNomeForm: TPanel
      Left = 191
      ExplicitLeft = 191
    end
    inherited pnlInfo: TPanel
      Width = 191
      ExplicitWidth = 191
    end
  end
end
