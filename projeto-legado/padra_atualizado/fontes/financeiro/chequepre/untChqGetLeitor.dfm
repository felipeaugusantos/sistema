inherited frmChqGetLeitor: TfrmChqGetLeitor
  Left = 401
  Top = 370
  Width = 327
  Height = 139
  ActiveControl = edtCheque
  Caption = 'Leitura de Cheques'
  Position = poMainFormCenter
  ExplicitWidth = 327
  ExplicitHeight = 139
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 95
    Width = 321
    ExplicitTop = 95
    ExplicitWidth = 321
  end
  inherited pnlStatus: TPanel
    Top = 95
    Width = 321
    TabOrder = 3
    ExplicitTop = 95
    ExplicitWidth = 321
    inherited pnlNomeForm: TPanel
      Left = 178
      Width = 143
      ExplicitLeft = 178
      ExplicitWidth = 143
    end
    inherited pnlInfo: TPanel
      Width = 178
      ExplicitWidth = 178
    end
  end
  inherited pgcDados: TPageControl
    Width = 321
    Height = 95
    TabOrder = 1
    TabStop = False
    ExplicitWidth = 321
    ExplicitHeight = 95
  end
  object pnlGeral: TPanel [3]
    Left = 0
    Top = 0
    Width = 321
    Height = 95
    Align = alClient
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 44
      Top = 21
      Width = 227
      Height = 22
      Caption = 'Passe o cheque desejado:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtCheque: TEditFocus
      Tag = 99
      Left = 44
      Top = 45
      Width = 225
      Height = 22
      TabOrder = 0
      OnChange = edtChequeChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 248
    Top = 65528
  end
end
