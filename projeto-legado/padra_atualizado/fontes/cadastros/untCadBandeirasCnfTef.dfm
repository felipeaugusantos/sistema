inherited frmCadBandeirasCnfTef: TfrmCadBandeirasCnfTef
  Width = 444
  Height = 174
  Caption = 'Configure C'#243'digo Bandeira'
  ExplicitWidth = 444
  ExplicitHeight = 174
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 53
    Top = 20
    Width = 142
    Height = 14
    Caption = 'C'#243'd. Bandeira Fiserv-ClisiTef:'
  end
  object Label2: TLabel [1]
    Left = 20
    Top = 48
    Width = 175
    Height = 14
    Caption = 'C'#243'd. Bandeira Conex'#227'oTech-Scope:'
  end
  object Label3: TLabel [2]
    Left = 122
    Top = 76
    Width = 73
    Height = 14
    Caption = 'Tipo de Cart'#227'o:'
  end
  inherited pnlBotoes: TPanel
    Top = 103
    Width = 438
    TabOrder = 3
    ExplicitTop = 103
    ExplicitWidth = 438
    inherited FlwBotoes: TFlowPanel
      Width = 434
      ExplicitWidth = 434
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 358
      ExplicitLeft = 358
    end
  end
  inherited pnlStatus: TPanel
    Top = 129
    Width = 438
    TabOrder = 4
    ExplicitTop = 129
    ExplicitWidth = 438
    inherited pnlNomeForm: TPanel
      Left = 267
      ExplicitLeft = 267
    end
    inherited pnlInfo: TPanel
      Width = 267
      ExplicitWidth = 267
    end
  end
  object dbeTftBan: TDBEditFocus [5]
    Left = 199
    Top = 17
    Width = 121
    Height = 22
    DataField = 'BAN_TFTBAN'
    DataSource = dtsCnfTef
    TabOrder = 0
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TipoTexto = ttAlfanumerico
  end
  object dbeTfBan2: TDBEditFocus [6]
    Left = 199
    Top = 45
    Width = 121
    Height = 22
    DataField = 'BAN_TFBAN2'
    DataSource = dtsCnfTef
    TabOrder = 1
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TipoTexto = ttAlfanumerico
  end
  object dbeTipCar: TDBComboBoxFocus [7]
    Tag = 99
    Left = 199
    Top = 73
    Width = 121
    Height = 22
    Style = csOwnerDrawFixed
    DataField = 'BAN_TIPCAR'
    DataSource = dtsCnfTef
    Items.Strings = (
      'Cr'#233'dito'
      'D'#233'bito')
    TabOrder = 2
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
  end
  object dtsCnfTef: TDataSource
    AutoEdit = False
    Left = 400
    Top = 64
  end
end
