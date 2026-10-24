inherited frmCadOcorrenciaEntrega: TfrmCadOcorrenciaEntrega
  Width = 537
  Height = 319
  Caption = 'Ocorr'#234'ncias para APP Entrega'
  OnDestroy = FormDestroy
  ExplicitWidth = 537
  ExplicitHeight = 319
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 56
    Top = 55
    Width = 36
    Height = 14
    Alignment = taRightJustify
    Caption = 'C'#243'digo:'
  end
  object Label2: TLabel [1]
    Left = 40
    Top = 79
    Width = 52
    Height = 14
    Alignment = taRightJustify
    Caption = 'Descri'#231#227'o:'
  end
  object Label3: TLabel [2]
    Left = 12
    Top = 103
    Width = 80
    Height = 14
    Alignment = taRightJustify
    Caption = 'Tipo Ocorr'#234'ncia:'
  end
  object Label4: TLabel [3]
    Left = 278
    Top = 103
    Width = 92
    Height = 14
    Alignment = taRightJustify
    Caption = 'N'#237'vel de Prioridade:'
  end
  inherited pnlBotoes: TPanel
    Top = 246
    Width = 531
    ExplicitTop = 246
    ExplicitWidth = 531
    inherited FlwBotoes: TFlowPanel
      Width = 527
      ExplicitTop = 2
      ExplicitWidth = 527
    end
    inherited btnSair: TBitBtnLocked
      Left = 450
      ExplicitLeft = 450
    end
  end
  inherited pnlStatus: TPanel
    Top = 274
    Width = 531
    ExplicitTop = 274
    ExplicitWidth = 531
    inherited pnlNomeForm: TPanel
      Left = 184
      ExplicitLeft = 184
    end
    inherited pnlInfo: TPanel
      Width = 184
      ExplicitWidth = 184
    end
  end
  inherited pgcDados: TPageControl
    Left = -600
    Align = alNone
    ExplicitLeft = -600
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 577
      ExplicitHeight = 226
    end
  end
  object dbeCodigo: TDBEditFocus [7]
    Tag = 99
    Left = 94
    Top = 52
    Width = 65
    Height = 22
    CharCase = ecUpperCase
    DataField = 'OCR_CODIGO'
    DataSource = dtsTabela
    MaxLength = 5
    TabOrder = 4
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TipoTexto = ttAlfanumerico
  end
  object dbeDescri: TDBEditFocus [8]
    Left = 94
    Top = 76
    Width = 425
    Height = 22
    CharCase = ecUpperCase
    DataField = 'OCR_DESCRI'
    DataSource = dtsTabela
    TabOrder = 5
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttAlfanumerico
  end
  object cmbTipOcr: TComboBoxFocus [9]
    Left = 94
    Top = 100
    Width = 168
    Height = 22
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 6
    Text = 'ENTREGA NAO REALIZADA'
    OnClick = cmbTipOcrClick
    Items.Strings = (
      'ENTREGA NAO REALIZADA'
      'ENTREGA REALIZADA')
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
  end
  object rdgOcoRom: TRadioGroup [10]
    Tag = 99
    Left = 12
    Top = 5
    Width = 185
    Height = 41
    Caption = 'N'#237'vel da ocorr'#234'ncia'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Documento'
      'Romaneio')
    TabOrder = 3
    OnClick = rdgOcoRomClick
  end
  object dbeNivPri: TDBEditFocus [11]
    Tag = 99
    Left = 374
    Top = 100
    Width = 49
    Height = 22
    DataField = 'OCR_NIVPRI'
    DataSource = dtsTabela
    TabOrder = 7
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TipoTexto = ttNumerico
  end
  object chkNotCli: TDBCheckBox [12]
    Tag = 99
    Left = 368
    Top = 7
    Width = 158
    Height = 17
    Caption = 'Enviar Notifica'#231#227'o ao Cliente'
    DataField = 'OCR_NOTCLI'
    DataSource = dtsTabela
    TabOrder = 8
    ValueChecked = 'S'
    ValueUnchecked = 'N'
    OnClick = chkNotCliClick
  end
  object pnlNotCli: TPanel [13]
    Left = 0
    Top = 134
    Width = 531
    Height = 112
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 9
    object lblMsgCli: TLabel
      Left = 0
      Top = 0
      Width = 531
      Height = 14
      Align = alTop
      Alignment = taCenter
      Caption = 'Notifica'#231#227'o Cliente'
      ExplicitWidth = 89
    end
    object mmoMsgCli: TDBMemo
      Tag = 99
      Left = 0
      Top = 14
      Width = 531
      Height = 98
      Align = alClient
      DataField = 'OCR_MSGCLI'
      DataSource = dtsTabela
      TabOrder = 0
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 560
    Top = 84
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 580
    Top = 164
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 568
  end
  object dtsTabela: TDataSource
    Left = 536
    Top = 88
  end
end
