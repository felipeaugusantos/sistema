inherited frmSituacaoEquipamento: TfrmSituacaoEquipamento
  Height = 186
  BorderIcons = [biSystemMenu]
  Caption = 'Situa'#231#227'o do Equipamento'
  Position = poMainFormCenter
  ExplicitHeight = 186
  PixelsPerInch = 96
  TextHeight = 14
  object lblSituacaoEquipamento: TLabel [0]
    Left = 22
    Top = 24
    Width = 130
    Height = 14
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Situa'#231#227'o do equipamento:'
  end
  object lblRetiradoPor: TLabel [1]
    Left = 22
    Top = 49
    Width = 130
    Height = 14
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Retirado por:'
  end
  object lblDtaRetirada: TLabel [2]
    Left = 22
    Top = 74
    Width = 130
    Height = 14
    Alignment = taRightJustify
    AutoSize = False
    Caption = 'Data de retirada:'
  end
  inherited pnlBotoes: TPanel
    Top = 113
    TabOrder = 3
    ExplicitTop = 113
    inherited FlwBotoes: TFlowPanel
      ExplicitTop = 2
      ExplicitHeight = 24
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 97
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = '&Confirma'
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 141
    TabOrder = 4
    ExplicitTop = 141
  end
  object cmbSituacaoEquipamento: TComboBoxFocus [6]
    Left = 158
    Top = 21
    Width = 151
    Height = 22
    Style = csDropDownList
    TabOrder = 0
    OnChange = cmbSituacaoEquipamentoChange
    Items.Strings = (
      'Armazenado'
      'Retirado pelo cliente')
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
  end
  object edtRetiradoPor: TEditFocus [7]
    Left = 158
    Top = 46
    Width = 300
    Height = 22
    Alignment = taLeftJustify
    MaxLength = 50
    TabOrder = 1
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 50
    TipoTexto = ttAlfanumerico
  end
  object mskDtaRetirada: TMaskEditFocus [8]
    Tag = 99
    Left = 158
    Top = 71
    Width = 61
    Height = 22
    CharCase = ecUpperCase
    EditMask = '99/99/9999'
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 10
    TabOrder = 2
    Text = '  /  /    '
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = True
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 352
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 312
    Top = 80
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 268
    Top = 80
  end
end
