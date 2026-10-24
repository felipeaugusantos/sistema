inherited frmFatGeracaoMultiplasOS: TfrmFatGeracaoMultiplasOS
  Width = 716
  Height = 416
  BorderIcons = [biSystemMenu]
  Caption = 'Gera'#231#227'o de m'#250'ltiplas ordens de servi'#231'o'
  Position = poScreenCenter
  ExplicitWidth = 716
  ExplicitHeight = 416
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 342
    Width = 710
    ExplicitTop = 342
    ExplicitWidth = 710
    inherited FlwBotoes: TFlowPanel
      Width = 706
      ExplicitWidth = 706
    end
  end
  inherited pnlStatus: TPanel
    Top = 371
    Width = 710
    ExplicitTop = 371
    ExplicitWidth = 710
    inherited pnlNomeForm: TPanel
      Left = 539
      ExplicitLeft = 539
    end
    inherited pnlInfo: TPanel
      Width = 539
      ExplicitWidth = 539
    end
  end
  inherited pgcDados: TPageControl
    Left = 683
    Top = 32
    Width = 78
    Height = 57
    Align = alNone
    Visible = False
    ExplicitLeft = 683
    ExplicitTop = 32
    ExplicitWidth = 78
    ExplicitHeight = 57
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 70
      ExplicitHeight = 25
    end
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 342
    Width = 710
    Height = 29
    Align = alBottom
    Anchors = []
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Color = clGray
    ParentBackground = False
    TabOrder = 3
    object FlwPnlButtons: TFlowPanel
      Left = 2
      Top = 2
      Width = 706
      Height = 25
      Align = alClient
      BevelOuter = bvNone
      ShowCaption = False
      TabOrder = 0
      object btnConfirmar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 113
        Height = 22
        Caption = '[F10] Confirmar'
        TabOrder = 0
        OnClick = btnConfirmarClick
      end
    end
    object btnCancelar: TBitBtnLocked
      Left = 592
      Top = 2
      Width = 113
      Height = 22
      Caption = '[Esc] Cancelar'
      TabOrder = 1
      OnClick = btnCancelarClick
    end
  end
  object dbgGridEquOS: TDBGridCitel [4]
    Left = 0
    Top = 50
    Width = 710
    Height = 292
    Align = alClient
    DataSource = dtsGrid
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 4
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnKeyPress = dbgGridEquOSKeyPress
    CorZebra = cl3DLight
    Zebra = True
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'SEQUEN'
        ReadOnly = True
        Title.Caption = 'Seq.'
        Width = 46
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODEQU'
        ReadOnly = True
        Title.Caption = 'Equipamento'
        Width = 227
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CODMAR'
        ReadOnly = True
        Title.Caption = 'Marca'
        Width = 189
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NSERIE'
        Title.Caption = 'N'#186' S'#233'rie'
        Width = 107
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NUMPAT'
        Title.Caption = 'N'#186' Patrim'#244'nio'
        Width = 104
        Visible = True
      end>
  end
  object pnlTopo: TPanel [5]
    Left = 0
    Top = 0
    Width = 710
    Height = 50
    Align = alTop
    TabOrder = 5
    object Label1: TLabel
      Left = 16
      Top = 18
      Width = 125
      Height = 14
      Caption = 'N'#250'mero de Equipamentos:'
    end
    object edtQtdeOS: TEditFocus
      Left = 147
      Top = 15
      Width = 54
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 0
      OnKeyPress = edtQtdeOSKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttInteiro
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Top = 136
  end
  inherited ApplicationEvents: TApplicationEvents
    Top = 136
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 232
    Top = 136
  end
  object dtsGrid: TDataSource
    Left = 328
    Top = 136
  end
end
