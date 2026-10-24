inherited frmPedeEmpresaUnif: TfrmPedeEmpresaUnif
  Height = 287
  Caption = 'Informe a empresa destino para os pedidos selecionados'
  ExplicitHeight = 287
  PixelsPerInch = 96
  TextHeight = 14
  object lbl1: TLabel [0]
    Left = 7
    Top = 185
    Width = 84
    Height = 14
    Alignment = taRightJustify
    Caption = 'Empresa Destino:'
  end
  inherited pnlBotoes: TPanel
    Top = 216
    TabOrder = 2
    ExplicitTop = 216
    inherited FlwBotoes: TFlowPanel
      Width = 402
      ExplicitTop = 2
      inherited btnConfirma: TBitBtnLocked
        Align = alLeft
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 404
      Top = 2
      Align = alRight
    end
  end
  inherited pnlStatus: TPanel
    Top = 242
    TabOrder = 3
    ExplicitTop = 242
  end
  object DBGridCitel1: TDBGridCitel [4]
    Left = 0
    Top = 20
    Width = 483
    Height = 149
    Align = alTop
    DataSource = dtsCadEmp
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 0
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'CODEMP'
        Title.Alignment = taCenter
        Title.Caption = 'C'#243'digo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMEMP'
        Title.Caption = 'Nome da Empresa'
        Width = 379
        Visible = True
      end>
  end
  object Panel1: TPanel [5]
    Left = 0
    Top = 0
    Width = 483
    Height = 20
    Align = alTop
    BevelOuter = bvNone
    Caption = '"Empresas Destino" dos pedidos selecionados '
    TabOrder = 5
  end
  object edtCodEmp: TEditFocus [6]
    Tag = 99
    Left = 93
    Top = 182
    Width = 70
    Height = 22
    Alignment = taLeftJustify
    CharCase = ecUpperCase
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    MaxLength = 3
    TabOrder = 1
    OnExit = edtCodEmpExit
    OnKeyPress = edtCodEmpKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = True
    TamCampo = 3
    TipoTexto = ttAlfanumerico
  end
  object edtNomEmp: TEditFocus [7]
    Left = 164
    Top = 182
    Width = 307
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    ReadOnly = True
    TabOrder = 6
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 64
    Top = 64
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 400
    Top = 64
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 280
    Top = 72
  end
  object dtsCadEmp: TDataSource
    Left = 408
    Top = 120
  end
end
