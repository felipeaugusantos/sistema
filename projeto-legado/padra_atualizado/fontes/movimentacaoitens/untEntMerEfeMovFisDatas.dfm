inherited frmEntMerEfeMovFisDatas: TfrmEntMerEfeMovFisDatas
  Width = 616
  Height = 169
  Caption = 'Efetivar Movimento Fiscal - Datas'
  OnDestroy = FormDestroy
  ExplicitWidth = 616
  ExplicitHeight = 169
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 10
    Top = 40
    Width = 141
    Height = 14
    Caption = 'Data de Sa'#237'da do Fornecedor'
  end
  object Label2: TLabel [1]
    Left = 262
    Top = 40
    Width = 201
    Height = 14
    Caption = 'Data de Carregamento da Transportadora'
  end
  object Label3: TLabel [2]
    Left = 8
    Top = 73
    Width = 143
    Height = 14
    Caption = 'Data de Chegada na Empresa'
  end
  object Label4: TLabel [3]
    Left = 386
    Top = 73
    Width = 77
    Height = 14
    Caption = 'Data da Entrada'
  end
  object Label5: TLabel [4]
    Left = 38
    Top = 8
    Width = 113
    Height = 14
    Caption = 'Natureza da Opera'#231#227'o:'
  end
  inherited pnlBotoes: TPanel
    Top = 98
    Width = 610
    TabOrder = 5
    ExplicitTop = 98
    ExplicitWidth = 610
    inherited FlwBotoes: TFlowPanel
      Width = 529
      ExplicitTop = 2
      ExplicitWidth = 606
      inherited btnConfirma: TBitBtnLocked
        Align = alLeft
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 531
      Top = 2
      Align = alRight
      ExplicitLeft = 527
    end
  end
  inherited pnlStatus: TPanel
    Top = 124
    Width = 610
    TabOrder = 6
    ExplicitTop = 124
    ExplicitWidth = 610
    inherited pnlNomeForm: TPanel
      Left = 439
      ExplicitLeft = 439
    end
    inherited pnlInfo: TPanel
      Width = 439
      ExplicitWidth = 439
    end
  end
  object mskDtaSFo: TMaskEditFocus [8]
    Tag = 99
    Left = 157
    Top = 34
    Width = 89
    Height = 22
    EditMask = '!99/99/9999;1;_'
    MaxLength = 10
    TabOrder = 1
    Text = '  /  /    '
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = False
  end
  object mskDtaCTr: TMaskEditFocus [9]
    Tag = 99
    Left = 469
    Top = 34
    Width = 89
    Height = 22
    EditMask = '!99/99/9999;1;_'
    MaxLength = 10
    TabOrder = 2
    Text = '  /  /    '
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = False
  end
  object mskDtaEnt: TMaskEditFocus [10]
    Tag = 99
    Left = 469
    Top = 67
    Width = 89
    Height = 22
    EditMask = '!99/99/9999;1;_'
    MaxLength = 10
    TabOrder = 4
    Text = '  /  /    '
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = False
  end
  object mskDtaCEm: TMaskEditFocus [11]
    Tag = 99
    Left = 157
    Top = 67
    Width = 89
    Height = 22
    EditMask = '!99/99/9999;1;_'
    MaxLength = 10
    TabOrder = 3
    Text = '  /  /    '
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = False
  end
  object cmbNatOperacao: TComboBoxFocus [12]
    Tag = 99
    Left = 157
    Top = 6
    Width = 435
    Height = 22
    Style = csDropDownList
    TabOrder = 0
    OnChange = cmbNatOperacaoChange
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 228
    Top = 144
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 136
    Top = 144
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 168
    Top = 144
  end
end
