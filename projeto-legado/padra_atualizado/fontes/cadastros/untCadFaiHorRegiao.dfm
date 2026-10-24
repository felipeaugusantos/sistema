inherited frmCadFaiHorRegiao: TfrmCadFaiHorRegiao
  Width = 333
  Height = 358
  Caption = 'Faixas de Hor'#225'rios Frete Regi'#227'o'
  Position = poMainFormCenter
  ExplicitWidth = 333
  ExplicitHeight = 358
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 283
    Width = 327
    Height = 30
    Enabled = True
    Visible = True
    ExplicitTop = 283
    ExplicitWidth = 327
    ExplicitHeight = 30
    inherited FlwBotoes: TFlowPanel
      Width = 323
      Height = 26
    end
    inherited btnSair: TBitBtnLocked
      Left = 246
      Top = 5
      TabOrder = 2
      ExplicitLeft = 246
      ExplicitTop = 5
    end
    object btnConfirma: TBitBtnLocked
      Left = 4
      Top = 5
      Width = 85
      Height = 22
      Caption = '[ F10 ] Confirma'
      Enabled = False
      TabOrder = 1
      OnClick = btnConfirmaClick
    end
  end
  inherited pgcDados: TPageControl
    Width = 327
    Height = 283
    ExplicitWidth = 327
    ExplicitHeight = 283
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 319
      ExplicitHeight = 251
    end
  end
  object pnlGeral: TPanel [3]
    Left = 0
    Top = 0
    Width = 327
    Height = 283
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object pnlDados: TPanel
      Left = 1
      Top = 1
      Width = 325
      Height = 64
      Align = alTop
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      DesignSize = (
        325
        64)
      object lbl1: TLabel
        Left = 55
        Top = 8
        Width = 52
        Height = 14
        Caption = 'Hora Inicial'
      end
      object Label1: TLabel
        Left = 139
        Top = 8
        Width = 48
        Height = 14
        Caption = 'Hora Final'
      end
      object edtHorIni: TMaskEditFocus
        Tag = 99
        Left = 55
        Top = 22
        Width = 44
        Height = 22
        AutoSize = False
        EditMask = '!99:99;1;_'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 0
        Text = '  :  '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtHorFin: TMaskEditFocus
        Tag = 99
        Left = 139
        Top = 22
        Width = 44
        Height = 22
        AutoSize = False
        EditMask = '!99:99;1;_'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 5
        TabOrder = 1
        Text = '  :  '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object btnInserir: TBitBtnLocked
        Left = 245
        Top = 21
        Width = 76
        Height = 25
        Anchors = [akTop, akRight]
        Caption = '&Inserir'
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333330000333333333333333333333333F33333333333
          00003333344333333333333333388F3333333333000033334224333333333333
          338338F3333333330000333422224333333333333833338F3333333300003342
          222224333333333383333338F3333333000034222A22224333333338F338F333
          8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
          33333338F83338F338F33333000033A33333A222433333338333338F338F3333
          0000333333333A222433333333333338F338F33300003333333333A222433333
          333333338F338F33000033333333333A222433333333333338F338F300003333
          33333333A222433333333333338F338F00003333333333333A22433333333333
          3338F38F000033333333333333A223333333333333338F830000333333333333
          333A333333333333333338330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
        TabOrder = 2
        OnClick = btnInserirClick
      end
    end
    object Panel1: TPanel
      Left = 1
      Top = 65
      Width = 325
      Height = 217
      Align = alClient
      TabOrder = 1
      object dbgHor: TcxGrid
        Left = 1
        Top = 1
        Width = 323
        Height = 215
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object dbgHorView: TcxGridDBTableView
          OnKeyDown = dbgHorViewKeyDown
          Navigator.Buttons.CustomButtons = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.GroupByBox = False
          object dbgHorViewHORINI: TcxGridDBColumn
            Caption = 'Hor'#225'rio Inicial'
            DataBinding.FieldName = 'FHO_HORINI'
            Width = 95
          end
          object dbgHorViewHORFIN: TcxGridDBColumn
            Caption = 'Hor'#225'rio Final'
            DataBinding.FieldName = 'FHO_HORFIN'
            Width = 95
          end
        end
        object dbgHorLevel1: TcxGridLevel
          GridView = dbgHorView
        end
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 313
    Width = 327
    ExplicitTop = 313
    ExplicitWidth = 327
    inherited pnlNomeForm: TPanel
      Left = 156
      ExplicitLeft = 156
    end
    inherited pnlInfo: TPanel
      Width = 156
      ExplicitWidth = 156
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 16
    Top = 120
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 48
    Top = 120
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 80
    Top = 120
  end
end
