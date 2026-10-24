inherited frmCadBandeiraEmpresa: TfrmCadBandeiraEmpresa
  Width = 534
  Height = 141
  Caption = 'Cadastro de Bandeiras das Empresas'
  ExplicitWidth = 534
  ExplicitHeight = 141
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 68
    Width = 528
    TabOrder = 1
    ExplicitTop = 64
    ExplicitWidth = 528
    inherited btnSair: TBitBtnLocked
      Left = 441
      ExplicitLeft = 441
    end
  end
  inherited pgcDados: TPageControl
    Width = 528
    Height = 68
    TabOrder = 3
    ExplicitWidth = 528
    ExplicitHeight = 64
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 520
      ExplicitHeight = 32
    end
  end
  inherited pnlStatus: TPanel
    Top = 96
    Width = 528
    TabOrder = 2
    ExplicitTop = 92
    ExplicitWidth = 528
    inherited pnlNomeForm: TPanel
      Left = 181
      ExplicitLeft = 181
    end
    inherited pnlInfo: TPanel
      Width = 181
      ExplicitWidth = 181
    end
  end
  object pnlDados: TPanel [4]
    Left = 0
    Top = 0
    Width = 528
    Height = 68
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    ExplicitHeight = 64
    object Label1: TLabel
      Left = 28
      Top = 12
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 12
      Top = 36
      Width = 52
      Height = 14
      Caption = 'Descri'#231#227'o:'
    end
    object lblCorBan: TLabel
      Left = 391
      Top = 10
      Width = 81
      Height = 14
      Cursor = crHandPoint
      Alignment = taRightJustify
      Caption = 'Cor da Bandeira:'
      FocusControl = dbeCorBan
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsUnderline]
      ParentFont = False
      OnClick = lblCorBanClick
    end
    object dbeCodBan: TDBEditFocus
      Tag = 99
      Left = 66
      Top = 8
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      DataField = 'BAN_CODBAN'
      DataSource = dtsTabela
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttNumerico
    end
    object dbeDesBan: TDBEditFocus
      Tag = 99
      Left = 66
      Top = 32
      Width = 450
      Height = 22
      CharCase = ecUpperCase
      DataField = 'BAN_DESBAN'
      DataSource = dtsTabela
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCorBan: TDBEditFocus
      Tag = 50
      Left = 478
      Top = 6
      Width = 31
      Height = 22
      DataField = 'BAN_CORBAN'
      DataSource = dtsTabela
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 1
      OnChange = dbeCorBanChange
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 480
    Top = 200
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 376
    Top = 128
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 288
    Top = 192
  end
  object dtsTabela: TDataSource
    OnDataChange = dtsTabelaDataChange
    Left = 208
    Top = 24
  end
  object cldCores: TColorDialog
    Left = 288
    Top = 16
  end
end
