inherited frmCadTintasBasesAutomotivaStandox: TfrmCadTintasBasesAutomotivaStandox
  Left = 309
  Top = 189
  Width = 599
  Height = 186
  Caption = 'frmCadTintasBasesAutomotivaStandox'
  ExplicitWidth = 599
  ExplicitHeight = 186
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 114
    Width = 593
    ExplicitTop = 114
    ExplicitWidth = 593
    DesignSize = (
      593
      28)
    inherited btnSair: TBitBtnLocked
      Left = 516
      ExplicitLeft = 516
    end
  end
  inherited pnlStatus: TPanel
    Top = 142
    Width = 593
    ExplicitTop = 142
    ExplicitWidth = 593
    inherited pnlNomeForm: TPanel
      Left = 246
      ExplicitLeft = 246
    end
    inherited pnlInfo: TPanel
      Width = 246
      ExplicitWidth = 246
    end
  end
  inherited pgcDados: TPageControl
    Width = 593
    Height = 114
    ExplicitWidth = 593
    ExplicitHeight = 114
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 585
      ExplicitHeight = 82
    end
  end
  inherited pnlCampos: TPanel
    Width = 593
    Height = 114
    ExplicitWidth = 593
    ExplicitHeight = 114
    inherited lblCodigoItem: TLabel
      Top = 65
      ExplicitTop = 65
    end
    inherited lblPrecoCusto: TLabel
      Top = 87
      ExplicitTop = 87
    end
    inherited lblMargem: TLabel
      Top = 87
      ExplicitTop = 87
    end
    inherited lblPrecoVenda: TLabel
      Top = 87
      ExplicitTop = 87
    end
    inherited btnRestPreco: TSpeedButton
      Top = 83
      ExplicitTop = 83
    end
    inherited edtDescricaoItem: TEdit
      Top = 61
      TabOrder = 6
      ExplicitTop = 61
    end
    inherited dbeEmbalagem: TDBEditFocus
      Width = 73
      ExplicitWidth = 73
    end
    inherited dbePesoEspecifico: TDBEditFocus
      ReadOnly = True
      TabOrder = 4
    end
    inherited dbeCodigoItem: TDBEditFocus
      Top = 61
      TabOrder = 5
      ExplicitTop = 61
    end
    inherited dbePrecoCusto: TDBEditFocus
      Top = 83
      TabOrder = 7
      ExplicitTop = 83
    end
    inherited dbeMargem: TDBEditFocus
      Top = 83
      TabOrder = 8
      ExplicitTop = 83
    end
    inherited dbePrecoVenda: TDBEditFocus
      Top = 83
      TabOrder = 9
      ExplicitTop = 83
    end
    object chkPesGra: TDBCheckBox
      Left = 160
      Top = 40
      Width = 105
      Height = 17
      Caption = 'Peso em gramas?'
      DataField = 'BAS_PESGRA'
      TabOrder = 3
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Top = 65524
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 435
    Top = 65524
  end
end
