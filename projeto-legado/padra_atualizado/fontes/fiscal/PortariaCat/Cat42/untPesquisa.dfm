object frmPesquisa: TfrmPesquisa
  Left = 263
  Top = 215
  BorderStyle = bsSingle
  Caption = 'Pesquisa'
  ClientHeight = 341
  ClientWidth = 570
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clNavy
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object Panel5: TPanel
    Left = 0
    Top = 0
    Width = 570
    Height = 289
    Align = alClient
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 242
      Top = 217
      Width = 114
      Height = 14
      Caption = 'Informa'#231#227'o a pesquisar'
    end
    object Label2: TLabel
      Left = 14
      Top = 218
      Width = 111
      Height = 14
      Caption = 'Campos para pesquisa'
    end
    object dbgPesq: TDBGrid
      Left = 11
      Top = 11
      Width = 548
      Height = 202
      Ctl3D = False
      DataSource = dtsTabela
      FixedColor = 16776176
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Pitch = fpFixed
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clActiveCaption
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Pitch = fpFixed
      TitleFont.Style = []
      OnKeyPress = dbgPesqKeyPress
    end
    object Epesq: TEdit
      Left = 241
      Top = 233
      Width = 318
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 1
      OnChange = EpesqChange
      OnEnter = EpesqEnter
      OnExit = EpesqExit
      OnKeyPress = EpesqKeyPress
    end
    object lbxCampos: TListBox
      Left = 12
      Top = 234
      Width = 219
      Height = 43
      ItemHeight = 14
      TabOrder = 2
    end
  end
  object pnlBotoes: TPanel
    Left = 0
    Top = 289
    Width = 570
    Height = 33
    Align = alBottom
    Color = 14869218
    TabOrder = 1
    object btnConfirma: TButton
      Left = 6
      Top = 4
      Width = 101
      Height = 25
      Caption = '&Confirmar'
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
    object btnSair: TButton
      Left = 464
      Top = 4
      Width = 101
      Height = 25
      Caption = '&Sair'
      TabOrder = 1
      OnClick = btnSairClick
    end
  end
  object pnlStatus: TPanel
    Left = 0
    Top = 322
    Width = 570
    Height = 19
    Align = alBottom
    Color = 16770261
    TabOrder = 2
    object pnlNomeForm: TPanel
      Left = 424
      Top = 1
      Width = 145
      Height = 17
      Align = alRight
      BevelOuter = bvLowered
      ParentColor = True
      TabOrder = 0
    end
    object pnlInfo: TPanel
      Left = 1
      Top = 1
      Width = 423
      Height = 17
      Align = alClient
      BevelOuter = bvLowered
      ParentColor = True
      TabOrder = 1
    end
  end
  object cdsTabela: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspTabela'
    Left = 413
    Top = 89
  end
  object dtsTabela: TDataSource
    DataSet = cdsTabela
    Left = 466
    Top = 90
  end
  object dspTabela: TDataSetProvider
    Left = 348
    Top = 88
  end
end
