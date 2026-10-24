object frmPontosImpressao: TfrmPontosImpressao
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'Pontos de Impress'#227'o'
  ClientHeight = 288
  ClientWidth = 291
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object dbgPonImp: TDBGridCitel
    Left = 0
    Top = 0
    Width = 291
    Height = 272
    Align = alClient
    DataSource = dtsPonImp
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnKeyDown = dbgPonImpKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'PON_NOMPON'
        Title.Caption = 'Ponto de Impress'#227'o'
        Width = 250
        Visible = True
      end>
  end
  object pnlStatus: TPanel
    Left = 0
    Top = 272
    Width = 291
    Height = 16
    Align = alBottom
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 1
    object pnlNomeForm: TPanel
      Left = 144
      Top = 0
      Width = 147
      Height = 16
      Align = alRight
      BevelInner = bvLowered
      ParentBackground = False
      PopupMenu = mnuAuxiliar
      TabOrder = 0
    end
    object pnlInfo: TPanel
      Left = 0
      Top = 0
      Width = 144
      Height = 16
      Align = alClient
      BevelInner = bvLowered
      ParentBackground = False
      TabOrder = 1
    end
  end
  object mnuAuxiliar: TPopupMenu
    Left = 104
    Top = 96
    object mnuConfigurarRel: TMenuItem
      Caption = 'Configurar Relat'#243'rio'
    end
  end
  object ApplicationEvents: TApplicationEvents
    Left = 176
    Top = 96
  end
  object dtsPonImp: TDataSource
    Left = 104
    Top = 192
  end
end
