inherited frmImpBoletosCTe: TfrmImpBoletosCTe
  Width = 403
  Height = 168
  Caption = 'Impress'#227'o de boletos da CT-e'
  ExplicitWidth = 403
  ExplicitHeight = 168
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 8
    Top = 11
    Width = 385
    Height = 42
    AutoSize = False
    Caption = 
      'Aguarde a gera'#231#227'o das contas a receber pela empresa emitente da ' +
      'CT-e para realizar a impress'#227'o do boleto. Caso cancele, ser'#225' pos' +
      's'#237'vel realizar a impress'#227'o pela rotina de "Impress'#227'o de Boletos"' +
      '  no menu principal.'
    WordWrap = True
  end
  object Label2: TLabel [1]
    Left = 8
    Top = 68
    Width = 65
    Height = 14
    Caption = 'N'#250'mero CT-e:'
  end
  object Label4: TLabel [2]
    Left = 208
    Top = 68
    Width = 45
    Height = 14
    Caption = 'Empresa:'
  end
  inherited pnlBotoes: TPanel
    Top = 97
    Width = 397
    ExplicitTop = 97
    ExplicitWidth = 397
    inherited FlwBotoes: TFlowPanel
      Width = 393
      ExplicitWidth = 393
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 314
      ExplicitLeft = 314
    end
  end
  inherited pnlStatus: TPanel
    Top = 123
    Width = 397
    ExplicitTop = 123
    ExplicitWidth = 397
    inherited pnlNomeForm: TPanel
      Left = 226
      ExplicitLeft = 226
    end
    inherited pnlInfo: TPanel
      Width = 226
      ExplicitWidth = 226
    end
  end
  object edtNumCte: TEditFocus [5]
    Left = 79
    Top = 65
    Width = 121
    Height = 22
    Alignment = taLeftJustify
    ReadOnly = True
    TabOrder = 3
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtCodEmp: TEditFocus [6]
    Left = 256
    Top = 65
    Width = 45
    Height = 22
    Alignment = taLeftJustify
    ReadOnly = True
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
