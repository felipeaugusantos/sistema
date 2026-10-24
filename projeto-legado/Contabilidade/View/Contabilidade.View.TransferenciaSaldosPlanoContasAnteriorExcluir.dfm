inherited frmTransferenciaSaldosPlanoContasAnteriorExcluir: TfrmTransferenciaSaldosPlanoContasAnteriorExcluir
  Width = 734
  Height = 144
  Caption = 'Informe'
  ExplicitWidth = 734
  ExplicitHeight = 144
  PixelsPerInch = 96
  TextHeight = 14
  object Label15: TLabel [0]
    Left = 92
    Top = 14
    Width = 45
    Height = 14
    Alignment = taRightJustify
    Caption = 'Empresa:'
  end
  object Label1: TLabel [1]
    Left = 10
    Top = 51
    Width = 127
    Height = 14
    Alignment = taRightJustify
    Caption = 'Compet'#234'ncia (MM/AAAA):'
  end
  inherited pnlBotoes: TPanel
    Top = 73
    Width = 728
    TabOrder = 2
    ExplicitTop = 71
    ExplicitWidth = 728
    inherited FlwBotoes: TFlowPanel
      Width = 724
      ExplicitWidth = 724
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 648
      ExplicitLeft = 648
    end
  end
  inherited pnlStatus: TPanel
    Top = 99
    Width = 728
    TabOrder = 3
    ExplicitTop = 97
    ExplicitWidth = 728
    inherited pnlNomeForm: TPanel
      Left = 557
      ExplicitLeft = 557
    end
    inherited pnlInfo: TPanel
      Width = 557
      ExplicitWidth = 557
    end
  end
  object edtEmpLan: TEditFocus [4]
    Tag = 99
    Left = 142
    Top = 11
    Width = 57
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 3
    TabOrder = 0
    OnKeyPress = edtEmpLanKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 3
    TipoTexto = ttNumerico
  end
  object edtNomEmp: TEditFocus [5]
    Left = 201
    Top = 11
    Width = 512
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ReadOnly = True
    TabOrder = 4
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object edtCompet: TMaskEditFocus [6]
    Left = 141
    Top = 43
    Width = 82
    Height = 22
    EditMask = '!99/9999;1; '
    MaxLength = 7
    TabOrder = 1
    Text = '  /    '
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = False
  end
end
