inherited FrmPgtoOnlineESiTefDadosCartao: TFrmPgtoOnlineESiTefDadosCartao
  Width = 430
  Height = 135
  Caption = 'Informe os dados do Cart'#227'o'
  ExplicitWidth = 430
  ExplicitHeight = 135
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 73
    Top = 8
    Width = 75
    Height = 14
    Caption = 'N'#250'mero Cart'#227'o:'
  end
  object Label2: TLabel [1]
    Left = 8
    Top = 40
    Width = 140
    Height = 14
    Caption = 'Vencimento Cart'#227'o (MM/AA):'
  end
  inherited pnlBotoes: TPanel
    Top = 64
    Width = 424
    TabOrder = 2
    ExplicitTop = 64
    ExplicitWidth = 424
    inherited FlwBotoes: TFlowPanel
      Width = 420
      ExplicitWidth = 420
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 341
      ExplicitLeft = 341
    end
  end
  inherited pnlStatus: TPanel
    Top = 90
    Width = 424
    TabOrder = 3
    ExplicitTop = 90
    ExplicitWidth = 424
    inherited pnlNomeForm: TPanel
      Left = 253
      ExplicitLeft = 253
    end
    inherited pnlInfo: TPanel
      Width = 253
      ExplicitWidth = 253
    end
  end
  object edtNumCar: TMaskEditFocus [4]
    Left = 154
    Top = 5
    Width = 254
    Height = 22
    EditMask = '9999\ 9999\ 9999\ 9999;1; '
    MaxLength = 19
    TabOrder = 0
    Text = '                   '
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = False
  end
  object edtVenCar: TMaskEditFocus [5]
    Left = 154
    Top = 37
    Width = 54
    Height = 22
    EditMask = '99\/99;1; '
    MaxLength = 5
    TabOrder = 1
    Text = '  /  '
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = False
  end
end
