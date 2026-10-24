inherited frmRcxDigitaMotivoRecusaLiberacao: TfrmRcxDigitaMotivoRecusaLiberacao
  Width = 494
  Height = 153
  Caption = 'Digite o Motivo da Recusa'
  ExplicitWidth = 494
  ExplicitHeight = 153
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 82
    Width = 488
    inherited FlwBotoes: TFlowPanel
      Width = 484
    end
    inherited btnSair: TBitBtnLocked
      Left = 409
      Top = 2
      ExplicitLeft = 409
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 108
    Width = 488
    inherited pnlNomeForm: TPanel
      Left = 232
      Width = 256
      ExplicitLeft = 232
      ExplicitWidth = 256
    end
    inherited pnlInfo: TPanel
      Width = 232
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 488
    Height = 82
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 2
    ExplicitLeft = -9
    ExplicitWidth = 492
    ExplicitHeight = 87
    object lblPortador: TLabel
      Left = 15
      Top = 54
      Width = 89
      Height = 14
      Alignment = taRightJustify
      Caption = 'Motivo da Recusa:'
    end
    object lblDescricao: TLabel
      Left = 46
      Top = 12
      Width = 58
      Height = 14
      Alignment = taRightJustify
      Caption = 'Recusando:'
    end
    object lblValor: TLabel
      Left = 110
      Top = 12
      Width = 21
      Height = 14
      Caption = '0,00'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblModalidade: TLabel
      Left = 47
      Top = 28
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Modalidade:'
    end
    object lblModalidadeDescricao: TLabel
      Left = 110
      Top = 28
      Width = 130
      Height = 14
      Caption = 'lblModalidadeDescricao'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtMotivoRecusa: TEditFocus
      Left = 110
      Top = 51
      Width = 367
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 27
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
end
